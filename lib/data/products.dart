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
    image: 'https://static01.nyt.com/images/2022/02/24/fashion/24YE-DEMNA-1/merlin_202739772_b4699c52-2eca-40fd-8fb2-642b619ca83e-mediumSquareAt3X.jpg',
    description: 'A soft, breathable cotton tee with a classic fit—perfect for everyday wear.',
    images: [
      'https://www.mstc.shop/cdn/shop/files/Sc483d961418944b9a3160d75c85693b4L.jpg?v=1696200552&width=800',
      'https://static01.nyt.com/images/2022/02/24/fashion/24YE-DEMNA-1/merlin_202739772_b4699c52-2eca-40fd-8fb2-642b619ca83e-videoSixteenByNineJumbo1600.jpg',
      'https://www.mstc.shop/cdn/shop/files/S039cbf13bc594313b755ecd45e0216dei.jpg?v=1698089370'
    ],
  ),
  Product(
    id: 3,
    name: 'Signature Hoodie',
    oldPrice: 89.99,
    newPrice: 69.99,
    image: 'https://mertra.com/cdn/shop/files/se1_8203239a-c995-427a-b48c-af205c4a632e.png?v=1723762319',
    description:
        'Premium heavyweight fleece hoodie featuring embroidered logo and reinforced seams for lasting comfort.',
    images: [
      'https://mertra.com/cdn/shop/files/se4.png?v=1723762283',
      'https://mertra.com/cdn/shop/files/big1.png?v=1731210931',
      'https://mertra.com/cdn/shop/files/se29.png?v=1723762283&width=2080'
    ],
  ),
  Product(
    id: 4,
    name: 'Signature T-Shirt',
    oldPrice: 34.99,
    newPrice: 29.99,
    image: 'https://i.ebayimg.com/images/g/DTUAAOSwyJ1k43mj/s-l1200.jpg',
    description: 'Premium cotton tee with signature print and a tailored cut for a modern look.',
    images: [
      'https://www.kershkicks.co.uk/cdn/shop/files/Screenshot-2024-07-10-at-10-39-42.png?v=1720608034s',
      'https://image.goat.com/transform/v1/attachments/product_template_additional_pictures/images/104/726/931/original/1497021_01.jpg.jpeg?action=crop&width=750',
      'https://images.stockx.com/images/Hellstar-Thorn-T-Shirt-Red.jpg?fit=fill&bg=FFFFFF&w=1200&h=857&q=60&dpr=1&trim=color&updated_at=1727292901'
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
    name: 'Corteiz T‑Shirt',
    oldPrice: 29.99,
    newPrice: 25.00,
    image: 'https://www.kershkicks.co.uk/cdn/shop/files/Screenshot2024-04-20at15.21.12.png?v=1713623011',
    description: 'Essential crew neck t-shirt made from premium cotton for everyday comfort.',
    images: [
      'https://www.kershkicks.co.uk/cdn/shop/files/Screenshot2024-04-20at15.21.12.png?v=1713623011',
      'https://www.story.capetown/cdn/shop/files/CorteizOGIslandTeeWhite1.png?v=1731928793&width=3775',
      'https://cdnx.jumpseller.com/casa-do-desporto2/image/50092510/thumb/1438/1438?1719330104',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Black', 'White', 'Grey', 'Navy'],
  ),
  Product(
    id: 11,
    name: 'OPIUM Denim Jacket',
    oldPrice: 95.00,
    newPrice: 85.00,
    image: 'https://i.ebayimg.com/images/g/L8AAAeSwhC9oxw3E/s-l400.jpg',
    description: 'Rugged denim jacket with classic styling and durable construction.',
    images: [
      'https://i.ebayimg.com/images/g/L8AAAeSwhC9oxw3E/s-l400.jpg',
      'https://media-assets.grailed.com/prd/listing/temp/4537f230f683418188cae10ae308963c',
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
