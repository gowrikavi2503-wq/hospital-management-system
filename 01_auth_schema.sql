-- ============================================================
-- Authentication Schema - Users Table
-- ============================================================

USE hospital_db;

-- Create USERS table
CREATE TABLE IF NOT EXISTS USERS (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'staff',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    INDEX idx_username (username),
    INDEX idx_email (email)
);

-- ============================================================
-- Stored Procedure: Register New User
-- ============================================================
DELIMITER //

CREATE PROCEDURE sp_RegisterUser(
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_password_hash VARCHAR(255),
    IN p_full_name VARCHAR(100),
    IN p_role VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Insert new user
    INSERT INTO USERS (username, email, password_hash, full_name, role)
    VALUES (p_username, p_email, p_password_hash, p_full_name, p_role);
    
    -- Return the created user
    SELECT 
        user_id,
        username,
        email,
        full_name,
        role,
        created_at
    FROM USERS
    WHERE user_id = LAST_INSERT_ID();
    
    COMMIT;
END //

DELIMITER ;

-- ============================================================
-- Stored Procedure: Update Last Login
-- ============================================================
DELIMITER //

CREATE PROCEDURE sp_UpdateLastLogin(
    IN p_user_id INT
)
BEGIN
    UPDATE USERS
    SET last_login = CURRENT_TIMESTAMP
    WHERE user_id = p_user_id;
END //

DELIMITER ;
