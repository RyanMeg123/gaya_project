import { Repository } from 'typeorm';
import { Product } from './entities/product.entity';
import { CreateProductDto } from './dto/create-product.dto';
interface FindAllOptions {
    isDiscounted?: boolean;
    limit?: number;
    search?: string;
}
export declare class ProductService {
    private productRepository;
    constructor(productRepository: Repository<Product>);
    create(createProductDto: CreateProductDto): Promise<Product>;
    findAll(options?: FindAllOptions): Promise<Product[]>;
    findOne(id: number): Promise<Product>;
    update(id: number, updateData: Partial<Product>): Promise<Product>;
    remove(id: number): Promise<void>;
}
export {};
