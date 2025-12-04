-- ============================================================
-- Hospital Patient Record Management System
-- Database Schema Definition
-- ============================================================

-- Drop existing tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS MEDICINE;
DROP TABLE IF EXISTS BILLING;
DROP TABLE IF EXISTS APPOINTMENT;
DROP TABLE IF EXISTS DOCTOR;
DROP TABLE IF EXISTS PATIENT;

-- ============================================================
-- Table: PATIENT
-- Description: Stores patient demographic and contact information
-- ============================================================
CREATE TABLE PATIENT (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    gender ENUM('M', 'F', 'Other') NOT NULL,
    age INT NOT NULL CHECK (age > 0 AND age < 150),
    phone VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(255),
    email VARCHAR(100) UNIQUE,
    registration_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    INDEX idx_patient_name (name),
    INDEX idx_patient_phone (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Table: DOCTOR
-- Description: Stores doctor information and availability
-- ============================================================
CREATE TABLE DOCTOR (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    availability_status ENUM('Available', 'On Leave', 'Busy') NOT NULL DEFAULT 'Available',
    consultation_fee DECIMAL(10, 2) NOT NULL CHECK (consultation_fee >= 0),
    INDEX idx_doctor_specialization (specialization),
    INDEX idx_doctor_availability (availability_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Table: APPOINTMENT
-- Description: Manages patient-doctor appointments
-- ============================================================
CREATE TABLE APPOINTMENT (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled', 'No-Show') NOT NULL DEFAULT 'Scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES DOCTOR(doctor_id) ON DELETE CASCADE,
    INDEX idx_appointment_date (appointment_date),
    INDEX idx_appointment_status (status),
    INDEX idx_patient_appointments (patient_id, appointment_date),
    INDEX idx_doctor_schedule (doctor_id, appointment_date, appointment_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Table: BILLING
-- Description: Tracks billing and payment information
-- ============================================================
CREATE TABLE BILLING (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    appointment_id INT,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    payment_status ENUM('Pending', 'Paid', 'Partially Paid', 'Cancelled') NOT NULL DEFAULT 'Pending',
    payment_date DATE,
    discharge_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES APPOINTMENT(appointment_id) ON DELETE SET NULL,
    INDEX idx_billing_status (payment_status),
    INDEX idx_billing_patient (patient_id),
    INDEX idx_billing_date (discharge_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Table: MEDICINE
-- Description: Stores medicine inventory and prescription details
-- ============================================================
CREATE TABLE MEDICINE (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    patient_id INT,
    prescribed_date DATE,
    quantity_prescribed INT DEFAULT 1 CHECK (quantity_prescribed > 0),
    FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id) ON DELETE SET NULL,
    INDEX idx_medicine_name (medicine_name),
    INDEX idx_medicine_category (category),
    INDEX idx_prescription (patient_id, prescribed_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Schema Creation Complete
-- ============================================================
SELECT 'Database schema created successfully!' AS Status;
