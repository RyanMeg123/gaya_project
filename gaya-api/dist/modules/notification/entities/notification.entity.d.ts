import { User } from '../../user/entities/user.entity';
export declare class Notification {
    id: number;
    title: string;
    message: string;
    isRead: boolean;
    type: string;
    user: User;
    userId: number;
    createdAt: Date;
}
