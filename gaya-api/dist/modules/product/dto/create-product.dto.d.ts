import { ProductStatus } from '../entities/product.entity';
export declare class CreateProductDto {
    name: string;
    description: string;
    categoryId: number;
    originalPrice: number;
    discountPrice?: number;
    stockQuantity: number;
    imageUrl: string;
    status: ProductStatus;
    category: string;
}
