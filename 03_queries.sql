-- ============================================================
-- Hospital Patient Record Management System
-- SQL Queries for Common Operations
-- ============================================================

-- ============================================================
-- QUERY 1: Patient Registration
-- Description: Register a new patient in the system
-- ============================================================
-- Insert a new patient
INSERT INTO PATIENT (name, gender, age, phone, address, email, registration_date)
VALUES ('New Patient Name', 'M', 35, '9999999999', '123 New Address', 'newpatient@email.com', CURRENT_DATE);

-- Verify the registration
SELECT 
    patient_id,
    name,
    gender,
    age,
    phone,
    email,
    registration_date
FROM PATIENT
WHERE phone = '9999999999';

-- ============================================================
-- QUERY 2: Booking Appointment
-- Description: Book an appointment for a patient with a doctor
-- ============================================================
-- Check doctor availability first
SELECT 
    doctor_id,
    name,
    specialization,
    availability_status,
    consultation_fee
FROM DOCTOR
WHERE specialization = 'Cardiology'
  AND availability_status = 'Available';

-- Book the appointment
INSERT INTO APPOINTMENT (patient_id, doctor_id, appointment_date, appointment_time, status, notes)
VALUES (1, 1, '2025-12-10', '10:00:00', 'Scheduled', 'Regular checkup');

-- Confirm the booking
SELECT 
    a.appointment_id,
    p.name AS patient_name,
    d.name AS doctor_name,
    d.specialization,
    a.appointment_date,
    a.appointment_time,
    a.status
FROM APPOINTMENT a
JOIN PATIENT p ON a.patient_id = p.patient_id
JOIN DOCTOR d ON a.doctor_id = d.doctor_id
WHERE a.appointment_id = LAST_INSERT_ID();

-- ============================================================
-- QUERY 3: Doctor Availability
-- Description: Check available doctors by specialization
-- ============================================================
-- View all available doctors
SELECT 
    doctor_id,
    name,
    specialization,
    phone,
    email,
    consultation_fee,
    availability_status
FROM DOCTOR
WHERE availability_status = 'Available'
ORDER BY specialization, name;

-- Check doctors available for specific specialization
SELECT 
    d.doctor_id,
    d.name,
    d.specialization,
    d.consultation_fee,
    COUNT(a.appointment_id) AS upcoming_appointments
FROM DOCTOR d
LEFT JOIN APPOINTMENT a ON d.doctor_id = a.doctor_id 
    AND a.appointment_date >= CURRENT_DATE 
    AND a.status = 'Scheduled'
WHERE d.availability_status = 'Available'
  AND d.specialization = 'Cardiology'
GROUP BY d.doctor_id, d.name, d.specialization, d.consultation_fee
ORDER BY upcoming_appointments;

-- Doctor schedule for a specific date
SELECT 
    d.name AS doctor_name,
    d.specialization,
    a.appointment_time,
    p.name AS patient_name,
    a.status
FROM APPOINTMENT a
JOIN DOCTOR d ON a.doctor_id = d.doctor_id
JOIN PATIENT p ON a.patient_id = p.patient_id
WHERE a.appointment_date = '2025-12-03'
  AND d.doctor_id = 3
ORDER BY a.appointment_time;

-- ============================================================
-- QUERY 4: Bill Calculation
-- Description: Calculate total bill for a patient
-- ============================================================
-- Calculate bill for a specific appointment
SELECT 
    p.patient_id,
    p.name AS patient_name,
    d.name AS doctor_name,
    d.consultation_fee,
    COALESCE(SUM(m.price * m.quantity_prescribed), 0) AS medicine_cost,
    (d.consultation_fee + COALESCE(SUM(m.price * m.quantity_prescribed), 0)) AS total_bill
FROM APPOINTMENT a
JOIN PATIENT p ON a.patient_id = p.patient_id
JOIN DOCTOR d ON a.doctor_id = d.doctor_id
LEFT JOIN MEDICINE m ON p.patient_id = m.patient_id 
    AND m.prescribed_date = a.appointment_date
WHERE a.appointment_id = 1
GROUP BY p.patient_id, p.name, d.name, d.consultation_fee;

-- Get detailed billing information for a patient
SELECT 
    b.bill_id,
    p.name AS patient_name,
    a.appointment_date,
    d.name AS doctor_name,
    d.specialization,
    b.total_amount,
    b.payment_status,
    b.payment_date,
    b.discharge_date
FROM BILLING b
JOIN PATIENT p ON b.patient_id = p.patient_id
LEFT JOIN APPOINTMENT a ON b.appointment_id = a.appointment_id
LEFT JOIN DOCTOR d ON a.doctor_id = d.doctor_id
WHERE p.patient_id = 1
ORDER BY b.bill_id DESC;

-- Pending bills report
SELECT 
    b.bill_id,
    p.name AS patient_name,
    p.phone,
    b.total_amount,
    b.payment_status,
    DATEDIFF(CURRENT_DATE, b.discharge_date) AS days_pending
