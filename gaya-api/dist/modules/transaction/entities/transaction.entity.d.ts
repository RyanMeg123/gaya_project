import { User } from '../../user/entities/user.entity';
export declare class Transaction {
    id: number;
    user: User;
    title: string;
    amount: number;
    type: string;
    orderNumber: string;
    createdAt: Date;
    status: string;
}
