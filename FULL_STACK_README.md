# Hospital Management System - Full Stack Application

A complete, modern web application for managing hospital operations including patient records, doctor management, appointment scheduling, billing, and medicine inventory.

## 🎯 Project Overview

This full stack application consists of:
- **Backend**: Node.js + Express RESTful API
- **Frontend**: Vanilla HTML/CSS/JavaScript (Modern, Premium Design)
- **Database**: MySQL with existing schema (5 tables)
- **Features**: Complete CRUD operations, Dashboard analytics, Responsive design

## 📁 Project Structure

```
demo4/
├── backend/                    # Node.js Express Backend
│   ├── config/
│   │   └── database.js        # MySQL connection pool
│   ├── routes/
│   │   ├── patients.js        # Patient API endpoints
│   │   ├── doctors.js         # Doctor API endpoints
│   │   ├── appointments.js    # Appointment API endpoints
│   │   ├── billing.js         # Billing API endpoints
│   │   └── medicines.js       # Medicine API endpoints
│   ├── server.js             # Express server setup
│   ├── package.json          # Dependencies
│   └── .env.example          # Environment template
│
├── frontend/                  # Frontend Application
│   ├── css/
│   │   └── style.css         # Main stylesheet (premium design)
│   ├── js/
│   │   └── api.js            # API client & utilities
│   ├── index.html            # Dashboard
│   ├── patients.html         # Patient management
│   ├── doctors.html          # Doctor management (template)
│   ├── appointments.html     # Appointment scheduling (template)
│   ├── billing.html          # Billing dashboard (template)
│   └── medicines.html        # Medicine inventory (template)
│
└── SQL Files                  # Database schema & data
    ├── 01_schema.sql
    ├── 02_sample_data.sql
    ├── 03_queries.sql
    └── 04_procedures_triggers.sql
```

## 🚀 Getting Started

### Prerequisites

- **Node.js** 16+ and npm
- **MySQL** 5.7+ or MariaDB 10.3+
- Modern web browser (Chrome, Firefox, Edge)

### Installation

#### 1. Database Setup

```sql
-- Create database
CREATE DATABASE hospital_db;
USE hospital_db;

-- Run SQL files in order
SOURCE C:/Users/gowri/OneDrive/Desktop/demo4/01_schema.sql;
SOURCE C:/Users/gowri/OneDrive/Desktop/demo4/02_sample_data.sql;
SOURCE C:/Users/gowri/OneDrive/Desktop/demo4/03_queries.sql;
SOURCE C:/Users/gowri/OneDrive/Desktop/demo4/04_procedures_triggers.sql;
```

#### 2. Backend Setup

```bash
# Navigate to backend directory
cd backend

# Install dependencies
npm install

# Create .env file
copy .env.example .env

# Edit .env with your database credentials
# DB_HOST=localhost
# DB_USER=root
# DB_PASSWORD=your_password
# DB_NAME=hospital_db
# PORT=3000

# Start the server
npm run dev
```

The backend server will start on `http://localhost:3000`

#### 3. Frontend Setup

Simply open `frontend/index.html` in your web browser, or use a local server:

```bash
# Using Python (if installed)
cd frontend
python -m http.server 8080

# OR using Node.js http-server
npx http-server frontend -p 8080
```

Then navigate to `http://localhost:8080`

## 📊 Features

### ✅ Completed Features

