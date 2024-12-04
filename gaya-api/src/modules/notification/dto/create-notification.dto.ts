import { IsString, IsNotEmpty, IsEnum } from 'class-validator';

export enum NotificationType {
  ORDER = 'order',
  SYSTEM = 'system',
  PROMOTION = 'promotion',
}

export class CreateNotificationDto {
  @IsNotEmpty()
  @IsString()
  title: string;

  @IsNotEmpty()
  @IsString()
  message: string;

  @IsNotEmpty()
  @IsEnum(NotificationType)
  type: NotificationType;

  @IsNotEmpty()
  userId: number;
} 