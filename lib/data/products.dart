// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import '../models/product.dart';

const List<Product> products = [
  Product(
    id: 1,
    name: 'Limited Edition Essential Zip Hoodie',
    oldPrice: 79.99,
    newPrice: 59.99,
    image: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=800&h=800&fit=crop',
    description:
        'A premium limited edition zip hoodie with soft brushed interior, metal zipper, and a tailored fit.',
    images: [
      'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1620799139834-6b8f844fbe61?w=800&h=800&fit=crop'
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Black', 'Grey', 'Blue'],
  ),
  Product(
    id: 2,
    name: 'Essential T-Shirt',
    oldPrice: 29.99,
    newPrice: 24.99,
    image: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800&h=800&fit=crop',
    description: 'A soft, breathable cotton tee with a classic fit—perfect for everyday wear.',
    images: [
      'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1574180566232-aaad1b5b8450?w=800&h=800&fit=crop'
    ],
  ),
  Product(
    id: 3,
    name: 'Signature Hoodie',
    oldPrice: 89.99,
    newPrice: 69.99,
    image: 'https://images.unsplash.com/photo-1620799140188-3b2a02fd9a77?w=800&h=800&fit=crop',
    description:
        'Premium heavyweight fleece hoodie featuring embroidered logo and reinforced seams for lasting comfort.',
    images: [
      'https://images.unsplash.com/photo-1620799140188-3b2a02fd9a77?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1620799139507-2a76f79a2f4d?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1622445275576-721325763afe?w=800&h=800&fit=crop'
    ],
  ),
  Product(
    id: 4,
    name: 'Signature T-Shirt',
    oldPrice: 34.99,
    newPrice: 29.99,
    image: 'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=800&h=800&fit=crop',
    description: 'Premium cotton tee with signature print and a tailored cut for a modern look.',
    images: [
      'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1622470953794-aa9c70b0fb9d?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1503341338985-b91ef0d5a4d1?w=800&h=800&fit=crop'
    ],
  ),
  // appended Portsmouth items
  Product(
    id: 5,
    name: 'Portsmouth City Postcard',
    oldPrice: 2.00,
    newPrice: 1.00,
    image: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_720x.jpg',
    description: 'A postcard featuring iconic Portsmouth landmarks.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_720x.jpg',
    ]
  ),
  Product(
    id: 6,
    name: 'Portsmouth City Magnet',
    oldPrice: 7.00,
    newPrice: 5.00,
    image: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_720x.jpg',
    description: 'A collectible magnet showcasing Portsmouth.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_720x.jpg',
    ]
  ),
  Product(
    id: 7,
    name: 'Portsmouth City Bookmark',
    oldPrice: 3.00,
    newPrice: 2.00,
    image: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityBookmark1_720x.jpg',
    description: 'A decorative Portsmouth bookmark.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityBookmark1_720x.jpg',
    ]
  ),
  Product(
    id: 8,
    name: 'Portsmouth Notebook',
    oldPrice: 6.00,
    newPrice: 4.50,
    image: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityNotebook_720x.jpg',
    description: 'A Portsmouth themed notebook for notes and sketches.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityNotebook_720x.jpg',
    ]
  ),
  // Items from collections page
  Product(
    id: 9,
    name: 'Derschutze Tshirt',
    oldPrice: 49.99,
    newPrice: 45.00,
    image: 'https://images.unsplash.com/photo-1562157873-818bc0726f68?w=800&h=800&fit=crop',
    description: 'Classic Oxford button-down shirt with a timeless look and comfortable fit.',
    images: [
      'https://images.unsplash.com/photo-1562157873-818bc0726f68?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1581655353564-df123a1eb820?w=800&h=800&fit=crop',

    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['White', 'Blue', 'Pink'],
  ),
  Product(
    id: 10,
    name: 'Corteiz T‑Shirt',
    oldPrice: 29.99,
    newPrice: 25.00,
    image: 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=800&h=800&fit=crop',
    description: 'Essential crew neck t-shirt made from premium cotton for everyday comfort.',
    images: [
      'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1529374255404-311a2a4f1fd9?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=800&h=800&fit=crop',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Black', 'White', 'Grey', 'Navy'],
  ),
  Product(
    id: 11,
    name: 'OPIUM Denim Jacket',
    oldPrice: 95.00,
    newPrice: 85.00,
    image: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=800&h=800&fit=crop',
    description: 'Rugged denim jacket with classic styling and durable construction.',
    images: [
      'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=800&h=800&fit=crop',
      'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=800&h=800&fit=crop',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Light Blue', 'Dark Blue', 'Black'],
  ),
  Product(
    id: 12,
    name: 'Corteiz HMP tracksuit',
    oldPrice: 59.99,
    newPrice: 50.00,
    image: 'https://images.stockx.com/images/Corteiz-HMP-V1-Allstarz-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1685132487',
    description: 'Versatile chino pants with a modern slim fit and stretch comfort.',
    images: [
      'https://images.stockx.com/images/Corteiz-HMP-V1-Allstarz-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1685132487',
      'https://images.stockx.com/images/Corteiz-HMP-V2-Sweatpant-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1706302081'
    ],
    sizes: ['28', '30', '32', '34', '36'],
    colors: ['Khaki', 'Navy', 'Black', 'Grey'],
  ),
  Product(
    id: 13,
    name: 'Stussy Crewneck Sweater',
    oldPrice: 69.99,
    newPrice: 60.00,
    image: 'https://cdn.shopify.com/s/files/1/1202/6102/products/stussy-stock-crewneck-sweatshirt-black-1.jpg',
    description: 'Soft merino wool crewneck sweater perfect for layering or wearing solo.',
    images: [
      'https://cdn.shopify.com/s/files/1/1202/6102/products/stussy-stock-crewneck-sweatshirt-black-1.jpg',
      'https://www.stussy.com/cdn/shop/files/1915000_BLAC_2_8b450e6e-7b50-4fe0-980b-db22ee83b474.jpg?v=1760559260&width=1600',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Navy', 'Grey', 'Burgundy', 'Forest Green'],
  ),
  Product(
    id: 14,
    name: 'Corvidae Coat',
    oldPrice: 149.99,
    newPrice: 120.00,
    image: 'https://images.vestiairecollective.com/images/resized/w=1246,q=75,f=auto,/produit/black-polyester-corvidae-coat-31724937-1_4.jpg',
    description: 'Warm and water-resistant parka with insulated lining and adjustable hood.',
    images: [
      'https://images.vestiairecollective.com/images/resized/w=1246,q=75,f=auto,/produit/black-polyester-corvidae-coat-31724937-1_4.jpg',
      'https://images.vestiairecollective.com/images/resized/w=1246,q=75,f=auto,/produit/black-cotton-corvidae-coat-59340166-1_2.jpg',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Olive', 'Black', 'Navy'],
  ),
  Product(
    id: 15,
    name: 'Supreme last supper belt',
    oldPrice: 35.00,
    newPrice: 30.00,
    image: 'https://i.ebayimg.com/images/g/k4oAAeSwzhZn5TW6/s-l1200.jpg',
    description: 'Genuine leather belt with classic metal buckle and refined finish.',
    images: [
      'https://i.ebayimg.com/images/g/k4oAAeSwzhZn5TW6/s-l1200.jpg',
      'https://images.stockx.com/images/Supreme-Last-Supper-Leather-Belt-Multicolor-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1755023680',
      'https://cdn.sanity.io/images/ldn4d4qt/fw25-production-2025-08-24/eebea171edc5bd6290f3a92b2f0b612da603c863-2647x2533.jpg',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Brown', 'Black'],
  ),
  Product(
    id: 16,
    name: 'Jordan 4 Pure money',
    oldPrice: 75.00,
    newPrice: 65.00,
    image: 'https://images.stockx.com/images/Air-Jordan-4-Retro-Pure-Money-2017-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1738193358',
    description: 'Comfortable canvas sneakers with cushioned insoles and durable rubber soles.',
    images: [
      'https://images.stockx.com/images/Air-Jordan-4-Retro-Pure-Money-2017-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1738193358',
      'https://images.stockx.com/images/Air-Jordan-4-Retro-Classic-Green-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1738193358',
      'https://images.stockx.com/images/Air-Jordan-4-Retro-White-Court-Purple-Product.jpg?fit=fill&bg=FFFFFF&w=1200&h=857&q=60&dpr=1&trim=color&updated_at=1738193358'
      
    ],
    sizes: ['7', '8', '9', '10', '11', '12'],
    colors: ['White', 'Green', 'Purple'],
  ),
  Product(
    id: 17,
    name: 'Burberry Studios Wool Scarf',
    oldPrice: 29.99,
    newPrice: 25.00,
    image: 'https://i.ebayimg.com/images/g/j0cAAOSwjL9nlBge/s-l1200.jpg',
    description: 'Luxuriously soft wool scarf to keep you warm and stylish in cold weather.',
    images: [
      'https://i.ebayimg.com/images/g/j0cAAOSwjL9nlBge/s-l1200.jpg',
      'https://images.vestiairecollective.com/images/resized/w=1246,q=75,f=auto,/produit/black-wool-burberry-scarf-32189237-1_5.jpg',
    ],
    colors: ['Charcoal', 'Burgundy', 'Navy', 'Cream'],
  ),
  // Sale items
  Product(
    id: 18,
    name: 'A5 Notepad',
    oldPrice: 5.00,
    newPrice: 3.50,
    image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Death_Note%2C_Book.svg/250px-Death_Note%2C_Book.svg.png',
    description: 'High-quality A5 notepad with lined pages, perfect for notes and sketches.',
    images: [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Death_Note%2C_Book.svg/250px-Death_Note%2C_Book.svg.png',
    ],
  ),
  Product(
    id: 19,
    name: 'Gucci Crewneck',
    oldPrice: 17.00,
    newPrice: 10.99,
    image: 'https://image.goat.com/attachments/product_template_additional_pictures/images/106/116/900/medium/1521067_01.jpg.jpeg',
    description: 'Comfortable classic sweatshirt in neutral tones, perfect for everyday wear.',
    images: [
      'https://image.goat.com/attachments/product_template_additional_pictures/images/106/116/900/medium/1521067_01.jpg.jpeg',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Beige', 'Grey', 'White'],
  ),
  Product(
    id: 20,
    name: 'Recycled Notebook',
    oldPrice: 3.50,
    newPrice: 1.80,
    image: 'https://m.media-amazon.com/images/I/81lziLO-O9L._AC_UF894,1000_QL80_.jpg',
    description: 'Eco-friendly recycled notebook with quality paper and durable cover.',
    images: [
      'https://m.media-amazon.com/images/I/81lziLO-O9L._AC_UF894,1000_QL80_.jpg',
    ],
  ),
  Product(
    id: 21,
    name: 'iPhone 14 Charge & Sync Cable',
    oldPrice: 3.00,
    newPrice: 1.50,
    image: 'https://m.media-amazon.com/images/I/51MgbEhkCXL.jpg',
    description: 'Reliable charging and sync cable compatible with iPhone 5/6 models.',
    images: [
      'https://m.media-amazon.com/images/I/51MgbEhkCXL.jpg',
    ],
  ),
  Product(
    id: 22,
    name: 'Type C Charge & Sync Cable',
    oldPrice: 3.00,
    newPrice: 1.50,
    image: 'https://m.media-amazon.com/images/I/519vz82qd6L._SL1500_.jpg',
    description: 'Universal Type-C charging and sync cable with fast charging support.',
    images: [
      'https://m.media-amazon.com/images/I/519vz82qd6L._SL1500_.jpg',
    ],
  ),
  Product(
    id: 23,
    name: 'Coach Handbag',
    oldPrice: 3.00,
    newPrice: 1.50,
    image: 'https://media.johnlewiscontent.com/i/JohnLewis/109199229?',
    description: 'Standard USB to USB cable for charging and data transfer.',
    images: [
      'https://media.johnlewiscontent.com/i/JohnLewis/109199229?',
    ],
  ),
  Product(
    id: 24,
    name: 'Dimple Pop Fidget Keyring',
    oldPrice: 1.50,
    newPrice: 0.99,
    image: 'https://res.cloudinary.com/totalmerchandise/image/fetch/f_auto,q_auto:eco,w_500/https://www.totalmerchandise.co.uk/media/16256/pop-it-fidget-keyring-225916-68776497c3663.png',
    description: 'Fun and portable pop fidget keyring for stress relief on the go.',
    images: [
      'https://res.cloudinary.com/totalmerchandise/image/fetch/f_auto,q_auto:eco,w_500/https://www.totalmerchandise.co.uk/media/16256/pop-it-fidget-keyring-225916-68776497c3663.png',
    ],
    colors: ['Blue', 'Green', 'Pink', 'Purple'],
  ),
  Product(
    id: 25,
    name: 'Nike tech fleece',
    oldPrice: 24.99,
    newPrice: 7.00,
    image: 'https://i8.amplience.net/i/jpl/jd_716444_a?v=1',
    description: 'Women\'s Nike tech fleece with Dri-FIT technology for comfort.',
    images: [
      'https://i8.amplience.net/i/jpl/jd_716444_a?v=1',
    ],
    sizes: ['XS', 'S', 'M', 'L'],
  ),
  Product(
    id: 26,
    name: 'Nike tech pants',
    oldPrice: 24.99,
    newPrice: 22.99,
    image: 'https://images.prodirectsport.com/ProductImages/Main/1029532_Main_1937249.jpg',
    description: 'Men\'s Nike Academy tech pants with Dri-FIT technology for performance.',
    images: [
      'https://images.prodirectsport.com/ProductImages/Main/1029532_Main_1937249.jpg',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
  ),
];
