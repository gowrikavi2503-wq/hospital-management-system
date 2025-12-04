-- ============================================================
-- Hospital Patient Record Management System
-- Sample Data Insertion
-- ============================================================

-- ============================================================
-- Insert Sample Data into PATIENT Table (25 records)
-- ============================================================
INSERT INTO PATIENT (name, gender, age, phone, address, email, registration_date) VALUES
('Rajesh Kumar', 'M', 45, '9876543210', '123 MG Road, Mumbai', 'rajesh.kumar@email.com', '2025-11-01'),
('Priya Sharma', 'F', 32, '9876543211', '456 Park Street, Delhi', 'priya.sharma@email.com', '2025-11-02'),
('Amit Patel', 'M', 28, '9876543212', '789 Brigade Road, Bangalore', 'amit.patel@email.com', '2025-11-03'),
('Sneha Reddy', 'F', 41, '9876543213', '321 Necklace Road, Hyderabad', 'sneha.reddy@email.com', '2025-11-04'),
('Vikram Singh', 'M', 55, '9876543214', '654 Mall Road, Shimla', 'vikram.singh@email.com', '2025-11-05'),
('Ananya Iyer', 'F', 29, '9876543215', '987 Anna Salai, Chennai', 'ananya.iyer@email.com', '2025-11-06'),
('Rahul Verma', 'M', 38, '9876543216', '147 Park Road, Kolkata', 'rahul.verma@email.com', '2025-11-07'),
('Meera Nair', 'F', 50, '9876543217', '258 MG Road, Kochi', 'meera.nair@email.com', '2025-11-08'),
('Karthik Menon', 'M', 26, '9876543218', '369 Residency Road, Pune', 'karthik.menon@email.com', '2025-11-09'),
('Deepa Joshi', 'F', 44, '9876543219', '741 Civil Lines, Jaipur', 'deepa.joshi@email.com', '2025-11-10'),
('Suresh Babu', 'M', 62, '9876543220', '852 Tank Bund, Vizag', 'suresh.babu@email.com', '2025-11-11'),
('Lakshmi Devi', 'F', 35, '9876543221', '963 Jubilee Hills, Hyderabad', 'lakshmi.devi@email.com', '2025-11-12'),
('Naveen Kumar', 'M', 31, '9876543222', '159 Koramangala, Bangalore', 'naveen.kumar@email.com', '2025-11-13'),
('Kavita Singh', 'F', 27, '9876543223', '357 Connaught Place, Delhi', 'kavita.singh@email.com', '2025-11-14'),
('Arun Prasad', 'M', 48, '9876543224', '486 Banjara Hills, Hyderabad', 'arun.prasad@email.com', '2025-11-15'),
('Pooja Gupta', 'F', 33, '9876543225', '753 Salt Lake, Kolkata', 'pooja.gupta@email.com', '2025-11-16'),
('Manoj Tiwari', 'M', 39, '9876543226', '864 Indira Nagar, Bangalore', 'manoj.tiwari@email.com', '2025-11-17'),
('Rekha Pillai', 'F', 52, '9876543227', '975 Marine Drive, Mumbai', 'rekha.pillai@email.com', '2025-11-18'),
('Sandeep Rao', 'M', 42, '9876543228', '147 Jubilee Road, Jaipur', 'sandeep.rao@email.com', '2025-11-19'),
('Divya Krishnan', 'F', 30, '9876543229', '258 T Nagar, Chennai', 'divya.krishnan@email.com', '2025-11-20'),
('Ramesh Chand', 'M', 58, '9876543230', '369 Model Town, Ludhiana', 'ramesh.chand@email.com', '2025-11-21'),
('Swati Malhotra', 'F', 36, '9876543231', '741 Sector 17, Chandigarh', 'swati.malhotra@email.com', '2025-11-22'),
('Harish Babu', 'M', 25, '9876543232', '852 Whitefield, Bangalore', 'harish.babu@email.com', '2025-11-23'),
('Nisha Kapoor', 'F', 40, '9876543233', '963 Rajouri Garden, Delhi', 'nisha.kapoor@email.com', '2025-11-24'),
('Prakash Yadav', 'M', 47, '9876543234', '159 Hitech City, Hyderabad', 'prakash.yadav@email.com', '2025-11-25');

