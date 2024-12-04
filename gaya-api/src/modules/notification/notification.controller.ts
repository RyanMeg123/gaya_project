import { Controller, Get, Post, Patch, Param, Body, UseGuards, Request } from '@nestjs/common';
import { NotificationService } from './notification.service';
import { CreateNotificationDto } from './dto/create-notification.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { GetUser } from '../auth/decorators/get-user.decorator';

@Controller('notifications')
@UseGuards(JwtAuthGuard)
export class NotificationController {
  constructor(private readonly notificationService: NotificationService) {}

  @Get()
  async findAll(@GetUser() userId: number) {
    console.log('Getting notifications for user:', userId);
    const notifications = await this.notificationService.findAllForUser(userId);
    return notifications;
  }

  @Post()
  async create(@Body() createNotificationDto: CreateNotificationDto) {
    return this.notificationService.create(createNotificationDto);
  }

  @Patch(':id/read')
  async markAsRead(@Param('id') id: number, @GetUser() userId: number) {
    await this.notificationService.markAsRead(id, userId);
    return { message: 'Notification marked as read' };
  }

  @Patch('read-all')
  async markAllAsRead(@GetUser() userId: number) {
    await this.notificationService.markAllAsRead(userId);
    return { message: 'All notifications marked as read' };
  }

  @Get('unread-count')
  async getUnreadCount(@GetUser() userId: number) {
    return {
      count: await this.notificationService.getUnreadCount(userId),
    };
  }
} 