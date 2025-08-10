-- Municipal Complaint Management System Database Initialization
-- This script creates the database schema and seeds initial data

USE municipal_complaints;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('CITIZEN', 'STAFF', 'ADMIN') NOT NULL DEFAULT 'CITIZEN',
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create departments table
CREATE TABLE IF NOT EXISTS departments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    contact_info TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create department_staff table for staff assignments
CREATE TABLE IF NOT EXISTS department_staff (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    department_id BIGINT NOT NULL,
    staff_id BIGINT NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_dept_staff (department_id, staff_id)
);

-- Create complaints table
CREATE TABLE IF NOT EXISTS complaints (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category ENUM('WATER', 'SANITATION', 'ROADS') NOT NULL,
    description TEXT NOT NULL,
    status ENUM('PENDING', 'IN_PROGRESS', 'RESOLVED', 'CLOSED') NOT NULL DEFAULT 'PENDING',
    priority ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT') NOT NULL DEFAULT 'MEDIUM',
    assigned_department_id BIGINT,
    assigned_to_id BIGINT,
    created_by BIGINT NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    resolved_date TIMESTAMP NULL,
    FOREIGN KEY (assigned_department_id) REFERENCES departments(id) ON DELETE SET NULL,
    FOREIGN KEY (assigned_to_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

-- Create comments table
CREATE TABLE IF NOT EXISTS comments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    complaint_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    user_role ENUM('CITIZEN', 'STAFF', 'ADMIN') NOT NULL,
    comment_text TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create notifications table
CREATE TABLE IF NOT EXISTS notifications (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    type ENUM('EMAIL', 'SMS') NOT NULL,
    message TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    delivery_status ENUM('PENDING', 'SENT', 'FAILED') NOT NULL DEFAULT 'PENDING',
    retry_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX idx_complaints_status ON complaints(status);
CREATE INDEX idx_complaints_category ON complaints(category);
CREATE INDEX idx_complaints_created_by ON complaints(created_by);
CREATE INDEX idx_complaints_assigned_dept ON complaints(assigned_department_id);
CREATE INDEX idx_comments_complaint_id ON comments(complaint_id);
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_status ON notifications(delivery_status);

-- Insert initial admin user (password: admin123)
INSERT INTO users (username, name, email, password, role, status) VALUES
('admin', 'System Administrator', 'admin@municipal.gov', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'ADMIN', 'ACTIVE');

-- Insert initial departments
INSERT INTO departments (name, description, contact_info) VALUES
('Water Works Department', 'Manages water supply, distribution, and maintenance', 'Phone: (555) 123-4567, Email: water@municipal.gov'),
('Sanitation Department', 'Handles waste collection, disposal, and street cleaning', 'Phone: (555) 123-4568, Email: sanitation@municipal.gov'),
('Roads and Transportation', 'Maintains roads, traffic signals, and public transportation', 'Phone: (555) 123-4569, Email: roads@municipal.gov');

-- Insert sample staff users (password: staff123)
INSERT INTO users (username, name, email, password, role, status) VALUES
('water_staff', 'John Waterman', 'john.water@municipal.gov', '$2a$10$8K1p/a0dL1LXMIgoEDFrwOe6K7c7ZxHp0VxVxVxVxVxVxVxVxVxVxV', 'STAFF', 'ACTIVE'),
('sanitation_staff', 'Sarah Cleaner', 'sarah.clean@municipal.gov', '$2a$10$8K1p/a0dL1LXMIgoEDFrwOe6K7c7ZxHp0VxVxVxVxVxVxVxVxVxVxV', 'STAFF', 'ACTIVE'),
('roads_staff', 'Mike Roadway', 'mike.road@municipal.gov', '$2a$10$8K1p/a0dL1LXMIgoEDFrwOe6K7c7ZxHp0VxVxVxVxVxVxVxVxVxVxV', 'STAFF', 'ACTIVE');

-- Insert sample citizen users (password: citizen123)
INSERT INTO users (username, name, email, password, role, status) VALUES
('citizen1', 'Alice Johnson', 'alice.johnson@email.com', '$2a$10$8K1p/a0dL1LXMIgoEDFrwOe6K7c7ZxHp0VxVxVxVxVxVxVxVxVxVxV', 'CITIZEN', 'ACTIVE'),
('citizen2', 'Bob Smith', 'bob.smith@email.com', '$2a$10$8K1p/a0dL1LXMIgoEDFrwOe6K7c7ZxHp0VxVxVxVxVxVxVxVxVxVxV', 'CITIZEN', 'ACTIVE'),
('citizen3', 'Carol Davis', 'carol.davis@email.com', '$2a$10$8K1p/a0dL1LXMIgoEDFrwOe6K7c7ZxHp0VxVxVxVxVxVxVxVxVxVxV', 'CITIZEN', 'ACTIVE');

-- Assign staff to departments
INSERT INTO department_staff (department_id, staff_id) VALUES
(1, 2), -- John Waterman to Water Works
(2, 3), -- Sarah Cleaner to Sanitation
(3, 4); -- Mike Roadway to Roads

-- Insert sample complaints
INSERT INTO complaints (category, description, status, priority, assigned_department_id, created_by) VALUES
('WATER', 'Water pressure is very low in the downtown area. Residents are experiencing difficulty with basic household activities.', 'PENDING', 'HIGH', 1, 5),
('SANITATION', 'Garbage collection was missed on Oak Street yesterday. Bins are overflowing and creating a health hazard.', 'IN_PROGRESS', 'MEDIUM', 2, 6),
('ROADS', 'Large pothole on Main Street near the intersection with 5th Avenue. It''s causing traffic delays and vehicle damage.', 'RESOLVED', 'URGENT', 3, 7),
('WATER', 'Water main leak reported on Elm Street. Water is pooling on the road surface.', 'PENDING', 'URGENT', 1, 5),
('SANITATION', 'Street cleaning schedule needs adjustment. Sidewalks are becoming dirty between cleanings.', 'PENDING', 'LOW', 2, 6);

-- Insert sample comments
INSERT INTO comments (complaint_id, user_id, user_role, comment_text) VALUES
(1, 5, 'CITIZEN', 'This issue started about 3 days ago and has been getting worse.'),
(1, 2, 'STAFF', 'Investigating the issue. Will check the main water line in the area.'),
(2, 6, 'CITIZEN', 'The garbage truck usually comes at 8 AM but didn''t show up yesterday.'),
(2, 3, 'STAFF', 'Apologies for the missed collection. Sending a truck today to clean up.'),
(3, 7, 'CITIZEN', 'This pothole is quite large and dangerous for vehicles.'),
(3, 4, 'STAFF', 'Pothole has been filled and road surface repaired. Issue resolved.'),
(4, 5, 'CITIZEN', 'Water is flowing onto the street and creating a safety hazard.'),
(5, 6, 'CITIZEN', 'Would appreciate more frequent cleaning, especially in high-traffic areas.');

-- Insert sample notifications
INSERT INTO notifications (user_id, type, message, delivery_status) VALUES
(5, 'EMAIL', 'Your water pressure complaint has been received and is being investigated.', 'SENT'),
(6, 'SMS', 'Your sanitation complaint has been assigned to our team. We will resolve it today.', 'SENT'),
(7, 'EMAIL', 'Your road complaint has been resolved. Thank you for reporting this issue.', 'SENT'),
(5, 'EMAIL', 'Your water main leak complaint has been received and marked as urgent.', 'PENDING'),
(6, 'SMS', 'Your street cleaning feedback has been noted and will be reviewed.', 'PENDING');

-- Update complaint statuses based on comments
UPDATE complaints SET status = 'IN_PROGRESS' WHERE id = 1;
UPDATE complaints SET status = 'IN_PROGRESS' WHERE id = 2;
UPDATE complaints SET status = 'RESOLVED', resolved_date = NOW() WHERE id = 3;

-- Create a view for complaint statistics
CREATE VIEW complaint_stats AS
SELECT 
    c.status,
    c.category,
    c.priority,
    COUNT(*) as count
FROM complaints c
GROUP BY c.status, c.category, c.priority;

-- Create a view for user activity
CREATE VIEW user_activity AS
SELECT 
    u.username,
    u.role,
    COUNT(c.id) as complaints_filed,
    COUNT(cm.id) as comments_made,
    u.created_at as joined_date
FROM users u
LEFT JOIN complaints c ON u.id = c.created_by
LEFT JOIN comments cm ON u.id = cm.user_id
GROUP BY u.id, u.username, u.role, u.created_at;

-- Grant permissions (adjust as needed for your MySQL setup)
-- GRANT ALL PRIVILEGES ON municipal_complaints.* TO 'municipal_user'@'%';
-- FLUSH PRIVILEGES;

-- Display summary of created data
SELECT 'Database initialization completed successfully!' as status;
SELECT COUNT(*) as total_users FROM users;
SELECT COUNT(*) as total_departments FROM departments;
SELECT COUNT(*) as total_complaints FROM complaints;
SELECT COUNT(*) as total_comments FROM comments;
SELECT COUNT(*) as total_notifications FROM notifications;