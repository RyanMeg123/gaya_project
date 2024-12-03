import { Controller, Post, Get, Body, Param, UseGuards } from '@nestjs/common';
import { TransactionService } from './transaction.service';
import { CreateTransactionDto } from './dto/create-transaction.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';

@ApiTags('transactions')
@Controller('transactions')
@UseGuards(JwtAuthGuard)
export class TransactionController {
  constructor(private readonly transactionService: TransactionService) {}

  @Post()
  @ApiOperation({ summary: 'Create transaction' })
  create(@Body() createTransactionDto: CreateTransactionDto) {
    return this.transactionService.create(createTransactionDto);
  }

  @Get('user/:userId')
  @ApiOperation({ summary: 'Get user transactions' })
  findByUserId(@Param('userId') userId: string) {
    return this.transactionService.findByUserId(+userId);
  }

  @Get('order/:orderNumber')
  @ApiOperation({ summary: 'Get transaction by order number' })
  findByOrderNumber(@Param('orderNumber') orderNumber: string) {
    return this.transactionService.findByOrderNumber(orderNumber);
  }
} 