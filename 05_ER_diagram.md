# Hospital Patient Record Management System - ER Diagram

## Entity Relationship Diagram (Text Format)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    HOSPITAL PATIENT RECORD MANAGEMENT SYSTEM                 │
│                              Entity-Relationship Diagram                     │
└─────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────┐
│      PATIENT         │
├──────────────────────┤
│ PK patient_id        │──┐
│    name              │  │
│    gender            │  │
│    age               │  │ 1
│    phone (UNIQUE)    │  │
│    address           │  │
│    email (UNIQUE)    │  │
│    registration_date │  │
└──────────────────────┘  │
                          │
                          │ Has
                          │
                          │ N
                          ├──────────────────────┐
                          │                      │
                          │                      │
                          ▼                      ▼
            ┌────────────────────┐   ┌──────────────────────┐
            │   APPOINTMENT      │   │      BILLING         │
            ├────────────────────┤   ├──────────────────────┤
            │ PK appointment_id  │──▶│ PK bill_id           │
            │ FK patient_id      │   │ FK patient_id        │
            │ FK doctor_id       │   │ FK appointment_id    │
            │    appointment_date│   │    total_amount      │
            │    appointment_time│   │    payment_status    │
            │    status          │   │    payment_date      │
            │    notes           │   │    discharge_date    │
            │    created_at      │   │    created_at        │
            └────────────────────┘   └──────────────────────┘
                     ▲ N                       │ 1
                     │                         │
                     │                         │
                     │ Scheduled               │ Generates
                   1 │                         │
                     │                         ▼
            ┌────────────────────┐            (Business Logic)
            │      DOCTOR        │
            ├────────────────────┤
            │ PK doctor_id       │
            │    name            │
            │    specialization  │
            │    phone (UNIQUE)  │
            │    email (UNIQUE)  │
            │    availability_   │
            │      status        │
            │    consultation_   │
            │      fee           │
            └────────────────────┘


┌──────────────────────┐
│      PATIENT         │──┐
├──────────────────────┤  │
│ PK patient_id        │  │ 1
└──────────────────────┘  │
                          │
                          │ Prescribed
                          │
                          │ N
                          ▼
            ┌────────────────────┐
            │     MEDICINE       │
            ├────────────────────┤
            │ PK medicine_id     │
            │    medicine_name   │
            │    category        │
            │    price           │
            │    stock_quantity  │
            │ FK patient_id      │
            │    prescribed_date │
            │    quantity_       │
            │      prescribed    │
            └────────────────────┘
