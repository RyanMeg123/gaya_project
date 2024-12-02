import { DataSource } from 'typeorm';
import * as fs from 'fs';
import * as path from 'path';

async function seed() {
  // 创建数据库连接
  const dataSource = new DataSource({
    type: 'mysql',
    host: '127.0.0.1',
    port: 3306,
    username: 'gaya_user',
    password: '123456',
    database: 'gaya_db',
  });

  try {
    // 初始化连接
    await dataSource.initialize();
    console.log('Connected to database');

    // 读取 SQL 文件
    const sqlPath = path.join(__dirname, 'product.seed.sql');
    const sql = fs.readFileSync(sqlPath, 'utf8');

    // 执行 SQL
    await dataSource.query(sql);
    console.log('Seed data inserted successfully');

  } catch (error) {
    console.error('Error seeding data:', error);
  } finally {
    // 关闭连接
    await dataSource.destroy();
  }
}

// 运行 seed
seed(); 