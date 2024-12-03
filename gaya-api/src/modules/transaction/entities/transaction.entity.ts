import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, CreateDateColumn } from 'typeorm';
import { User } from '../../user/entities/user.entity';

@Entity('transactions')
export class Transaction {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User)
  user: User;

  @Column()
  title: string;

  @Column('decimal', { precision: 10, scale: 2 })
  amount: number;

  @Column()
  type: string;  // 'Shopping', 'Medicine', 'Sport', etc.

  @Column({ nullable: true })
  orderNumber: string;

  @CreateDateColumn()
  createdAt: Date;

  @Column({ nullable: true })
  status: string;  // 'completed', 'pending', 'cancelled'
} 