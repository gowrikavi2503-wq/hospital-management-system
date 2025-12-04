-- ============================================================
-- Hospital Patient Record Management System
-- Stored Procedures and Triggers
-- ============================================================

DELIMITER $$

-- ============================================================
-- STORED PROCEDURE 1: Register New Patient
-- Description: Validates and registers a new patient
-- ============================================================
DROP PROCEDURE IF EXISTS sp_RegisterPatient$$
CREATE PROCEDURE sp_RegisterPatient(
    IN p_name VARCHAR(100),
    IN p_gender ENUM('M', 'F', 'Other'),
    IN p_age INT,
    IN p_phone VARCHAR(15),
    IN p_address VARCHAR(255),
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Patient registration failed!' AS error_message;
    END;
    
    START TRANSACTION;
    
    -- Validate age
    IF p_age <= 0 OR p_age > 150 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid age. Age must be between 1 and 150.';
    END IF;
    
    -- Validate phone number (check if already exists)
    IF EXISTS (SELECT 1 FROM PATIENT WHERE phone = p_phone) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phone number already registered.';
    END IF;
    
    -- Insert new patient
    INSERT INTO PATIENT (name, gender, age, phone, address, email, registration_date)
    VALUES (p_name, p_gender, p_age, p_phone, p_address, p_email, CURRENT_DATE);
    
    -- Return the newly created patient details
    SELECT 
        patient_id,
        name,
        gender,
        age,
        phone,
        email,
        registration_date,
        'Patient registered successfully!' AS status
    FROM PATIENT
    WHERE patient_id = LAST_INSERT_ID();
    
    COMMIT;
END$$

-- ============================================================
-- STORED PROCEDURE 2: Book Appointment
-- Description: Books an appointment with validation
-- ============================================================
DROP PROCEDURE IF EXISTS sp_BookAppointment$$
CREATE PROCEDURE sp_BookAppointment(
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_appointment_date DATE,
    IN p_appointment_time TIME,
    IN p_notes TEXT
)
BEGIN
    DECLARE v_doctor_status VARCHAR(20);
    DECLARE v_conflict_count INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Appointment booking failed!' AS error_message;
    END;
    
    START TRANSACTION;
    
    -- Check if patient exists
    IF NOT EXISTS (SELECT 1 FROM PATIENT WHERE patient_id = p_patient_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Patient not found.';
    END IF;
    
    -- Check if doctor exists and is available
    SELECT availability_status INTO v_doctor_status
    FROM DOCTOR
    WHERE doctor_id = p_doctor_id;
    
    IF v_doctor_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Doctor not found.';
    END IF;
    
    IF v_doctor_status != 'Available' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Doctor is not available.';
    END IF;
    
    -- Check for appointment date in the past
    IF p_appointment_date < CURRENT_DATE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot book appointment in the past.';
    END IF;
    
    -- Check for time slot conflict
    SELECT COUNT(*) INTO v_conflict_count
    FROM APPOINTMENT
    WHERE doctor_id = p_doctor_id
      AND appointment_date = p_appointment_date
      AND appointment_time = p_appointment_time
      AND status IN ('Scheduled', 'Completed');
    
    IF v_conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Time slot already booked for this doctor.';
    END IF;
    
    -- Book the appointment
    INSERT INTO APPOINTMENT (patient_id, doctor_id, appointment_date, appointment_time, status, notes)
    VALUES (p_patient_id, p_doctor_id, p_appointment_date, p_appointment_time, 'Scheduled', p_notes);
    
    -- Return appointment details
    SELECT 
        a.appointment_id,
        p.name AS patient_name,
        d.name AS doctor_name,
        d.specialization,
        a.appointment_date,
        a.appointment_time,
        a.status,
        d.consultation_fee,
        'Appointment booked successfully!' AS message
    FROM APPOINTMENT a
    JOIN PATIENT p ON a.patient_id = p.patient_id
    JOIN DOCTOR d ON a.doctor_id = d.doctor_id
    WHERE a.appointment_id = LAST_INSERT_ID();
    
    COMMIT;
END$$

-- ============================================================
-- STORED PROCEDURE 3: Generate Bill
-- Description: Generates comprehensive bill for a patient
-- ============================================================
DROP PROCEDURE IF EXISTS sp_GenerateBill$$
CREATE PROCEDURE sp_GenerateBill(
    IN p_appointment_id INT
)
BEGIN
    DECLARE v_patient_id INT;
    DECLARE v_consultation_fee DECIMAL(10, 2);
    DECLARE v_medicine_cost DECIMAL(10, 2);
    DECLARE v_total_amount DECIMAL(10, 2);
    DECLARE v_appointment_date DATE;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Bill generation failed!' AS error_message;
    END;
    
    START TRANSACTION;
    
    -- Get appointment details
    SELECT 
        a.patient_id,
        d.consultation_fee,
        a.appointment_date
    INTO v_patient_id, v_consultation_fee, v_appointment_date
    FROM APPOINTMENT a
    JOIN DOCTOR d ON a.doctor_id = d.doctor_id
    WHERE a.appointment_id = p_appointment_id;
    
    IF v_patient_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Appointment not found.';
    END IF;
    
    -- Calculate medicine cost
    SELECT COALESCE(SUM(price * quantity_prescribed), 0)
    INTO v_medicine_cost
    FROM MEDICINE
    WHERE patient_id = v_patient_id
      AND prescribed_date = v_appointment_date;
    
    -- Calculate total amount
    SET v_total_amount = v_consultation_fee + v_medicine_cost;
    
    -- Check if bill already exists
    IF EXISTS (SELECT 1 FROM BILLING WHERE appointment_id = p_appointment_id) THEN
        -- Update existing bill
        UPDATE BILLING
        SET total_amount = v_total_amount,
            discharge_date = CURRENT_DATE
        WHERE appointment_id = p_appointment_id;
        
        SELECT 
            bill_id,
            patient_id,
            appointment_id,
            total_amount,
            payment_status,
            'Bill updated successfully!' AS message
        FROM BILLING
        WHERE appointment_id = p_appointment_id;
    ELSE
        -- Create new bill
        INSERT INTO BILLING (patient_id, appointment_id, total_amount, payment_status, discharge_date)
        VALUES (v_patient_id, p_appointment_id, v_total_amount, 'Pending', CURRENT_DATE);
        
        SELECT 
            bill_id,
            patient_id,
            appointment_id,
            total_amount,
            payment_status,
            'Bill generated successfully!' AS message
        FROM BILLING
        WHERE bill_id = LAST_INSERT_ID();
    END IF;
    
    COMMIT;
END$$

-- ============================================================
-- STORED PROCEDURE 4: Check Doctor Availability
-- Description: Returns available doctors for a specialization
-- ============================================================
DROP PROCEDURE IF EXISTS sp_DoctorAvailability$$
CREATE PROCEDURE sp_DoctorAvailability(
    IN p_specialization VARCHAR(100),
    IN p_appointment_date DATE
)
BEGIN
    SELECT 
        d.doctor_id,
        d.name,
        d.specialization,
        d.consultation_fee,
        d.availability_status,
        COUNT(a.appointment_id) AS booked_slots
    FROM DOCTOR d
    LEFT JOIN APPOINTMENT a ON d.doctor_id = a.doctor_id 
        AND a.appointment_date = p_appointment_date
        AND a.status = 'Scheduled'
    WHERE d.availability_status = 'Available'
      AND (p_specialization IS NULL OR d.specialization = p_specialization)
    GROUP BY d.doctor_id, d.name, d.specialization, d.consultation_fee, d.availability_status
    ORDER BY booked_slots, d.consultation_fee;
END$$

-- ============================================================
-- TRIGGER 1: Auto-Generate Bill on Appointment Completion
-- Description: Automatically creates a bill when appointment is completed
-- ============================================================
DROP TRIGGER IF EXISTS trg_AutoGenerateBill$$
CREATE TRIGGER trg_AutoGenerateBill
AFTER UPDATE ON APPOINTMENT
FOR EACH ROW
BEGIN
    DECLARE v_consultation_fee DECIMAL(10, 2);
    DECLARE v_medicine_cost DECIMAL(10, 2);
    DECLARE v_total_amount DECIMAL(10, 2);
    
    -- Only trigger when status changes to 'Completed'
    IF NEW.status = 'Completed' AND OLD.status != 'Completed' THEN
        
        -- Get consultation fee
        SELECT consultation_fee INTO v_consultation_fee
        FROM DOCTOR
        WHERE doctor_id = NEW.doctor_id;
        
        -- Calculate medicine cost
        SELECT COALESCE(SUM(price * quantity_prescribed), 0)
        INTO v_medicine_cost
        FROM MEDICINE
        WHERE patient_id = NEW.patient_id
          AND prescribed_date = NEW.appointment_date;
        
        -- Calculate total
        SET v_total_amount = v_consultation_fee + v_medicine_cost;
        
        -- Insert bill if not exists
        IF NOT EXISTS (SELECT 1 FROM BILLING WHERE appointment_id = NEW.appointment_id) THEN
            INSERT INTO BILLING (patient_id, appointment_id, total_amount, payment_status, discharge_date)
            VALUES (NEW.patient_id, NEW.appointment_id, v_total_amount, 'Pending', CURRENT_DATE);
        END IF;
    END IF;
END$$

-- ============================================================
-- TRIGGER 2: Auto-Update Appointment Status
-- Description: Updates appointment status based on date
-- ============================================================
DROP TRIGGER IF EXISTS trg_UpdateAppointmentStatus$$
CREATE TRIGGER trg_UpdateAppointmentStatus
BEFORE INSERT ON APPOINTMENT
FOR EACH ROW
BEGIN
    -- If appointment is in the past and status is Scheduled, set to No-Show
    IF NEW.appointment_date < CURRENT_DATE AND NEW.status = 'Scheduled' THEN
        SET NEW.status = 'No-Show';
    END IF;
END$$

-- ============================================================
-- TRIGGER 3: Update Doctor Availability
-- Description: Manages doctor availability based on appointments
-- ============================================================
DROP TRIGGER IF EXISTS trg_UpdateDoctorAvailability$$
CREATE TRIGGER trg_UpdateDoctorAvailability
AFTER INSERT ON APPOINTMENT
FOR EACH ROW
BEGIN
    DECLARE v_appointment_count INT;
    
    -- Count scheduled appointments for the doctor on the same date
    SELECT COUNT(*) INTO v_appointment_count
    FROM APPOINTMENT
    WHERE doctor_id = NEW.doctor_id
      AND appointment_date = NEW.appointment_date
      AND status = 'Scheduled';
    
    -- If doctor has more than 8 appointments in a day, mark as Busy
    IF v_appointment_count > 8 THEN
        UPDATE DOCTOR
        SET availability_status = 'Busy'
        WHERE doctor_id = NEW.doctor_id;
    END IF;
END$$

-- ============================================================
-- TRIGGER 4: Validate Medicine Stock on Prescription
-- Description: Checks medicine stock before prescription
-- ============================================================
DROP TRIGGER IF EXISTS trg_ValidateMedicineStock$$
CREATE TRIGGER trg_ValidateMedicineStock
BEFORE INSERT ON MEDICINE
FOR EACH ROW
BEGIN
    -- Only validate if this is a prescription (patient_id is not null)
    IF NEW.patient_id IS NOT NULL THEN
        IF NEW.quantity_prescribed > NEW.stock_quantity THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient medicine stock for prescription.';
        END IF;
        
        -- Reduce stock quantity when medicine is prescribed
        SET NEW.stock_quantity = NEW.stock_quantity - NEW.quantity_prescribed;
    END IF;
END$$

-- ============================================================
-- TRIGGER 5: Log Billing Updates
-- Description: Ensures payment date is set when status changes to Paid
-- ============================================================
DROP TRIGGER IF EXISTS trg_LogBillingPayment$$
CREATE TRIGGER trg_LogBillingPayment
BEFORE UPDATE ON BILLING
FOR EACH ROW
BEGIN
    -- Auto-set payment date when status changes to Paid
    IF NEW.payment_status = 'Paid' AND OLD.payment_status != 'Paid' THEN
        SET NEW.payment_date = CURRENT_DATE;
    END IF;
END$$

DELIMITER ;

-- ============================================================
-- Test the Stored Procedures and Triggers
-- ============================================================

-- Test 1: Register a new patient
-- CALL sp_RegisterPatient('Test Patient', 'M', 30, '8888888888', 'Test Address', 'test@email.com');

-- Test 2: Book an appointment
-- CALL sp_BookAppointment(1, 1, '2025-12-15', '11:00:00', 'Follow-up consultation');

-- Test 3: Generate bill
-- CALL sp_GenerateBill(1);

-- Test 4: Check doctor availability
-- CALL sp_DoctorAvailability('Cardiology', '2025-12-15');

-- Test 5: Trigger - Complete appointment and auto-generate bill
-- UPDATE APPOINTMENT SET status = 'Completed' WHERE appointment_id = 1;
-- SELECT * FROM BILLING WHERE appointment_id = 1;

SELECT 'Stored procedures and triggers created successfully!' AS Status;
