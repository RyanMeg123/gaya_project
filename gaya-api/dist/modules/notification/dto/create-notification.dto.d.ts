export declare enum NotificationType {
    ORDER = "order",
    SYSTEM = "system",
    PROMOTION = "promotion"
}
export declare class CreateNotificationDto {
    title: string;
    message: string;
    type: NotificationType;
    userId: number;
}
