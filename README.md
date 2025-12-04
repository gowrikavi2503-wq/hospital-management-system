# Hospital Patient Record Management System

A comprehensive SQL database system for managing hospital patient records, appointments, billing, and medicine inventory.

## 📋 Project Overview

This project implements a complete hospital management database with the following features:
- Patient registration and demographic tracking
- Doctor management with specialization
- Appointment scheduling and tracking
- Automated billing system
- Medicine inventory and prescription management
- Stored procedures for common operations
- Triggers for automated workflows

## 🗂️ Database Schema

The system consists of **5 core tables**:

1. **PATIENT** - Patient demographics and contact information
2. **DOCTOR** - Doctor details, specialization, and availability
3. **APPOINTMENT** - Patient-doctor appointment scheduling
4. **BILLING** - Financial transactions and billing records
5. **MEDICINE** - Medicine inventory and prescription tracking

## 📁 Project Structure

```
demo4/
├── 01_schema.sql              # Database schema with tables and constraints
├── 02_sample_data.sql         # Sample data (20+ rows per table)
├── 03_queries.sql             # SQL queries for common operations
├── 04_procedures_triggers.sql # Stored procedures and triggers
├── 05_ER_diagram.md          # ER diagram and design documentation
└── README.md                  # This file
```

## 🚀 Getting Started

### Prerequisites
- MySQL 5.7+ or MariaDB 10.3+
- Database client (MySQL Workbench, DBeaver, or command line)

### Installation

1. **Create Database**
   ```sql
   CREATE DATABASE hospital_db;
   USE hospital_db;
   ```

2. **Execute SQL Files in Order**
   ```bash
   # Windows (PowerShell)
   Get-Content 01_schema.sql | mysql -u root -p hospital_db
   Get-Content 02_sample_data.sql | mysql -u root -p hospital_db
   Get-Content 03_queries.sql | mysql -u root -p hospital_db
   Get-Content 04_procedures_triggers.sql | mysql -u root -p hospital_db
   ```

   Or using MySQL command line:
   ```sql
   SOURCE C:/Users/gowri/OneDrive/Desktop/demo4/01_schema.sql;
   SOURCE C:/Users/gowri/OneDrive/Desktop/demo4/02_sample_data.sql;
   SOURCE C:/Users/gowri/OneDrive/Desktop/demo4/03_queries.sql;
   SOURCE C:/Users/gowri/OneDrive/Desktop/demo4/04_procedures_triggers.sql;
   ```

3. **Verify Installation**
   ```sql
   SHOW TABLES;
   SELECT COUNT(*) FROM PATIENT;
   SELECT COUNT(*) FROM DOCTOR;
   ```

## 📊 Sample Data

The database includes:
- ✅ 25 Patient records
- ✅ 20 Doctor records across various specializations
- ✅ 30 Appointment records with different statuses
- ✅ 25 Billing records
- ✅ 40 Medicine entries (inventory + prescriptions)

## 🔍 Key Features

### 1. Patient Registration
```sql
-- Register a new patient
CALL sp_RegisterPatient(
    'John Doe', 
    'M', 
    45, 
    '9876543299', 
    '123 Main Street', 
    'john.doe@email.com'
);
```

### 2. Appointment Booking
```sql
-- Book an appointment
CALL sp_BookAppointment(
    1,                    -- patient_id
    1,                    -- doctor_id (Cardiology)
    '2025-12-10',        -- appointment_date
    '10:00:00',          -- appointment_time
    'Regular checkup'    -- notes
);
```

### 3. Doctor Availability
```sql
-- Check available cardiologists for a specific date
CALL sp_DoctorAvailability('Cardiology', '2025-12-10');
```

### 4. Bill Generation
```sql
-- Generate bill for an appointment
CALL sp_GenerateBill(1);  -- appointment_id
```

### 5. Daily Patient Summary
```sql
-- Get today's patient summary
SELECT * FROM APPOINTMENT 
WHERE appointment_date = CURRENT_DATE;
```

## 🔧 Stored Procedures

| Procedure | Description |
|-----------|-------------|
| `sp_RegisterPatient` | Register new patient with validation |
| `sp_BookAppointment` | Book appointment with availability check |
| `sp_GenerateBill` | Generate comprehensive bill |
| `sp_DoctorAvailability` | Query available doctors by specialization |

## ⚡ Triggers