#### 1. **Dashboard** (`index.html`)
- Statistics cards (Total Patients, Today's Appointments, Pending Bills, Low Stock)
- Today's appointments list
- Pending payments list
- 7-day appointment trend chart (Chart.js)
- Real-time data from API

#### 2. **Patient Management** (`patients.html`)
- ✅ View all patients with pagination
- ✅ Search patients by name/phone/email
- ✅ Add new patient (calls `sp_RegisterPatient` stored procedure)
- ✅ Edit patient information
- ✅ Delete patient
- ✅ View patient history
- ✅ Responsive table design

#### 3. **Backend API** (Fully Functional)
All endpoints implemented with:
- CRUD operations for all entities
- Integration with MySQL stored procedures
- Error handling and validation
- CORS enabled for frontend access

**API Endpoints:**

**Patients:**
- `GET /api/patients` - List with pagination & search
- `GET /api/patients/:id` - Get patient details
- `POST /api/patients` - Register patient (uses `sp_RegisterPatient`)
- `PUT /api/patients/:id` - Update patient
- `DELETE /api/patients/:id` - Delete patient
- `GET /api/patients/:id/history` - Get appointment history

**Doctors:**
- `GET /api/doctors` - List all doctors
- `GET /api/doctors/:id` - Get doctor details
- `POST /api/doctors` - Add new doctor
- `PUT /api/doctors/:id` - Update doctor
- `DELETE /api/doctors/:id` - Delete doctor
- `GET /api/doctors/available/:specialization` - Get available doctors (uses `sp_DoctorAvailability`)
- `GET /api/doctors/:id/schedule` - Get doctor schedule
- `GET /api/doctors/list/specializations` - List specializations

**Appointments:**
- `GET /api/appointments` - List with filters
- `GET /api/appointments/:id` - Get appointment details
- `POST /api/appointments` - Book appointment (uses `sp_BookAppointment`)
- `PUT /api/appointments/:id` - Update appointment
- `DELETE /api/appointments/:id` - Cancel appointment
- `GET /api/appointments/summary/daily` - Daily summary
- `GET /api/appointments/today/list` - Today's appointments

**Billing:**
- `GET /api/billing` - List all bills
- `GET /api/billing/:id` - Get bill details
- `POST /api/billing/generate/:appointmentId` - Generate bill (uses `sp_GenerateBill`)
- `PUT /api/billing/:id` - Update payment status
- `GET /api/billing/pending/list` - Get pending bills
- `GET /api/billing/revenue/stats` - Revenue statistics
- `DELETE /api/billing/:id` - Delete bill

**Medicines:**
- `GET /api/medicines` - List all medicines
- `GET /api/medicines/:id` - Get medicine details
- `POST /api/medicines` - Add new medicine
- `PUT /api/medicines/:id` - Update medicine
- `DELETE /api/medicines/:id` - Delete medicine
- `POST /api/medicines/prescribe` - Prescribe to patient
- `GET /api/medicines/low-stock/alert` - Low stock alert
- `GET /api/medicines/categories/list` - List categories
- `GET /api/medicines/prescriptions/:patientId` - Patient prescriptions

### 🔨 Template Pages (Ready for Expansion)

The following pages follow the same pattern as `patients.html`:
- `doctors.html` - Doctor management
- `appointments.html` - Appointment scheduling
- `billing.html` - Billing dashboard
- `medicines.html` - Medicine inventory

You can easily implement these by following the `patients.html` pattern.

## 🎨 Design Features

### Modern UI/UX
- ✨ Premium gradient cards with glassmorphism effects
- 🎨 Medical-themed color palette (blues, greens, organized)
- 📱 Fully responsive design (mobile, tablet, desktop)
- ⚡ Smooth animations and transitions
- 🔔 Toast notifications for user feedback
- 📊 Chart.js integration for analytics
- 🎯 Clean, professional typography

### Technical Features
- Connection pooling for database performance
- Promise-based async/await API calls
- Centralized error handling
- Form validation (frontend & backend)
- Loading states and spinners
- Modal dialogs for forms
- Pagination for large datasets
- Search and filter functionality

## 🧪 Testing

### Test Backend API

```bash
# Start backend server
cd backend
npm run dev

# Test endpoints (using curl or Postman)
curl http://localhost:3000/api/patients
curl http://localhost:3000/api/doctors
curl http://localhost:3000/api/appointments/today/list
```

### Test Frontend

1. Open `frontend/index.html` in browser
2. Verify dashboard loads with statistics
3. Navigate to Patients page
4. Test adding/editing/deleting a patient
5. Verify all data displays correctly

### Test Database Integration

```sql
-- Verify triggers work
UPDATE APPOINTMENT SET status = 'Completed' WHERE appointment_id = 1;
SELECT * FROM BILLING WHERE appointment_id = 1;

-- Test stored procedures via API
-- Register patient through frontend form
-- Book appointment through frontend
-- Generate bill through frontend
```

## 📖 Usage Guide

### 1. Adding a Patient
1. Navigate to Patients page
2. Click "Add New Patient"
3. Fill in the form
4. Click "Save Patient"
5. Patient is registered using `sp_RegisterPatient` stored procedure

### 2. Booking an Appointment
1. Navigate to Appointments page
2. Select patient and doctor
3. Choose date and time
4. System checks doctor availability
5. Appointment is booked using `sp_BookAppointment`

### 3. Generating a Bill
1. Navigate to Billing page
2. Select completed appointment
3. Click "Generate Bill"
4. Bill is auto-calculated using `sp_GenerateBill`
5. Includes consultation fee + medicines

### 4. Managing Medicine Inventory
1. Navigate to Medicines page
2. Add/update medicines
3. View low stock alerts
4. Prescribe to patients

## 🔧 Configuration

### Backend Environment Variables

Edit `backend/.env`:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=hospital_db
PORT=3000
NODE_ENV=development
```

### Frontend API Base URL

Edit `frontend/js/api.js` if backend URL changes:

```javascript
const API_BASE_URL = 'http://localhost:3000/api';
```

## 🛡️ Security Notes

**Current Implementation:**
- Input validation on frontend and backend
- SQL injection prevention via parameterized queries
- Error messages don't expose sensitive data

**For Production:**
- Add authentication/authorization (JWT)
- Implement user roles (Admin, Doctor, Receptionist)
- Enable HTTPS
- Add rate limiting
- Implement CSRF protection
- Add input sanitization

## 📊 Database Schema

The application uses 5 core tables:
1. **PATIENT** - Patient demographics
2. **DOCTOR** - Doctor information
3. **APPOINTMENT** - Appointment scheduling
4. **BILLING** - Financial records
5. **MEDICINE** - Inventory & prescriptions

See `05_ER_diagram.md` for detailed schema documentation.

## 🚧 Future Enhancements

- [ ] Implement remaining frontend pages (doctors, appointments, billing, medicines)
- [ ] Add user authentication & authorization
- [ ] Implement role-based access control
- [ ] Add PDF generation for bills & reports
- [ ] Email/SMS notifications
- [ ] Advanced analytics dashboard
- [ ] Dark mode toggle
- [ ] Export data to Excel/CSV
- [ ] Calendar view for appointments
- [ ] Print prescription functionality

## 🐛 Troubleshooting

### Backend won't start
- Check MySQL is running
- Verify database credentials in `.env`
- Ensure database `hospital_db` exists
- Run `npm install` to install dependencies

### Frontend can't connect to backend
- Verify backend is running on port 3000
- Check browser console for CORS errors
- Ensure `API_BASE_URL` is correct in `api.js`

### Database errors
- Verify all SQL files were executed in order
- Check stored procedures exist: `SHOW PROCEDURE STATUS WHERE Db = 'hospital_db';`
- Verify sample data loaded: `SELECT COUNT(*) FROM PATIENT;`

## 📝 License

This project is created for educational purposes.

## 👨‍💻 Development

### Adding New Features

1. **Backend**: Add routes in `backend/routes/`
2. **Frontend**: Add API calls in `frontend/js/api.js`
3. **UI**: Create HTML pages following `patients.html` pattern
4. **Styling**: Use existing CSS classes from `style.css`

### Code Structure

- Keep API calls in `api.js`
- Use consistent naming conventions
- Follow existing patterns for modals and tables
- Add error handling for all async operations

---

**Status**: ✅ Core features implemented and ready for use!

**Next Steps**: Expand template pages and add authentication.
