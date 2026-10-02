-- ====================================================================
-- Database Setup Script: UserHub - User Management Web Application
-- ====================================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS user_management;
USE user_management;

-- Create Users Table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    password VARCHAR(255) NOT NULL
);

-- Clean existing data for clean import
TRUNCATE TABLE users;

-- Insert Fictional Indian Demo / Sample Data
INSERT INTO users (name, email, phone, address, password) VALUES
('System Administrator', 'admin@userhub.com', '9876543210', 'Plot 42, Cyber Towers, HITEC City, Hyderabad, Telangana', 'admin123'),
('Ravi Kumar', 'ravi.kumar@example.com', '9848012345', '12-4-56, Banjara Hills, Hyderabad, Telangana', 'password123'),
('Priya Sharma', 'priya.sharma@example.com', '9880123456', '74/A, Indiranagar, Bengaluru, Karnataka', 'password123'),
('Arjun Reddy', 'arjun.reddy@example.com', '9701234567', '45-2-10, MG Road, Vijayawada, Andhra Pradesh', 'password123'),
('Sneha Patel', 'sneha.patel@example.com', '9825012345', '88, SG Highway, Ahmedabad, Gujarat', 'password123'),
('Karthik Rao', 'karthik.rao@example.com', '9444012345', '23, Anna Nagar, Chennai, Tamil Nadu', 'password123'),
('Ananya Iyer', 'ananya.iyer@example.com', '9845098765', '102, Koramangala 4th Block, Bengaluru, Karnataka', 'password123'),
('Rahul Verma', 'rahul.verma@example.com', '9811012345', '56, Connaught Place, New Delhi, Delhi', 'password123'),
('Lakshmi Devi', 'lakshmi.devi@example.com', '9849054321', '8-3-12, Alipiri Road, Tirupati, Andhra Pradesh', 'password123'),
('Suresh Babu', 'suresh.babu@example.com', '9848099887', '3-1-45, Main Bazaar, Kuppam, Andhra Pradesh', 'password123'),
('Divya Nair', 'divya.nair@example.com', '9847012345', '15, Marine Drive, Kochi, Kerala', 'password123');

-- Verify inserted data
SELECT id, name, email, phone, address FROM users;