FROM BILLING b
JOIN PATIENT p ON b.patient_id = p.patient_id
WHERE b.payment_status IN ('Pending', 'Partially Paid')
ORDER BY days_pending DESC;

-- ============================================================
-- QUERY 5: Daily Patient Summary
-- Description: Generate daily summary of patient activities
-- ============================================================
-- Today's appointment summary
SELECT 
    a.appointment_date,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    COUNT(DISTINCT CASE WHEN a.status = 'Completed' THEN a.appointment_id END) AS completed,
    COUNT(DISTINCT CASE WHEN a.status = 'Scheduled' THEN a.appointment_id END) AS scheduled,
    COUNT(DISTINCT CASE WHEN a.status = 'Cancelled' THEN a.appointment_id END) AS cancelled,
    COUNT(DISTINCT CASE WHEN a.status = 'No-Show' THEN a.appointment_id END) AS no_shows,
    COUNT(DISTINCT a.patient_id) AS unique_patients,
    COUNT(DISTINCT a.doctor_id) AS doctors_consulted
FROM APPOINTMENT a
WHERE a.appointment_date = CURRENT_DATE
GROUP BY a.appointment_date;

-- Detailed daily patient summary
SELECT 
    a.appointment_time,
    p.name AS patient_name,
    p.age,
    p.gender,
    d.name AS doctor_name,
    d.specialization,
    a.status,
    a.notes
FROM APPOINTMENT a
JOIN PATIENT p ON a.patient_id = p.patient_id
JOIN DOCTOR d ON a.doctor_id = d.doctor_id
WHERE a.appointment_date = CURRENT_DATE
ORDER BY a.appointment_time;

-- Daily revenue summary
SELECT 
    DATE(b.payment_date) AS date,
    COUNT(b.bill_id) AS total_bills,
    SUM(CASE WHEN b.payment_status = 'Paid' THEN b.total_amount ELSE 0 END) AS total_revenue,
    SUM(CASE WHEN b.payment_status = 'Pending' THEN b.total_amount ELSE 0 END) AS pending_amount,
    AVG(CASE WHEN b.payment_status = 'Paid' THEN b.total_amount END) AS avg_bill_amount
FROM BILLING b
WHERE DATE(b.payment_date) = CURRENT_DATE
GROUP BY DATE(b.payment_date);

-- ============================================================
-- ADDITIONAL USEFUL QUERIES
-- ============================================================

-- Patient appointment history
SELECT 
    p.patient_id,
    p.name AS patient_name,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_visits,
    MAX(a.appointment_date) AS last_visit_date,
    SUM(b.total_amount) AS total_spent
FROM PATIENT p
LEFT JOIN APPOINTMENT a ON p.patient_id = a.patient_id
LEFT JOIN BILLING b ON a.appointment_id = b.appointment_id
WHERE p.patient_id = 1
GROUP BY p.patient_id, p.name;

-- Most visited doctors
SELECT 
    d.doctor_id,
    d.name AS doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments,
    AVG(d.consultation_fee) AS consultation_fee
FROM DOCTOR d
LEFT JOIN APPOINTMENT a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name, d.specialization
ORDER BY total_appointments DESC
LIMIT 10;

-- Medicine prescription summary
SELECT 
    m.medicine_name,
    m.category,
    COUNT(CASE WHEN m.patient_id IS NOT NULL THEN 1 END) AS times_prescribed,
    SUM(m.quantity_prescribed) AS total_quantity_prescribed,
    m.stock_quantity AS current_stock,
    m.price
FROM MEDICINE m
GROUP BY m.medicine_id, m.medicine_name, m.category, m.stock_quantity, m.price
HAVING times_prescribed > 0
ORDER BY times_prescribed DESC;

-- Low stock medicines alert
SELECT 
    medicine_id,
    medicine_name,
    category,
    stock_quantity,
    price
FROM MEDICINE
WHERE stock_quantity < 200
ORDER BY stock_quantity;

-- Weekly appointment trends
SELECT 
    DAYNAME(appointment_date) AS day_of_week,
    COUNT(appointment_id) AS total_appointments,
    COUNT(DISTINCT patient_id) AS unique_patients,
    COUNT(DISTINCT doctor_id) AS doctors_involved
FROM APPOINTMENT
WHERE appointment_date >= DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)
GROUP BY DAYNAME(appointment_date), DAYOFWEEK(appointment_date)
ORDER BY DAYOFWEEK(appointment_date);

-- Patient demographics report
SELECT 
    gender,
    CASE 
        WHEN age < 18 THEN 'Child (0-17)'
        WHEN age BETWEEN 18 AND 35 THEN 'Young Adult (18-35)'
        WHEN age BETWEEN 36 AND 55 THEN 'Middle Age (36-55)'
        ELSE 'Senior (56+)'
    END AS age_group,
    COUNT(*) AS patient_count
FROM PATIENT
GROUP BY gender, age_group
ORDER BY gender, age_group;
