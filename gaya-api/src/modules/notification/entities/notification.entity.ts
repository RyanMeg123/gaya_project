import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, CreateDateColumn } from 'typeorm';
import { User } from '../../user/entities/user.entity';

@Entity('notifications')
export class Notification {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  title: string;

  @Column()
  message: string;

  @Column({ default: false })
  isRead: boolean;

  @Column()
  type: string; // 'order', 'system', 'promotion'

  @ManyToOne(() => User, user => user.notifications)
  user: User;

  @Column()
  userId: number;

  @CreateDateColumn()
  createdAt: Date;
} 