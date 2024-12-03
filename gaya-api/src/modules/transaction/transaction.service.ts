import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Transaction } from './entities/transaction.entity';
import { CreateTransactionDto } from './dto/create-transaction.dto';

@Injectable()
export class TransactionService {
  constructor(
    @InjectRepository(Transaction)
    private transactionRepository: Repository<Transaction>,
  ) {}

  async create(createTransactionDto: CreateTransactionDto): Promise<Transaction> {
    const transaction = this.transactionRepository.create({
      user: { id: createTransactionDto.userId },
      title: 'Shopping',
      amount: createTransactionDto.amount,
      type: createTransactionDto.type,
      orderNumber: createTransactionDto.orderNumber,
      status: createTransactionDto.status || 'completed',
    });

    return this.transactionRepository.save(transaction);
  }

  async findByUserId(userId: number): Promise<Transaction[]> {
    return this.transactionRepository.find({
      where: { user: { id: userId } },
      order: { createdAt: 'DESC' },
      relations: ['user'],
    });
  }

  async findByOrderNumber(orderNumber: string): Promise<Transaction | null> {
    return this.transactionRepository.findOne({
      where: { orderNumber },
      relations: ['user'],
    });
  }
} 