```

## Entity Descriptions

### 1. PATIENT Entity
**Purpose**: Stores all patient demographic and contact information

**Attributes**:
- `patient_id` (PK): Unique identifier for each patient
- `name`: Full name of the patient
- `gender`: Gender (M/F/Other)
- `age`: Age in years (validated: 1-150)
- `phone`: Contact number (unique constraint)
- `address`: Residential address
- `email`: Email address (unique constraint)
- `registration_date`: Date when patient registered

**Business Rules**:
- Phone number must be unique across all patients
- Email must be unique if provided
- Age must be between 1 and 150
- Registration date defaults to current date

---

### 2. DOCTOR Entity
**Purpose**: Stores doctor information and availability

**Attributes**:
- `doctor_id` (PK): Unique identifier for each doctor
- `name`: Full name of the doctor
- `specialization`: Medical specialization (Cardiology, Pediatrics, etc.)
- `phone`: Contact number (unique constraint)
- `email`: Email address (unique constraint)
- `availability_status`: Current status (Available/On Leave/Busy)
- `consultation_fee`: Fee charged per consultation

**Business Rules**:
- Phone and email must be unique
- Consultation fee must be non-negative
- Availability status defaults to 'Available'
- Status automatically updates to 'Busy' when appointments exceed threshold

---

### 3. APPOINTMENT Entity
**Purpose**: Manages scheduling of patient-doctor appointments

**Attributes**:
- `appointment_id` (PK): Unique identifier for each appointment
- `patient_id` (FK): References PATIENT
- `doctor_id` (FK): References DOCTOR
- `appointment_date`: Scheduled date
- `appointment_time`: Scheduled time
- `status`: Current status (Scheduled/Completed/Cancelled/No-Show)
- `notes`: Additional notes or symptoms
- `created_at`: Timestamp when appointment was created

**Business Rules**:
- Each doctor can have only one appointment per time slot
- Cannot book appointments in the past
- Status automatically set to 'No-Show' if past date and still 'Scheduled'
- Deleting a patient cascades to delete their appointments
- Deleting a doctor cascades to delete their appointments

---

### 4. BILLING Entity
**Purpose**: Tracks financial transactions and billing information

**Attributes**:
- `bill_id` (PK): Unique identifier for each bill
- `patient_id` (FK): References PATIENT
- `appointment_id` (FK): References APPOINTMENT (optional)
- `total_amount`: Total bill amount
- `payment_status`: Status (Pending/Paid/Partially Paid/Cancelled)
- `payment_date`: Date when payment was made
- `discharge_date`: Date when patient was discharged
- `created_at`: Timestamp when bill was created

**Business Rules**:
- Total amount must be non-negative
- Payment date is automatically set when status changes to 'Paid'
- Bill is auto-generated when appointment status changes to 'Completed'
- If appointment is deleted, appointment_id is set to NULL

---

### 5. MEDICINE Entity
**Purpose**: Manages medicine inventory and prescription records

**Attributes**:
- `medicine_id` (PK): Unique identifier for each medicine
- `medicine_name`: Name of the medicine
- `category`: Medicine category (Antibiotic, Painkiller, etc.)
- `price`: Price per unit
- `stock_quantity`: Available stock
- `patient_id` (FK): References PATIENT (null if not prescribed)
- `prescribed_date`: Date when prescribed
- `quantity_prescribed`: Quantity prescribed to patient

**Business Rules**:
- Price and stock quantity must be non-negative
- Stock is automatically reduced when medicine is prescribed
- Prescription fails if insufficient stock
- If patient is deleted, patient_id is set to NULL

---

## Relationships

### 1. PATIENT ─── APPOINTMENT (One-to-Many)
- **Cardinality**: One patient can have multiple appointments (1:N)
- **Foreign Key**: `APPOINTMENT.patient_id` → `PATIENT.patient_id`
- **Cascade**: ON DELETE CASCADE (deleting patient removes all appointments)
- **Business Logic**: A patient must exist before booking an appointment

### 2. DOCTOR ─── APPOINTMENT (One-to-Many)
- **Cardinality**: One doctor can have multiple appointments (1:N)
- **Foreign Key**: `APPOINTMENT.doctor_id` → `DOCTOR.doctor_id`
- **Cascade**: ON DELETE CASCADE (deleting doctor removes all appointments)
- **Business Logic**: Only available doctors can have new appointments booked

### 3. APPOINTMENT ─── BILLING (One-to-One/Many)
- **Cardinality**: One appointment typically has one bill (1:1), but can have multiple billing records
- **Foreign Key**: `BILLING.appointment_id` → `APPOINTMENT.appointment_id`
- **Cascade**: ON DELETE SET NULL (deleting appointment keeps bill record)
- **Business Logic**: Bill is auto-generated when appointment is completed

### 4. PATIENT ─── BILLING (One-to-Many)
- **Cardinality**: One patient can have multiple bills (1:N)
- **Foreign Key**: `BILLING.patient_id` → `PATIENT.patient_id`
- **Cascade**: ON DELETE CASCADE (deleting patient removes all bills)
- **Business Logic**: Direct link for patient billing history

### 5. PATIENT ─── MEDICINE (One-to-Many)
- **Cardinality**: One patient can have multiple medicine prescriptions (1:N)
- **Foreign Key**: `MEDICINE.patient_id` → `PATIENT.patient_id`
- **Cascade**: ON DELETE SET NULL (deleting patient keeps medicine inventory)
- **Business Logic**: Patient_id is null for inventory items, not null for prescriptions

---

## Database Design Principles

### Normalization
The database follows **Third Normal Form (3NF)**:

1. **First Normal Form (1NF)**
   - All attributes contain atomic values
   - Each column contains values of a single type
   - Each column has a unique name

2. **Second Normal Form (2NF)**
   - Meets 1NF requirements
   - All non-key attributes are fully dependent on the primary key
   - No partial dependencies exist

3. **Third Normal Form (3NF)**
   - Meets 2NF requirements
   - No transitive dependencies
   - Non-key attributes depend only on the primary key

### Indexing Strategy
Indexes are created on:
- **Primary Keys**: Automatic unique indexes
- **Foreign Keys**: Improve join performance
- **Frequently Searched Columns**: name, phone, appointment_date, status, specialization
- **Unique Constraints**: phone, email fields

### Data Integrity
- **Entity Integrity**: Primary keys ensure unique identification
- **Referential Integrity**: Foreign keys maintain relationships
- **Domain Integrity**: CHECK constraints validate data ranges
- **User-Defined Integrity**: Triggers enforce business rules

### Stored Procedures
1. `sp_RegisterPatient`: Validates and registers new patients
2. `sp_BookAppointment`: Books appointments with availability checks
3. `sp_GenerateBill`: Calculates and generates bills
4. `sp_DoctorAvailability`: Queries available doctors

### Triggers
1. `trg_AutoGenerateBill`: Auto-creates bill on appointment completion
2. `trg_UpdateAppointmentStatus`: Auto-updates appointment status based on date
3. `trg_UpdateDoctorAvailability`: Manages doctor availability
4. `trg_ValidateMedicineStock`: Validates and updates medicine stock
5. `trg_LogBillingPayment`: Auto-sets payment date when bill is paid

---

## Design Rationale

### Why This Schema?

1. **Separation of Concerns**
   - Patient data separate from medical records
   - Billing separate from appointments for flexibility
   - Medicine inventory independent of prescriptions

2. **Scalability**
   - Can easily add more specializations
   - Support for multiple appointments per patient
   - Flexible billing system

3. **Data Consistency**
   - Foreign key constraints prevent orphan records
   - Triggers ensure automated data integrity
   - Stored procedures provide consistent business logic

4. **Audit Trail**
   - Created_at timestamps track record creation
   - Status fields track entity lifecycle
   - Payment dates track financial transactions

5. **Performance**
   - Strategic indexing for common queries
   - Denormalization avoided to prevent update anomalies
   - Efficient join paths for common operations

### Future Enhancements
- Add WARD table for inpatient management
- Add LAB_TEST table for diagnostic tests
- Add INSURANCE table for insurance claims
- Add PRESCRIPTION table to separate from MEDICINE inventory
- Add STAFF table for nurses and administrative staff
- Add MEDICAL_RECORD table for detailed medical history
