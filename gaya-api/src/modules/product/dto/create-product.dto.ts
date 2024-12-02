import { IsString, IsNumber, IsEnum, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { ProductStatus } from '../entities/product.entity';

export class CreateProductDto {
  @ApiProperty()
  @IsString()
  name: string;

  @ApiProperty()
  @IsString()
  description: string;

  @ApiProperty()
  @IsNumber()
  categoryId: number;

  @ApiProperty()
  @IsNumber()
  originalPrice: number;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsNumber()
  discountPrice?: number;

  @ApiProperty()
  @IsNumber()
  stockQuantity: number;

  @ApiProperty()
  @IsString()
  imageUrl: string;

  @ApiProperty({ enum: ProductStatus })
  @IsEnum(ProductStatus)
  status: ProductStatus;

  @ApiProperty()
  @IsString()
  category: string;
} 