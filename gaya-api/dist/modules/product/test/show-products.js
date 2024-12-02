"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const axios_1 = require("axios");
async function showProducts() {
    try {
        const response = await axios_1.default.get('http://localhost:3000/products');
        console.log('Total products:', response.data.length);
        console.log('\nProducts list:');
        response.data.forEach((product) => {
            console.log(`
ID: ${product.id}
Name: ${product.name}
Price: $${product.originalPrice}
Category: ${product.category}
Status: ${product.status}
-------------------`);
        });
    }
    catch (error) {
        console.error('Error fetching products:', error);
    }
}
showProducts();
//# sourceMappingURL=show-products.js.map