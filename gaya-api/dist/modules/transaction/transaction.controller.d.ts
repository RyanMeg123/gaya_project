import { TransactionService } from './transaction.service';
import { CreateTransactionDto } from './dto/create-transaction.dto';
export declare class TransactionController {
    private readonly transactionService;
    constructor(transactionService: TransactionService);
    create(createTransactionDto: CreateTransactionDto): Promise<import("./entities/transaction.entity").Transaction>;
    findByUserId(userId: string): Promise<import("./entities/transaction.entity").Transaction[]>;
    findByOrderNumber(orderNumber: string): Promise<import("./entities/transaction.entity").Transaction>;
}
