-- ============================================================
-- Additional Sample Data for Hospital Management System
-- Adding 10 more records to each table
-- ============================================================

-- ============================================================
-- Additional Patients (10 records)
-- ============================================================
INSERT INTO PATIENT (name, gender, age, phone, address, email, registration_date) VALUES
('Arjun Kapoor', 'M', 34, '9123456810', '456 Lake View, Mumbai', 'arjun.kapoor@email.com', '2025-11-26'),
('Shalini Desai', 'F', 28, '9123456811', '789 Hill Road, Pune', 'shalini.desai@email.com', '2025-11-27'),
('Rohan Chatterjee', 'M', 52, '9123456812', '321 Park Avenue, Kolkata', 'rohan.chatterjee@email.com', '2025-11-28'),
('Priyanka Bose', 'F', 37, '9123456813', '654 Garden Street, Delhi', 'priyanka.bose@email.com', '2025-11-29'),
('Vivek Agarwal', 'M', 45, '9123456814', '987 Market Road, Jaipur', 'vivek.agarwal@email.com', '2025-11-30'),
('Anjali Saxena', 'F', 31, '9123456815', '147 Temple Road, Varanasi', 'anjali.saxena@email.com', '2025-12-01'),
('Kunal Mehta', 'M', 29, '9123456816', '258 Station Road, Ahmedabad', 'kunal.mehta@email.com', '2025-12-01'),
('Riya Sinha', 'F', 43, '9123456817', '369 Church Street, Chennai', 'riya.sinha@email.com', '2025-12-02'),
('Siddharth Roy', 'M', 38, '9123456818', '741 Beach Road, Goa', 'siddharth.roy@email.com', '2025-12-02'),
('Neha Pandey', 'F', 26, '9123456819', '852 River View, Lucknow', 'neha.pandey@email.com', '2025-12-03');

-- ============================================================
-- Additional Doctors (10 records)
-- ============================================================
INSERT INTO DOCTOR (name, specialization, phone, email, availability_status, consultation_fee) VALUES
('Dr. Vikram Malhotra', 'Cardiology', '9123456820', 'vikram.malhotra@hospital.com', 'Available', 1800.00),
('Dr. Simran Kaur', 'Pediatrics', '9123456821', 'simran.kaur@hospital.com', 'Available', 1100.00),
('Dr. Abhishek Jain', 'Orthopedics', '9123456822', 'abhishek.jain@hospital.com', 'Available', 1400.00),
('Dr. Meera Kulkarni', 'Dermatology', '9123456823', 'meera.kulkarni@hospital.com', 'Available', 950.00),
('Dr. Rahul Bhatt', 'Neurology', '9123456824', 'rahul.bhatt@hospital.com', 'Available', 2200.00),
('Dr. Pooja Arora', 'Gynecology', '9123456825', 'pooja.arora@hospital.com', 'Available', 1350.00),
('Dr. Karan Singh', 'General Surgery', '9123456826', 'karan.singh@hospital.com', 'On Leave', 1900.00),
('Dr. Divya Rao', 'Ophthalmology', '9123456827', 'divya.rao@hospital.com', 'Available', 1150.00),
('Dr. Nikhil Sharma', 'ENT', '9123456828', 'nikhil.sharma@hospital.com', 'Available', 1050.00),
('Dr. Sneha Gupta', 'Dentistry', '9123456829', 'sneha.gupta@hospital.com', 'Available', 850.00);

-- ============================================================
-- Additional Medicines (10 records)
-- ============================================================
INSERT INTO MEDICINE (medicine_name, category, price, stock_quantity, patient_id, prescribed_date, quantity_prescribed) VALUES
('Lisinopril 10mg', 'Antihypertensive', 160.00, 300, NULL, NULL, NULL),
('Simvastatin 20mg', 'Statin', 210.00, 250, NULL, NULL, NULL),
('Warfarin 5mg', 'Blood Thinner', 180.00, 200, NULL, NULL, NULL),
('Prednisone 10mg', 'Steroid', 130.00, 220, NULL, NULL, NULL),
('Albuterol Inhaler', 'Bronchodilator', 380.00, 150, NULL, NULL, NULL),
('Furosemide 40mg', 'Diuretic', 95.00, 280, NULL, NULL, NULL),
('Tramadol 50mg', 'Painkiller', 140.00, 190, NULL, NULL, NULL),
('Sertraline 50mg', 'Antidepressant', 250.00, 170, NULL, NULL, NULL),
('Hydrochlorothiazide 25mg', 'Diuretic', 85.00, 310, NULL, NULL, NULL),
('Alprazolam 0.5mg', 'Anxiolytic', 120.00, 160, NULL, NULL, NULL);

-- ============================================================
-- Additional Appointments (10 records - using existing patient and doctor IDs)
-- ============================================================
INSERT INTO APPOINTMENT (patient_id, doctor_id, appointment_date, appointment_time, status, notes) VALUES
(1, 1, '2025-12-06', '09:00:00', 'Scheduled', 'Heart checkup'),
(2, 2, '2025-12-06', '10:00:00', 'Scheduled', 'Child vaccination'),
(3, 3, '2025-12-06', '11:00:00', 'Scheduled', 'Joint pain'),
(4, 4, '2025-12-06', '14:00:00', 'Scheduled', 'Skin consultation'),
(5, 1, '2025-12-07', '09:30:00', 'Scheduled', 'Headache treatment'),
(6, 6, '2025-12-07', '10:30:00', 'Scheduled', 'Prenatal checkup'),
(7, 8, '2025-12-07', '11:30:00', 'Scheduled', 'Eye examination'),
(8, 9, '2025-12-07', '15:00:00', 'Scheduled', 'Ear infection'),
(9, 10, '2025-12-08', '09:00:00', 'Scheduled', 'Dental cleaning'),
(10, 1, '2025-12-08', '10:00:00', 'Scheduled', 'Follow-up consultation');

-- ============================================================
-- Verification Query
-- ============================================================
SELECT 
    'Data Added Successfully!' AS Status,
    (SELECT COUNT(*) FROM PATIENT) AS Total_Patients,
    (SELECT COUNT(*) FROM DOCTOR) AS Total_Doctors,
    (SELECT COUNT(*) FROM APPOINTMENT) AS Total_Appointments,
    (SELECT COUNT(*) FROM BILLING) AS Total_Bills,
    (SELECT COUNT(*) FROM MEDICINE) AS Total_Medicines;
