SET FOREIGN_KEY_CHECKS=0;

-- 清空通知表
DELETE FROM notifications;

-- 插入订单相关通知
INSERT INTO notifications (title, message, type, userId, createdAt, isRead) VALUES
('Order Confirmed', 'Your order #12345 has been confirmed', 'order', 1, NOW() - INTERVAL 1 HOUR, false),
('Order Shipped', 'Your order #12345 has been shipped', 'order', 1, NOW() - INTERVAL 2 HOUR, false),
('Order Delivered', 'Your order #12344 has been delivered', 'order', 1, NOW() - INTERVAL 1 DAY, true),
('Order Completed', 'Your order #12343 has been completed', 'order', 1, NOW() - INTERVAL 2 DAY, true),

-- 插入系统通知
('System Maintenance', 'System maintenance scheduled tonight', 'system', 1, NOW() - INTERVAL 3 HOUR, false),
('Security Alert', 'New device login detected', 'system', 1, NOW() - INTERVAL 4 HOUR, false),
('Account Updated', 'Your account information has been updated', 'system', 1, NOW() - INTERVAL 3 DAY, true),
('New Feature', 'New payment feature is now available', 'system', 1, NOW() - INTERVAL 4 DAY, true),

-- 插入促销通知
('Flash Sale', 'All items 20% off today only', 'promotion', 1, NOW() - INTERVAL 5 HOUR, false),
('New Arrivals', 'Spring 2024 collection is here', 'promotion', 1, NOW() - INTERVAL 6 HOUR, false),
('Member Exclusive', 'Members get extra 5% off', 'promotion', 1, NOW() - INTERVAL 5 DAY, true),
('Clearance Sale', 'Up to 50% off on selected items', 'promotion', 1, NOW() - INTERVAL 6 DAY, true),

-- 插入更多订单通知
('New Order', 'Order #12346 has been placed', 'order', 1, NOW() - INTERVAL 7 HOUR, false),
('Order Update', 'Order #12346 is out for delivery', 'order', 1, NOW() - INTERVAL 8 HOUR, false),
('Order Cancelled', 'Order #12342 has been cancelled', 'order', 1, NOW() - INTERVAL 7 DAY, true),
('Refund Completed', 'Refund for order #12341 processed', 'order', 1, NOW() - INTERVAL 8 DAY, true),

-- 插入更多系统通知
('Account Security', 'Please update your password regularly', 'system', 1, NOW() - INTERVAL 9 HOUR, false),
('Verification Required', 'Please complete identity verification', 'system', 1, NOW() - INTERVAL 10 HOUR, false),
('System Update', 'System update completed successfully', 'system', 1, NOW() - INTERVAL 9 DAY, true),
('Privacy Policy', 'Our privacy policy has been updated', 'system', 1, NOW() - INTERVAL 10 DAY, true);

SET FOREIGN_KEY_CHECKS=1; 