-- ============================================================
-- Insert Sample Data into DOCTOR Table (20 records)
-- ============================================================
INSERT INTO DOCTOR (name, specialization, phone, email, availability_status, consultation_fee) VALUES
('Dr. Ashok Mehta', 'Cardiology', '9123456780', 'ashok.mehta@hospital.com', 'Available', 1500.00),
('Dr. Sunita Rao', 'Pediatrics', '9123456781', 'sunita.rao@hospital.com', 'Available', 1000.00),
('Dr. Rajiv Khanna', 'Orthopedics', '9123456782', 'rajiv.khanna@hospital.com', 'Available', 1200.00),
('Dr. Kavya Nair', 'Dermatology', '9123456783', 'kavya.nair@hospital.com', 'Available', 900.00),
('Dr. Sanjay Desai', 'Neurology', '9123456784', 'sanjay.desai@hospital.com', 'On Leave', 2000.00),
('Dr. Preeti Sharma', 'Gynecology', '9123456785', 'preeti.sharma@hospital.com', 'Available', 1300.00),
('Dr. Mohan Reddy', 'General Surgery', '9123456786', 'mohan.reddy@hospital.com', 'Available', 1800.00),
('Dr. Anjali Verma', 'Ophthalmology', '9123456787', 'anjali.verma@hospital.com', 'Available', 1100.00),
('Dr. Vijay Kumar', 'ENT', '9123456788', 'vijay.kumar@hospital.com', 'Busy', 1000.00),
('Dr. Geeta Iyer', 'Dentistry', '9123456789', 'geeta.iyer@hospital.com', 'Available', 800.00),
('Dr. Ramesh Patel', 'Gastroenterology', '9123456790', 'ramesh.patel@hospital.com', 'Available', 1400.00),
('Dr. Shweta Mishra', 'Psychiatry', '9123456791', 'shweta.mishra@hospital.com', 'Available', 1600.00),
('Dr. Anil Joshi', 'Urology', '9123456792', 'anil.joshi@hospital.com', 'Available', 1500.00),
('Dr. Madhavi Singh', 'Radiology', '9123456793', 'madhavi.singh@hospital.com', 'Available', 1200.00),
('Dr. Krishna Murthy', 'Pulmonology', '9123456794', 'krishna.murthy@hospital.com', 'Available', 1300.00),
('Dr. Neha Chopra', 'Endocrinology', '9123456795', 'neha.chopra@hospital.com', 'On Leave', 1700.00),
('Dr. Sunil Gupta', 'Nephrology', '9123456796', 'sunil.gupta@hospital.com', 'Available', 1600.00),
('Dr. Ritu Bansal', 'Rheumatology', '9123456797', 'ritu.bansal@hospital.com', 'Available', 1400.00),
('Dr. Arvind Menon', 'Oncology', '9123456798', 'arvind.menon@hospital.com', 'Available', 2500.00),
('Dr. Pallavi Das', 'General Medicine', '9123456799', 'pallavi.das@hospital.com', 'Available', 700.00);

