import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { AuthModule } from './modules/auth/auth.module';
import { UserModule } from './modules/user/user.module';
import { ProductModule } from './modules/product/product.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.dev.env',
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: '127.0.0.1',
        port: configService.get('mysql_server_port'),
        username: configService.get('root'),
        password: configService.get('password'),
        database: configService.get('gaya_db'),
        entities: [__dirname + '/**/*.entity{.ts,.js}'],
        synchronize: true,
        connectorPackage: 'mysql2',
        retryAttempts: 3,
        retryDelay: 3000,
        logging: true,
        autoLoadEntities: true,
      }),
      inject: [ConfigService],
    }),
    AuthModule,
    UserModule,
    ProductModule,
  ],
})
export class AppModule {}
