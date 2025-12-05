// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import '../models/product.dart';

const List<Product> products = [
  Product(
    id: 1,
    name: 'Limited Edition Essential Zip Hoodie',
    oldPrice: 79.99,
    newPrice: 59.99,
    image: 'https://www.saintalexanderclo.com/cdn/shop/files/1._CUSTOM_HOODIE_ZIP_1b1e6bc5-7ee3-4e5a-8b13-c29246e1e945.png?v=1763482171&width=1200',
    description:
        'A premium limited edition zip hoodie with soft brushed interior, metal zipper, and a tailored fit.',
    images: [
      'https://www.saintalexanderclo.com/cdn/shop/files/blkh.png?v=1756873889',
      'https://www.saintalexanderclo.com/cdn/shop/files/stone_H.png?v=1756870898',
      'https://www.saintalexanderclo.com/cdn/shop/files/1_-_box_site_navy_h.png?v=1756662399&width=1200'
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Black', 'Grey', 'Blue'],
  ),
  Product(
    id: 2,
    name: 'Essential T-Shirt',
    oldPrice: 29.99,
    newPrice: 24.99,
    image: 'https://imagin-badges.co.uk/cdn/shop/files/bratt-shirt_3.png?v=1729085364',
    description: 'A soft, breathable cotton tee with a classic fit—perfect for everyday wear.',
    images: [
      'https://files.ekmcdn.com/nn2wadmin/images/charli-xcx-brat-11055-p.jpg',
      'https://www.centraltshirts.com/cdn/shop/files/BratAT_brat_Charli_xcx_dublin_ireland.png?v=1749561729&width=416',
      'https://ae01.alicdn.com/kf/S2c1cfc6a12c445fcbdd9c81ee3009fbc3.jpg'
    ],
  ),
  Product(
    id: 3,
    name: 'Signature Hoodie',
    oldPrice: 89.99,
    newPrice: 69.99,
    image: 'https://picsum.photos/id/1025/800/600',
    description:
        'Premium heavyweight fleece hoodie featuring embroidered logo and reinforced seams for lasting comfort.',
    images: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3QUYOKhTntE-L4eVmc4ME9UD6tKDiXoIW1w&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoMLAbZ0xqNNMFPtScF47Ctxs712cDdp0mfAGaDWd4mbWjycHf8rRgs6PULRr44ebkeSY&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa2_AqbR2LzUW5W9r6JpUfCaHqFoPY-S2QKSKgS3b_Uay5YbdJpVO1b2QDNTlqP7LYWno&usqp=CAU'
    ],
  ),
  Product(
    id: 4,
    name: 'Signature T-Shirt',
    oldPrice: 34.99,
    newPrice: 29.99,
    image: 'https://picsum.photos/id/1035/800/600',
    description: 'Premium cotton tee with signature print and a tailored cut for a modern look.',
    images: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3QUYOKhTntE-L4eVmc4ME9UD6tKDiXoIW1w&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoMLAbZ0xqNNMFPtScF47Ctxs712cDdp0mfAGaDWd4mbWjycHf8rRgs6PULRr44ebkeSY&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa2_AqbR2LzUW5W9r6JpUfCaHqFoPY-S2QKSKgS3b_Uay5YbdJpVO1b2QDNTlqP7LYWno&usqp=CAU'
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
    name: 'Oxford Shirt',
    oldPrice: 49.99,
    newPrice: 45.00,
    image: 'https://picsum.photos/seed/oxford_shirt/400/400',
    description: 'Classic Oxford button-down shirt with a timeless look and comfortable fit.',
    images: [
      'https://picsum.photos/seed/oxford_shirt/400/400',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['White', 'Blue', 'Pink'],
  ),
  Product(
    id: 10,
    name: 'Classic T‑Shirt',
    oldPrice: 29.99,
    newPrice: 25.00,
    image: 'https://picsum.photos/seed/classic_tshirt/400/400',
    description: 'Essential crew neck t-shirt made from premium cotton for everyday comfort.',
    images: [
      'https://picsum.photos/seed/classic_tshirt/400/400',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Black', 'White', 'Grey', 'Navy'],
  ),
  Product(
    id: 11,
    name: 'Denim Jacket',
    oldPrice: 95.00,
    newPrice: 85.00,
    image: 'https://picsum.photos/seed/denim_jacket/400/400',
    description: 'Rugged denim jacket with classic styling and durable construction.',
    images: [
      'https://picsum.photos/seed/denim_jacket/400/400',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Light Blue', 'Dark Blue', 'Black'],
  ),
  Product(
    id: 12,
    name: 'Chinos',
    oldPrice: 59.99,
    newPrice: 50.00,
    image: 'https://picsum.photos/seed/chinos/400/400',
    description: 'Versatile chino pants with a modern slim fit and stretch comfort.',
    images: [
      'https://picsum.photos/seed/chinos/400/400',
    ],
    sizes: ['28', '30', '32', '34', '36'],
    colors: ['Khaki', 'Navy', 'Black', 'Grey'],
  ),
  Product(
    id: 13,
    name: 'Crewneck Sweater',
    oldPrice: 69.99,
    newPrice: 60.00,
    image: 'https://picsum.photos/seed/crewneck_sweater/400/400',
    description: 'Soft merino wool crewneck sweater perfect for layering or wearing solo.',
    images: [
      'https://picsum.photos/seed/crewneck_sweater/400/400',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Navy', 'Grey', 'Burgundy', 'Forest Green'],
  ),
  Product(
    id: 14,
    name: 'Parka Coat',
    oldPrice: 149.99,
    newPrice: 120.00,
    image: 'https://picsum.photos/seed/parka_coat/400/400',
    description: 'Warm and water-resistant parka with insulated lining and adjustable hood.',
    images: [
      'https://picsum.photos/seed/parka_coat/400/400',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Olive', 'Black', 'Navy'],
  ),
  Product(
    id: 15,
    name: 'Leather Belt',
    oldPrice: 35.00,
    newPrice: 30.00,
    image: 'https://picsum.photos/seed/leather_belt/400/400',
    description: 'Genuine leather belt with classic metal buckle and refined finish.',
    images: [
      'https://picsum.photos/seed/leather_belt/400/400',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Brown', 'Black'],
  ),
  Product(
    id: 16,
    name: 'Canvas Sneakers',
    oldPrice: 75.00,
    newPrice: 65.00,
    image: 'https://picsum.photos/seed/canvas_sneakers/400/400',
    description: 'Comfortable canvas sneakers with cushioned insoles and durable rubber soles.',
    images: [
      'https://picsum.photos/seed/canvas_sneakers/400/400',
    ],
    sizes: ['7', '8', '9', '10', '11', '12'],
    colors: ['White', 'Black', 'Navy'],
  ),
  Product(
    id: 17,
    name: 'Wool Scarf',
    oldPrice: 29.99,
    newPrice: 25.00,
    image: 'https://picsum.photos/seed/wool_scarf/400/400',
    description: 'Luxuriously soft wool scarf to keep you warm and stylish in cold weather.',
    images: [
      'https://picsum.photos/seed/wool_scarf/400/400',
    ],
    colors: ['Charcoal', 'Burgundy', 'Navy', 'Cream'],
  ),
  // Sale items
  Product(
    id: 18,
    name: 'A5 Notepad',
    oldPrice: 5.00,
    newPrice: 3.50,
    image: 'https://shop.upsu.net/cdn/shop/files/A5Notepad1_720x.jpg',
    description: 'High-quality A5 notepad with lined pages, perfect for notes and sketches.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/A5Notepad1_720x.jpg',
    ],
  ),
  Product(
    id: 19,
    name: 'Classic Sweatshirts - Neutral',
    oldPrice: 17.00,
    newPrice: 10.99,
    image: 'https://shop.upsu.net/cdn/shop/files/ClassicSweatshirts-Neutral1_720x.jpg',
    description: 'Comfortable classic sweatshirt in neutral tones, perfect for everyday wear.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/ClassicSweatshirts-Neutral1_720x.jpg',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Beige', 'Grey', 'White'],
  ),
  Product(
    id: 20,
    name: 'Recycled Notebook',
    oldPrice: 3.50,
    newPrice: 1.80,
    image: 'https://shop.upsu.net/cdn/shop/files/RecycledNotebook1_720x.jpg',
    description: 'Eco-friendly recycled notebook with quality paper and durable cover.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/RecycledNotebook1_720x.jpg',
    ],
  ),
  Product(
    id: 21,
    name: 'iPhone 5/6 Charge & Sync Cable',
    oldPrice: 3.00,
    newPrice: 1.50,
    image: 'https://shop.upsu.net/cdn/shop/files/iPhone56Charge_SyncCable1_720x.jpg',
    description: 'Reliable charging and sync cable compatible with iPhone 5/6 models.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/iPhone56Charge_SyncCable1_720x.jpg',
    ],
  ),
  Product(
    id: 22,
    name: 'Type C Charge & Sync Cable',
    oldPrice: 3.00,
    newPrice: 1.50,
    image: 'https://shop.upsu.net/cdn/shop/files/TypeCCharge_SyncCable1_720x.jpg',
    description: 'Universal Type-C charging and sync cable with fast charging support.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/TypeCCharge_SyncCable1_720x.jpg',
    ],
  ),
  Product(
    id: 23,
    name: 'USB to USB Charge & Sync Cables',
    oldPrice: 3.00,
    newPrice: 1.50,
    image: 'https://shop.upsu.net/cdn/shop/files/USBtoUSBCharge_SyncCables1_720x.jpg',
    description: 'Standard USB to USB cable for charging and data transfer.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/USBtoUSBCharge_SyncCables1_720x.jpg',
    ],
  ),
  Product(
    id: 24,
    name: 'Dimple Pop Fidget Keyring',
    oldPrice: 1.50,
    newPrice: 0.99,
    image: 'https://shop.upsu.net/cdn/shop/files/DimplePopFidgetKeyring1_720x.jpg',
    description: 'Fun and portable pop fidget keyring for stress relief on the go.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/DimplePopFidgetKeyring1_720x.jpg',
    ],
    colors: ['Blue', 'Green', 'Pink', 'Purple'],
  ),
  Product(
    id: 25,
    name: 'Nike Academy 18 Tech Pants (W)',
    oldPrice: 24.99,
    newPrice: 7.00,
    image: 'https://shop.upsu.net/cdn/shop/files/NikeAcademy18TechPants_W_1_720x.jpg',
    description: 'Women\'s Nike Academy tech pants with Dri-FIT technology for comfort.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/NikeAcademy18TechPants_W_1_720x.jpg',
    ],
    sizes: ['XS', 'S', 'M', 'L'],
  ),
  Product(
    id: 26,
    name: 'Nike Academy 18 Tech Pants (M)',
    oldPrice: 24.99,
    newPrice: 22.99,
    image: 'https://shop.upsu.net/cdn/shop/files/NikeAcademy18TechPants_M_1_720x.jpg',
    description: 'Men\'s Nike Academy tech pants with Dri-FIT technology for performance.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/NikeAcademy18TechPants_M_1_720x.jpg',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
  ),
];