-- ============================================================
-- Insert Sample Data into APPOINTMENT Table (30 records)
-- ============================================================
INSERT INTO APPOINTMENT (patient_id, doctor_id, appointment_date, appointment_time, status, notes) VALUES
(1, 1, '2025-12-01', '09:00:00', 'Completed', 'Regular heart checkup'),
(2, 2, '2025-12-01', '10:00:00', 'Completed', 'Child vaccination'),
(3, 3, '2025-12-01', '11:00:00', 'Completed', 'Knee pain consultation'),
(4, 4, '2025-12-01', '14:00:00', 'Completed', 'Skin rash treatment'),
(5, 1, '2025-12-02', '09:30:00', 'Completed', 'Follow-up ECG'),
(6, 6, '2025-12-02', '10:30:00', 'Scheduled', 'Prenatal checkup'),
(7, 7, '2025-12-02', '11:30:00', 'Scheduled', 'Appendix consultation'),
(8, 8, '2025-12-02', '15:00:00', 'Scheduled', 'Eye examination'),
(9, 10, '2025-12-03', '09:00:00', 'Scheduled', 'Dental cleaning'),
(10, 3, '2025-12-03', '10:00:00', 'Scheduled', 'Back pain treatment'),
(11, 11, '2025-12-03', '11:00:00', 'Scheduled', 'Stomach pain'),
(12, 12, '2025-12-03', '14:00:00', 'Scheduled', 'Anxiety counseling'),
(13, 13, '2025-12-04', '09:30:00', 'Scheduled', 'Kidney stone consultation'),
(14, 14, '2025-12-04', '10:30:00', 'Scheduled', 'X-ray report discussion'),
(15, 15, '2025-12-04', '11:30:00', 'Scheduled', 'Breathing difficulty'),
(16, 1, '2025-12-04', '15:00:00', 'Cancelled', 'Patient cancelled'),
(17, 17, '2025-12-05', '09:00:00', 'Scheduled', 'Kidney function test'),
(18, 18, '2025-12-05', '10:00:00', 'Scheduled', 'Joint pain consultation'),
(19, 19, '2025-12-05', '11:00:00', 'Scheduled', 'Cancer screening'),
(20, 20, '2025-12-05', '14:00:00', 'Scheduled', 'Fever and cold'),
(1, 20, '2025-11-28', '09:00:00', 'Completed', 'Fever treatment'),
(3, 1, '2025-11-29', '10:00:00', 'Completed', 'Chest pain'),
(5, 7, '2025-11-29', '11:00:00', 'Completed', 'Abdominal pain'),
(7, 10, '2025-11-30', '09:30:00', 'Completed', 'Tooth extraction'),
(9, 3, '2025-11-30', '10:30:00', 'Completed', 'Fracture treatment'),
(11, 11, '2025-11-30', '14:00:00', 'No-Show', 'Patient did not show up'),
(13, 2, '2025-12-01', '15:00:00', 'Completed', 'Child consultation'),
(15, 4, '2025-12-01', '16:00:00', 'Completed', 'Skin allergy'),
(21, 1, '2025-12-02', '09:00:00', 'Scheduled', 'Heart checkup'),
(23, 3, '2025-12-03', '10:00:00', 'Scheduled', 'Sports injury');

-- ============================================================
-- Insert Sample Data into BILLING Table (25 records)
-- ============================================================
INSERT INTO BILLING (patient_id, appointment_id, total_amount, payment_status, payment_date, discharge_date) VALUES
(1, 1, 1500.00, 'Paid', '2025-12-01', '2025-12-01'),
(2, 2, 1200.00, 'Paid', '2025-12-01', '2025-12-01'),
(3, 3, 1800.00, 'Paid', '2025-12-01', '2025-12-01'),
(4, 4, 1300.00, 'Paid', '2025-12-01', '2025-12-01'),
(5, 5, 2200.00, 'Paid', '2025-12-02', '2025-12-02'),
(6, 6, 1300.00, 'Pending', NULL, NULL),
(7, 7, 2500.00, 'Pending', NULL, NULL),
(8, 8, 1500.00, 'Pending', NULL, NULL),
(9, 9, 1000.00, 'Pending', NULL, NULL),
(10, 10, 1700.00, 'Pending', NULL, NULL),
(11, 11, 1900.00, 'Pending', NULL, NULL),
(12, 12, 2100.00, 'Pending', NULL, NULL),
(13, 13, 2800.00, 'Pending', NULL, NULL),
(14, 14, 1600.00, 'Pending', NULL, NULL),
(15, 15, 1800.00, 'Pending', NULL, NULL),
(17, 17, 2000.00, 'Pending', NULL, NULL),
(18, 18, 1900.00, 'Pending', NULL, NULL),
(19, 19, 3500.00, 'Pending', NULL, NULL),
(20, 20, 1100.00, 'Pending', NULL, NULL),
(1, 21, 950.00, 'Paid', '2025-11-28', '2025-11-28'),
(3, 22, 2100.00, 'Paid', '2025-11-29', '2025-11-29'),
(5, 23, 2400.00, 'Paid', '2025-11-29', '2025-11-29'),
(7, 24, 1500.00, 'Paid', '2025-11-30', '2025-11-30'),
(9, 25, 2800.00, 'Paid', '2025-11-30', '2025-11-30'),
(13, 27, 1400.00, 'Paid', '2025-12-01', '2025-12-01');

