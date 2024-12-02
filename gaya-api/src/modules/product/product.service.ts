import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Product } from './entities/product.entity';
import { CreateProductDto } from './dto/create-product.dto';

interface FindAllOptions {
  isDiscounted?: boolean;
  limit?: number;
  search?: string;
}

@Injectable()
export class ProductService {
  constructor(
    @InjectRepository(Product)
    private productRepository: Repository<Product>,
  ) {}

  async create(createProductDto: CreateProductDto): Promise<Product> {
    const product = this.productRepository.create(createProductDto);
    return this.productRepository.save(product);
  }

  async findAll(options: FindAllOptions = {}): Promise<Product[]> {
    const queryBuilder = this.productRepository.createQueryBuilder('product');

    // 处理折扣过滤
    if (options.isDiscounted !== undefined) {
      queryBuilder.where('product.isDiscounted = :isDiscounted', {
        isDiscounted: options.isDiscounted,
      });
    }

    // 处理搜索
    if (options.search) {
      queryBuilder.andWhere(
        '(product.name LIKE :search OR product.description LIKE :search)',
        { search: `%${options.search}%` },
      );
    }

    // 处理限制数量
    if (options.limit) {
      queryBuilder.take(options.limit);
    }

    return queryBuilder.getMany();
  }

  async findOne(id: number): Promise<Product> {
    const product = await this.productRepository.findOne({ where: { id } });
    if (!product) {
      throw new NotFoundException(`Product #${id} not found`);
    }
    return product;
  }

  async update(id: number, updateData: Partial<Product>): Promise<Product> {
    await this.productRepository.update(id, updateData);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    const result = await this.productRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Product #${id} not found`);
    }
  }
} 