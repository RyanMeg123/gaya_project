"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const typeorm_1 = require("typeorm");
async function seed() {
    const dataSource = new typeorm_1.DataSource({
        type: 'mysql',
        host: '127.0.0.1',
        port: 3306,
        username: 'gaya_user',
        password: '123456',
        database: 'gaya_db',
    });
    try {
        await dataSource.initialize();
        console.log('Connected to database');
        const insertSql = `
      INSERT INTO notifications (title, message, type, userId, createdAt, isRead) VALUES
      ('Order Confirmed', 'Your order #12345 has been confirmed', 'order', 2, NOW() - INTERVAL 1 HOUR, false),
      ('Order Shipped', 'Your order #12345 has been shipped', 'order', 2, NOW() - INTERVAL 2 HOUR, false),
      ('Order Delivered', 'Your order #12344 has been delivered', 'order', 2, NOW() - INTERVAL 1 DAY, true),
      ('Order Completed', 'Your order #12343 has been completed', 'order', 2, NOW() - INTERVAL 2 DAY, true),
      ('System Maintenance', 'System maintenance scheduled tonight', 'system', 2, NOW() - INTERVAL 3 HOUR, false),
      ('Security Alert', 'New device login detected', 'system', 2, NOW() - INTERVAL 4 HOUR, false),
      ('Account Updated', 'Your account information has been updated', 'system', 2, NOW() - INTERVAL 3 DAY, true),
      ('New Feature', 'New payment feature is now available', 'system', 2, NOW() - INTERVAL 4 DAY, true),
      ('Flash Sale', 'All items 20% off today only', 'promotion', 2, NOW() - INTERVAL 5 HOUR, false),
      ('New Arrivals', 'Spring 2024 collection is here', 'promotion', 2, NOW() - INTERVAL 6 HOUR, false),
      ('Member Exclusive', 'Members get extra 5% off', 'promotion', 2, NOW() - INTERVAL 5 DAY, true),
      ('Clearance Sale', 'Up to 50% off on selected items', 'promotion', 2, NOW() - INTERVAL 6 DAY, true),
      ('New Order', 'Order #12346 has been placed', 'order', 2, NOW() - INTERVAL 7 HOUR, false),
      ('Order Update', 'Order #12346 is out for delivery', 'order', 2, NOW() - INTERVAL 8 HOUR, false),
      ('Order Cancelled', 'Order #12342 has been cancelled', 'order', 2, NOW() - INTERVAL 7 DAY, true),
      ('Refund Completed', 'Refund for order #12341 processed', 'order', 2, NOW() - INTERVAL 8 DAY, true),
      ('Account Security', 'Please update your password regularly', 'system', 2, NOW() - INTERVAL 9 HOUR, false),
      ('Verification Required', 'Please complete identity verification', 'system', 2, NOW() - INTERVAL 10 HOUR, false),
      ('System Update', 'System update completed successfully', 'system', 2, NOW() - INTERVAL 9 DAY, true),
      ('Privacy Policy', 'Our privacy policy has been updated', 'system', 2, NOW() - INTERVAL 10 DAY, true)
    `;
        await dataSource.query(insertSql);
        console.log('New notifications inserted for user 2');
        const count = await dataSource.query('SELECT COUNT(*) as count FROM notifications WHERE userId = 2');
        console.log('Notification count for user 2:', count);
    }
    catch (error) {
        console.error('Error seeding data:', error);
    }
    finally {
        await dataSource.destroy();
    }
}
seed();
//# sourceMappingURL=seed-user2.js.map