-- ============================================================
-- Insert Sample Data into MEDICINE Table (40 records)
-- ============================================================
INSERT INTO MEDICINE (medicine_name, category, price, stock_quantity, patient_id, prescribed_date, quantity_prescribed) VALUES
('Paracetamol 500mg', 'Painkiller', 50.00, 500, 1, '2025-12-01', 10),
('Amoxicillin 250mg', 'Antibiotic', 120.00, 300, 1, '2025-12-01', 20),
('Cetirizine 10mg', 'Antihistamine', 80.00, 400, 2, '2025-12-01', 15),
('Ibuprofen 400mg', 'Anti-inflammatory', 90.00, 350, 3, '2025-12-01', 30),
('Aspirin 75mg', 'Blood Thinner', 60.00, 600, 5, '2025-12-02', 60),
('Metformin 500mg', 'Antidiabetic', 150.00, 250, NULL, NULL, NULL),
('Atorvastatin 10mg', 'Statin', 200.00, 200, 5, '2025-12-02', 30),
('Omeprazole 20mg', 'Antacid', 110.00, 450, 11, '2025-12-03', 30),
('Azithromycin 500mg', 'Antibiotic', 180.00, 180, NULL, NULL, NULL),
('Losartan 50mg', 'Antihypertensive', 140.00, 280, NULL, NULL, NULL),
('Vitamin D3', 'Supplement', 300.00, 500, 7, '2025-12-02', 30),
('Calcium Tablets', 'Supplement', 250.00, 400, 9, '2025-12-03', 60),
('Cough Syrup', 'Antitussive', 130.00, 150, 20, '2025-12-05', 1),
('Eye Drops', 'Ophthalmic', 170.00, 220, 8, '2025-12-02', 2),
('Insulin Injection', 'Antidiabetic', 800.00, 100, NULL, NULL, NULL),
('Salbutamol Inhaler', 'Bronchodilator', 350.00, 120, 15, '2025-12-04', 1),
('Ranitidine 150mg', 'Antacid', 95.00, 380, NULL, NULL, NULL),
('Diclofenac Gel', 'Topical Anti-inflammatory', 180.00, 200, 3, '2025-12-01', 1),
('Multivitamin', 'Supplement', 400.00, 600, NULL, NULL, NULL),
('Ciprofloxacin 500mg', 'Antibiotic', 160.00, 240, NULL, NULL, NULL),
('Prednisolone 5mg', 'Steroid', 120.00, 180, 4, '2025-12-01', 20),
('Folic Acid', 'Supplement', 70.00, 550, 6, '2025-12-02', 30),
('Iron Tablets', 'Supplement', 90.00, 480, 6, '2025-12-02', 30),
('Antacid Syrup', 'Antacid', 140.00, 200, 23, '2025-11-29', 1),
('Crocin Advance', 'Painkiller', 55.00, 700, 1, '2025-11-28', 10),
('Betadine Solution', 'Antiseptic', 110.00, 300, NULL, NULL, NULL),
('Clotrimazole Cream', 'Antifungal', 160.00, 150, 4, '2025-12-01', 1),
('Montelukast 10mg', 'Anti-allergic', 220.00, 200, 15, '2025-12-04', 30),
('Pantoprazole 40mg', 'Antacid', 130.00, 320, NULL, NULL, NULL),
('Gabapentin 300mg', 'Neuropathic Pain', 280.00, 140, NULL, NULL, NULL),
('Levothyroxine 50mcg', 'Thyroid Hormone', 190.00, 260, NULL, NULL, NULL),
('Amlodipine 5mg', 'Antihypertensive', 140.00, 290, NULL, NULL, NULL),
('Dolo 650', 'Painkiller', 60.00, 800, 20, '2025-12-05', 10),
('B-Complex Tablets', 'Supplement', 180.00, 450, NULL, NULL, NULL),
('Glycerine Suppository', 'Laxative', 90.00, 100, NULL, NULL, NULL),
('Hydrogen Peroxide', 'Antiseptic', 50.00, 250, NULL, NULL, NULL),
('Tetracycline Ointment', 'Antibiotic', 120.00, 180, NULL, NULL, NULL),
('Nasal Spray', 'Decongestant', 150.00, 170, NULL, NULL, NULL),
('Throat Lozenges', 'Demulcent', 80.00, 400, 20, '2025-12-05', 10),
('Calamine Lotion', 'Topical', 100.00, 220, NULL, NULL, NULL);

-- ============================================================
-- Data Insertion Complete
-- ============================================================
SELECT 'Sample data inserted successfully!' AS Status;
SELECT 
    (SELECT COUNT(*) FROM PATIENT) AS Total_Patients,
    (SELECT COUNT(*) FROM DOCTOR) AS Total_Doctors,
    (SELECT COUNT(*) FROM APPOINTMENT) AS Total_Appointments,
    (SELECT COUNT(*) FROM BILLING) AS Total_Bills,
    (SELECT COUNT(*) FROM MEDICINE) AS Total_Medicines;