| Trigger | Event | Description |
|---------|-------|-------------|
| `trg_AutoGenerateBill` | After UPDATE on APPOINTMENT | Auto-creates bill when appointment completed |
| `trg_UpdateAppointmentStatus` | Before INSERT on APPOINTMENT | Auto-updates status for past appointments |
| `trg_UpdateDoctorAvailability` | After INSERT on APPOINTMENT | Marks doctor as busy when overbooked |
| `trg_ValidateMedicineStock` | Before INSERT on MEDICINE | Validates stock before prescription |
| `trg_LogBillingPayment` | Before UPDATE on BILLING | Auto-sets payment date when paid |

## 📈 Common Queries

### View All Patients
```sql
SELECT * FROM PATIENT ORDER BY registration_date DESC;
```

### Find Available Doctors
```sql
SELECT name, specialization, consultation_fee 
FROM DOCTOR 
WHERE availability_status = 'Available';
```

### Today's Appointments
```sql
SELECT 
    p.name AS patient_name,
    d.name AS doctor_name,
    a.appointment_time,
    a.status
FROM APPOINTMENT a
JOIN PATIENT p ON a.patient_id = p.patient_id
JOIN DOCTOR d ON a.doctor_id = d.doctor_id
WHERE a.appointment_date = CURRENT_DATE
ORDER BY a.appointment_time;
```

### Pending Bills
```sql
SELECT 
    p.name AS patient_name,
    b.total_amount,
    b.discharge_date
FROM BILLING b
JOIN PATIENT p ON b.patient_id = p.patient_id
WHERE b.payment_status = 'Pending'
ORDER BY b.discharge_date;
```

### Medicine Stock Alert
```sql
SELECT medicine_name, category, stock_quantity
FROM MEDICINE
WHERE stock_quantity < 200
ORDER BY stock_quantity;
```

## 🧪 Testing

### Test Patient Registration
```sql
CALL sp_RegisterPatient('Test Patient', 'F', 28, '9999999991', 'Test Address', 'test@email.com');
```

### Test Appointment Booking
```sql
CALL sp_BookAppointment(1, 1, '2025-12-15', '14:00:00', 'Follow-up visit');
```

### Test Auto-Bill Generation Trigger
```sql
-- Complete an appointment
UPDATE APPOINTMENT SET status = 'Completed' WHERE appointment_id = 1;

-- Verify bill was auto-generated
SELECT * FROM BILLING WHERE appointment_id = 1;
```

### Test Doctor Availability
```sql
CALL sp_DoctorAvailability('Cardiology', '2025-12-15');
```

## 🔐 Security Considerations

- Phone and email fields have UNIQUE constraints
- Foreign key constraints maintain referential integrity
- CHECK constraints validate data ranges
- Stored procedures prevent SQL injection
- Triggers enforce business rules automatically

## 📖 Documentation

For detailed information about the database design, relationships, and ER diagram, see [05_ER_diagram.md](file:///c:/Users/gowri/OneDrive/Desktop/demo4/05_ER_diagram.md)

## 🎯 Use Cases

1. **Hospital Administration**
   - Track patient registrations
   - Manage doctor schedules
   - Monitor appointment statuses

2. **Billing Department**
   - Generate patient bills
   - Track payment status
   - Calculate revenue

3. **Pharmacy**
   - Manage medicine inventory
   - Track prescriptions
   - Monitor stock levels

4. **Doctors**
   - View appointment schedule
   - Access patient history
   - Review consultation notes

## 🔄 Database Maintenance

### Backup Database
```bash
mysqldump -u root -p hospital_db > hospital_db_backup.sql
```

### Restore Database
```bash
mysql -u root -p hospital_db < hospital_db_backup.sql
```

### Clear All Data (Keep Schema)
```sql
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE MEDICINE;
TRUNCATE TABLE BILLING;
TRUNCATE TABLE APPOINTMENT;
TRUNCATE TABLE DOCTOR;
TRUNCATE TABLE PATIENT;
SET FOREIGN_KEY_CHECKS = 1;
```

## 🚧 Future Enhancements

- [ ] Add WARD table for inpatient management
- [ ] Add LAB_TEST table for diagnostic tests
- [ ] Add INSURANCE table for insurance claims
- [ ] Implement role-based access control
- [ ] Add medical history tracking
- [ ] Create web-based frontend interface
- [ ] Implement SMS/Email notifications
- [ ] Generate PDF bills and reports

## 📝 License

This project is created for educational purposes.

## 👨‍💻 Author

Created as part of the Hospital Patient Record Management System project.

## 🆘 Support

For issues or questions:
1. Review the [ER Diagram documentation](file:///c:/Users/gowri/OneDrive/Desktop/demo4/05_ER_diagram.md)
2. Check the SQL comments in each file
3. Verify MySQL/MariaDB version compatibility

---

**Note**: Make sure to update the database connection credentials and paths according to your environment before executing the SQL files.
