import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm';

export enum ProductStatus {
  AVAILABLE = 'available',
  OUT_OF_STOCK = 'outOfStock',
  DISCONTINUED = 'discontinued',
}

@Entity('products')
export class Product {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column('text')
  description: string;

  @Column()
  categoryId: number;

  @Column('decimal', { precision: 10, scale: 2 })
  originalPrice: number;

  @Column('decimal', { precision: 10, scale: 2, nullable: true })
  discountPrice: number;

  @Column({ default: false })
  isDiscounted: boolean;

  @Column({ default: 0 })
  stockQuantity: number;

  @Column()
  imageUrl: string;

  @Column({
    type: 'enum',
    enum: ProductStatus,
    default: ProductStatus.AVAILABLE
  })
  status: ProductStatus;

  @Column('decimal', { precision: 10, scale: 2, default: 0 })
  discountAmount: number;

  @Column({ default: 0 })
  collectAmount: number;

  @Column()
  category: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
} 