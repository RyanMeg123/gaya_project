export declare enum ProductStatus {
    AVAILABLE = "available",
    OUT_OF_STOCK = "outOfStock",
    DISCONTINUED = "discontinued"
}
export declare class Product {
    id: number;
    name: string;
    description: string;
    categoryId: number;
    originalPrice: number;
    discountPrice: number;
    isDiscounted: boolean;
    stockQuantity: number;
    imageUrl: string;
    status: ProductStatus;
    discountAmount: number;
    collectAmount: number;
    category: string;
    createdAt: Date;
    updatedAt: Date;
}
