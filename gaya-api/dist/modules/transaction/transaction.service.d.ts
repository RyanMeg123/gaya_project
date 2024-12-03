import { Repository } from 'typeorm';
import { Transaction } from './entities/transaction.entity';
import { CreateTransactionDto } from './dto/create-transaction.dto';
export declare class TransactionService {
    private transactionRepository;
    constructor(transactionRepository: Repository<Transaction>);
    create(createTransactionDto: CreateTransactionDto): Promise<Transaction>;
    findByUserId(userId: number): Promise<Transaction[]>;
    findByOrderNumber(orderNumber: string): Promise<Transaction | null>;
}
