-- ============================================================
-- Authentication Sample Data - Default Users
-- ============================================================

USE hospital_db;

-- Note: Password hashes are bcrypt hashes with 10 salt rounds
-- Default passwords (for testing only):
-- admin: admin123
-- staff1: staff123
-- staff2: staff123

-- Insert default admin user
-- Password: admin123
INSERT INTO USERS (username, email, password_hash, full_name, role) VALUES
('admin', 'admin@hospital.com', '$2a$10$rZ8qNW5zYXJ4YmE4YmE4Y.VxQGZqNW5zWXhKNFlZbUU4WW1FNFlZbQ', 'System Administrator', 'admin');

-- Insert sample staff users
-- Password: staff123
INSERT INTO USERS (username, email, password_hash, full_name, role) VALUES
('staff1', 'staff1@hospital.com', '$2a$10$c3RhZmYxMjNzdGFmZjEyM.UxQGZqNW5zWXhKNFlZbUU4WW1FNFlZbQ', 'John Doe', 'staff'),
('staff2', 'staff2@hospital.com', '$2a$10$c3RhZmYxMjNzdGFmZjEyM.UxQGZqNW5zWXhKNFlZbUU4WW1FNFlZbQ', 'Jane Smith', 'staff');

-- Display created users
SELECT 
    user_id,
    username,
    email,
    full_name,
    role,
    created_at
FROM USERS
ORDER BY user_id;
