import { Repository } from 'typeorm';
import { Notification } from './entities/notification.entity';
import { CreateNotificationDto } from './dto/create-notification.dto';
export declare class NotificationService {
    private notificationRepository;
    constructor(notificationRepository: Repository<Notification>);
    create(createNotificationDto: CreateNotificationDto): Promise<Notification>;
    findAllForUser(userId: number): Promise<Notification[]>;
    markAsRead(id: number, userId: number): Promise<void>;
    markAllAsRead(userId: number): Promise<void>;
    getUnreadCount(userId: number): Promise<number>;
}
