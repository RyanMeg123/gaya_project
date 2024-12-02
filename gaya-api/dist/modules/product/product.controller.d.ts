import { ProductService } from './product.service';
import { CreateProductDto } from './dto/create-product.dto';
import { Product } from './entities/product.entity';
export declare class ProductController {
    private readonly productService;
    constructor(productService: ProductService);
    create(createProductDto: CreateProductDto): Promise<Product>;
    findAll(isDiscounted?: boolean, limit?: number, search?: string): Promise<Product[]>;
    findOne(id: string): Promise<Product>;
    update(id: string, updateData: Partial<Product>): Promise<Product>;
    remove(id: string): Promise<void>;
}
