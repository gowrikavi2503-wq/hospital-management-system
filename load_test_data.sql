-- Quick test data for billing feature
-- Insert a few patients
INSERT IGNORE INTO PATIENT (patient_id, name, gender, age, phone, address, email, registration_date) VALUES
(1, 'Rajesh Kumar', 'M', 45, '9876543210', '123 MG Road, Mumbai', 'rajesh@email.com', '2025-11-01'),
(2, 'Priya Sharma', 'F', 32, '9876543211', '456 Park Street, Delhi', 'priya@email.com', '2025-11-02'),
(3, 'Amit Patel', 'M', 28, '9876543212', '789 Brigade Road, Bangalore', 'amit@email.com', '2025-11-03');

-- Insert a few doctors
INSERT IGNORE INTO DOCTOR (doctor_id, name, specialization, phone, email, availability_status, consultation_fee) VALUES
(1, 'Dr. Ashok Mehta', 'Cardiology', '9123456780', 'ashok@hospital.com', 'Available', 1500.00),
(2, 'Dr. Sunita Rao', 'Pediatrics', '9123456781', 'sunita@hospital.com', 'Available', 1000.00),
(3, 'Dr. Rajiv Khanna', 'Orthopedics', '9123456782', 'rajiv@hospital.com', 'Available', 1200.00);

-- Insert test appointments
INSERT IGNORE INTO APPOINTMENT (appointment_id, patient_id, doctor_id, appointment_date, appointment_time, status, notes) VALUES
(1, 1, 1, '2025-12-01', '09:00:00', 'Completed', 'Regular heart checkup'),
(2, 2, 2, '2025-12-01', '10:00:00', 'Completed', 'Child vaccination'),
(3, 3, 3, '2025-12-02', '11:00:00', 'Scheduled', 'Knee pain consultation');

SELECT 'Test data loaded!' AS Status;
SELECT COUNT(*) AS Patients FROM PATIENT;
SELECT COUNT(*) AS Doctors FROM DOCTOR;
SELECT COUNT(*) AS Appointments FROM APPOINTMENT;
