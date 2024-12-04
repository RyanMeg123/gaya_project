import { NotificationService } from './notification.service';
import { CreateNotificationDto } from './dto/create-notification.dto';
export declare class NotificationController {
    private readonly notificationService;
    constructor(notificationService: NotificationService);
    findAll(userId: number): Promise<import("./entities/notification.entity").Notification[]>;
    create(createNotificationDto: CreateNotificationDto): Promise<import("./entities/notification.entity").Notification>;
    markAsRead(id: number, userId: number): Promise<{
        message: string;
    }>;
    markAllAsRead(userId: number): Promise<{
        message: string;
    }>;
    getUnreadCount(userId: number): Promise<{
        count: number;
    }>;
}
