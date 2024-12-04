import { NestFactory } from '@nestjs/core';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // 允许所有来源的 CORS 请求
  app.enableCors({
    origin: true,
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true,
  });

  // 全局验证管道
  app.useGlobalPipes(new ValidationPipe());

  // Swagger配置
  const config = new DocumentBuilder()
    .setTitle('Gaya API')
    .setDescription('The Gaya API description')
    .setVersion('1.0')
    .addBearerAuth()
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  // 监听所有网络接口
  await app.listen(3000, '0.0.0.0');
  console.log(`Application is running on: http://localhost:3000`);
}
bootstrap();
