"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const typeorm_1 = require("typeorm");
const fs = require("fs");
const path = require("path");
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
        const sqlPath = path.join(__dirname, 'product.seed.sql');
        const sql = fs.readFileSync(sqlPath, 'utf8');
        await dataSource.query(sql);
        console.log('Seed data inserted successfully');
    }
    catch (error) {
        console.error('Error seeding data:', error);
    }
    finally {
        await dataSource.destroy();
    }
}
seed();
//# sourceMappingURL=seed.js.map