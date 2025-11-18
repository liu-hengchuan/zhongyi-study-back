-- 插入初始用户数据
INSERT INTO user (username, password, phone, email, create_time, update_time) VALUES
('admin', '123456', '13800138000', 'admin@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user1', '123456', '13800138001', 'user1@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
