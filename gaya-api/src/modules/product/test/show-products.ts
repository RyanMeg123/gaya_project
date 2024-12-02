import axios from 'axios';

async function showProducts() {
  try {
    // 获取所有商品
    const response = await axios.get('http://localhost:3000/products');
    
    console.log('Total products:', response.data.length);
    console.log('\nProducts list:');
    response.data.forEach((product: any) => {
      console.log(`
ID: ${product.id}
Name: ${product.name}
Price: $${product.originalPrice}
Category: ${product.category}
Status: ${product.status}
-------------------`);
    });

  } catch (error) {
    console.error('Error fetching products:', error);
  }
}

showProducts(); 