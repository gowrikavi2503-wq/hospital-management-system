// ============================================================
// Express Server - Hospital Management System
// ============================================================

const express = require('express');
const cors = require('cors');
require('dotenv').config();

// Import routes
const patientsRouter = require('./routes/patients');
const doctorsRouter = require('./routes/doctors');
const appointmentsRouter = require('./routes/appointments');
const billingRouter = require('./routes/billing');
const medicinesRouter = require('./routes/medicines');

const app = express();
const PORT = process.env.PORT || 3000;

// ============================================================
// Middleware
// ============================================================
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Request logging
app.use((req, res, next) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
    next();
});

// ============================================================
// Routes
// ============================================================
app.get('/', (req, res) => {
    res.json({
        message: 'Hospital Management System API',
        version: '1.0.0',
        endpoints: {
            patients: '/api/patients',
            doctors: '/api/doctors',
            appointments: '/api/appointments',
            billing: '/api/billing',
            medicines: '/api/medicines'
        }
    });
});

app.use('/api/patients', patientsRouter);
app.use('/api/doctors', doctorsRouter);
app.use('/api/appointments', appointmentsRouter);
app.use('/api/billing', billingRouter);
app.use('/api/medicines', medicinesRouter);

// ============================================================
// Error Handling Middleware
// ============================================================
app.use((err, req, res, next) => {
    console.error('Error:', err);

    const statusCode = err.statusCode || 500;
    const message = err.message || 'Internal Server Error';

    res.status(statusCode).json({
        success: false,
        error: message,
        ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
    });
});

// 404 Handler
app.use((req, res) => {
    res.status(404).json({
        success: false,
        error: 'Route not found'
    });
});

// ============================================================
// Start Server
// ============================================================
app.listen(PORT, () => {
    console.log('='.repeat(50));
    console.log('🏥 Hospital Management System API Server');
    console.log('='.repeat(50));
    console.log(`✅ Server running on http://localhost:${PORT}`);
    console.log(`📅 Started at: ${new Date().toLocaleString()}`);
    console.log('='.repeat(50));
});

module.exports = app;
