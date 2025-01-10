// import 'package:t_store/features/shop/models/banner_model.dart';
// import 'package:t_store/features/shop/models/brand_category_model.dart';
// import 'package:t_store/features/shop/models/brand_model.dart';
// import 'package:t_store/features/shop/models/category_model.dart';
// import 'package:t_store/features/shop/models/product_attribute_model.dart';
// import 'package:t_store/features/shop/models/product_category_model.dart';
// import 'package:t_store/features/shop/models/product_model.dart';
// import 'package:t_store/features/shop/models/product_variation_model.dart';
// import 'package:t_store/routes/routes.dart';
// import 'package:t_store/utils/constants/enums.dart';
// import 'package:t_store/utils/constants/image_strings.dart';

// class TDummyData {
//   ////////////////////BANNERS///////////////////////
//   static final List<BannerModel> oldBanners = [
//     BannerModel(
//       imageUrl: TImages.banner1,
//       targetScreen: TRoutes.order,
//       active: true,
//     ),
//     BannerModel(
//       imageUrl: TImages.banner2,
//       targetScreen: TRoutes.cart,
//       active: true,
//     ),
//     BannerModel(
//       imageUrl: TImages.banner3,
//       targetScreen: TRoutes.favourites,
//       active: true,
//     ),
//     BannerModel(
//       imageUrl: TImages.banner4,
//       targetScreen: TRoutes.search,
//       active: true,
//     ),
//     BannerModel(
//       imageUrl: TImages.banner5,
//       targetScreen: TRoutes.settings,
//       active: true,
//     ),
//     BannerModel(
//       imageUrl: TImages.banner6,
//       targetScreen: TRoutes.userAddress,
//       active: true,
//     ),
//     BannerModel(
//       imageUrl: TImages.banner7,
//       targetScreen: TRoutes.store,
//       active: true,
//     ),
//     BannerModel(
//       imageUrl: TImages.banner8,
//       targetScreen: TRoutes.checkout,
//       active: true,
//     ),
//   ];
//   static final List<BannerModel> banners = [
//     BannerModel(
//       imageUrl: TImages.promoBanner1,
//       targetScreen: TRoutes.order,
//       active: true,
//     ),
//     BannerModel(
//       imageUrl: TImages.promoBanner2,
//       targetScreen: TRoutes.cart,
//       active: true,
//     ),
//     BannerModel(
//       imageUrl: TImages.promoBanner3,
//       targetScreen: TRoutes.favourites,
//       active: true,
//     ),
//   ];

//   ////////////////////CATEGORIES////////////////////
//   static final List<DanhMucModel> categories = [
//     DanhMucModel(
//       id: "1",
//       name: "Sports",
//       image: TImages.sportIcon,
//       isFeatured: true,
//     ),
//     DanhMucModel(
//         id: "2",
//         name: "Electronics",
//         image: TImages.electronicsIcon,
//         isFeatured: true),
//     DanhMucModel(
//       id: "3",
//       name: "Clothes",
//       image: TImages.clothIcon,
//       isFeatured: true,
//     ),
//     DanhMucModel(
//       id: "4",
//       name: "Animals",
//       image: TImages.animalIcon,
//       isFeatured: true,
//     ),
//     DanhMucModel(
//         id: "5",
//         name: "Furniture",
//         image: TImages.furnitureIcon,
//         isFeatured: true),

//     DanhMucModel(
//       id: "6",
//       name: "Shoes",
//       image: TImages.shoeIcon,
//       isFeatured: true,
//     ),
//     DanhMucModel(
//         id: "7",
//         name: "Cosmetics",
//         image: TImages.cosmeticsIcon,
//         isFeatured: true),
//     DanhMucModel(
//         id: "8",
//         name: "Jwellery",
//         image: TImages.jeweleryIcon,
//         isFeatured: true),

//     //SubCategories
//     //Sports
//     DanhMucModel(
//         id: "9",
//         name: "Sport Shoes",
//         image: TImages.sportIcon,
//         parentId: "1",
//         isFeatured: false),
//     DanhMucModel(
//         id: "10",
//         name: "Track Suits",
//         parentId: "1",
//         image: TImages.sportIcon,
//         isFeatured: false),
//     DanhMucModel(
//         id: "11",
//         name: "Sport Equipments",
//         parentId: "1",
//         image: TImages.sportIcon,
//         isFeatured: false),

// //electronics
//     DanhMucModel(
//         id: "12",
//         name: "Laptop",
//         image: TImages.electronicsIcon,
//         parentId: "2",
//         isFeatured: false),
//     DanhMucModel(
//         id: "13",
//         name: "Mobile",
//         image: TImages.electronicsIcon,
//         parentId: "2",
//         isFeatured: false),

//     //Clothes
//     DanhMucModel(
//         id: "14",
//         name: "Jackets",
//         image: TImages.clothIcon,
//         parentId: "3",
//         isFeatured: false),
//     DanhMucModel(
//         id: "22",
//         name: "TShirts",
//         image: TImages.clothIcon,
//         parentId: "3",
//         isFeatured: false),
//     //Animals
//     DanhMucModel(
//         id: "15",
//         name: "Dog feed",
//         image: TImages.furnitureIcon,
//         parentId: "4",
//         isFeatured: false),
//     //Furnitures
//     DanhMucModel(
//         id: "16",
//         name: "Bedroom furniture",
//         parentId: "5",
//         image: TImages.furnitureIcon,
//         isFeatured: false),
//     DanhMucModel(
//         id: "20",
//         name: "Kitchen furniture",
//         parentId: "5",
//         image: TImages.furnitureIcon,
//         isFeatured: false),
//     DanhMucModel(
//         id: "21",
//         name: "Office furniture",
//         parentId: "5",
//         image: TImages.furnitureIcon,
//         isFeatured: false),
//     //Shoes
//     DanhMucModel(
//         id: "17",
//         name: "Sport Shoes",
//         parentId: "6",
//         image: TImages.furnitureIcon,
//         isFeatured: false),
//     DanhMucModel(
//         id: "18",
//         name: "Formal Shoes",
//         parentId: "6",
//         image: TImages.furnitureIcon,
//         isFeatured: false),
//     DanhMucModel(
//         id: "19",
//         name: "Flip Flops",
//         parentId: "6",
//         image: TImages.furnitureIcon,
//         isFeatured: false),
//   ];

//   ////////////////////////PRODUCTS///////////////////////////
//   static final List<SanPhamModel> products = [
//     SanPhamModel(
//       id: "001",
//       stock: 15,
//       price: 135,
//       title: "Nike Sports shoe",
//       isFeatured: true,
//       thumbnail: TImages.nikeAir1,
//       description:
//           "Nike, Inc. is an American athletic footwear and apparel corporation headquartered near Beaverton, Oregon, United States. It is the world's largest supplier of athletic shoes and apparel and a major manufacturer of sports equipment, with revenue in excess of US\$46 billion in its fiscal year 2022",
//       brand: ThuongHieuModel(
//           id: "1",
//           hinhAnh: TImages.nikeLogo,
//           tenThuongHieu: "Nike",
//           soLuongSanPham: 265,
//           danhGiaCao: true),
//       images: [
//         TImages.nikeAir1,
//         TImages.nikeAir2,
//         TImages.nikeAir3,
//       ],
//       salePrice: 30,
//       sku: "ABR4568",
//       categoryId: "1",
//       productAttributes: [
//         ThuocTinhSanPhamModel(
//           name: "Color",
//           values: ["Green", "Black", "Red"],
//         ),
//         ThuocTinhSanPhamModel(
//           name: "Size",
//           values: ["EU 30", "EU 32", "EU 34"],
//         )
//       ],
//       productVariations: [
//         BienTheSanPhamModel(
//           id: "1",
//           stock: 34,
//           price: 134,
//           salePrice: 122.6,
//           image: TImages.nikeAir1,
//           description:
//               "This is a product description of the producct variation",
//           attributeValues: {"Color": "Green", "Size": "EU 34"},
//         ),
//         BienTheSanPhamModel(
//           id: "2",
//           stock: 15,
//           price: 132,
//           image: TImages.nikeAir2,
//           description:
//               "This is a product description of the producct variation",
//           attributeValues: {"Color": "Black", "Size": "EU 32"},
//         ),
//         BienTheSanPhamModel(
//           id: "3",
//           stock: 0,
//           price: 234,
//           image: TImages.nikeAir2,
//           description:
//               "This is a product description of the producct variation",
//           attributeValues: {"Color": "Black", "Size": "EU 34"},
//         ),
//         BienTheSanPhamModel(
//           id: "4",
//           stock: 232,
//           price: 234,
//           image: TImages.nikeAir1,
//           description:
//               "This is a product description of the producct variation",
//           attributeValues: {"Color": "Green", "Size": "EU 32"},
//         ),
//         BienTheSanPhamModel(
//           id: "5",
//           stock: 222,
//           price: 102,
//           image: TImages.nikeAir3,
//           description:
//               "This is a product description of the producct variation",
//           attributeValues: {"Color": "Red", "Size": "EU 34"},
//         ),
//         BienTheSanPhamModel(
//           id: "6",
//           stock: 25,
//           price: 334,
//           image: TImages.nikeAir3,
//           description:
//               "This is a product description of the producct variation",
//           attributeValues: {"Color": "Red", "Size": "EU 32"},
//         ),
//       ],
//       productType: ProductType.variable.toString(),
//     ),
//     SanPhamModel(
//       id: "002",
//       stock: 36,
//       price: 1200,
//       title: "Brown Leather Jacket",
//       isFeatured: true,
//       thumbnail: TImages.adidasJacket1,
//       description:
//           "A brown leatherjacket with high durability and strength. Servers your purpose in a tougher way",
//       brand: ThuongHieuModel(
//           id: "2",
//           hinhAnh: TImages.adidasLogo,
//           tenThuongHieu: "Adidas",
//           soLuongSanPham: 265,
//           danhGiaCao: true),
//       images: [
//         TImages.adidasJacket1,
//         TImages.adidasJacket2,
//       ],
//       salePrice: 1000,
//       sku: "GHt8941",
//       categoryId: "2",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "003",
//       stock: 15,
//       price: 135,
//       title: "Nike Air Jordan",
//       isFeatured: true,
//       thumbnail: TImages.nikeJordanMagenta,
//       description:
//           "MJ wore 'em when he claimed his first championship and you'll be wearing 'em for—well, whatever you want. Laden with dynamic design lines and those iconic lace locks, these sneakers bring throwback style to any 'fit. Lace up, and let your kicks do the talking.",
//       brand: ThuongHieuModel(
//           id: "1",
//           hinhAnh: TImages.nikeLogo,
//           tenThuongHieu: "Nike",
//           soLuongSanPham: 360,
//           danhGiaCao: true),
//       images: [
//         TImages.nikeJordanBlackred,
//         TImages.nikeJordanOrange,
//         TImages.nikeJordanMagenta,
//         TImages.nikeJordanWhiteRed,
//       ],
//       salePrice: 30,
//       sku: "ABR4568",
//       categoryId: "1",
//       productAttributes: [
//         ThuocTinhSanPhamModel(
//           name: "Color",
//           values: [
//             "Black",
//             "Orange",
//             "Magenta",
//             "Red",
//           ],
//         ),
//         ThuocTinhSanPhamModel(
//           name: "Size",
//           values: ["EU 30", "EU 32"],
//         )
//       ],
//       productVariations: [
//         BienTheSanPhamModel(
//           description:
//               "This is a product description of the producct variation",
//           id: "5",
//           stock: 222,
//           price: 102,
//           image: TImages.nikeJordanMagenta,
//           attributeValues: {"Color": "Magenta", "Size": "EU 30"},
//         ),
//         BienTheSanPhamModel(
//           description:
//               "This is a product description of the producct variation",
//           id: "6",
//           stock: 25,
//           price: 334,
//           image: TImages.nikeJordanMagenta,
//           attributeValues: {"Color": "Magenta", "Size": "EU 32"},
//         ),
//         BienTheSanPhamModel(
//           description:
//               "This is a product description of the producct variation",
//           id: "1",
//           stock: 34,
//           price: 134,
//           salePrice: 122.6,
//           image: TImages.nikeJordanBlackred,
//           attributeValues: {"Color": "Black", "Size": "EU 30"},
//         ),
//         BienTheSanPhamModel(
//           description:
//               "This is a product description of the producct variation",
//           id: "2",
//           stock: 15,
//           price: 132,
//           image: TImages.nikeJordanBlackred,
//           attributeValues: {"Color": "Black", "Size": "EU 32"},
//         ),
//         BienTheSanPhamModel(
//           description:
//               "This is a product description of the producct variation",
//           id: "3",
//           stock: 0,
//           price: 234,
//           image: TImages.nikeJordanOrange,
//           attributeValues: {"Color": "Orange", "Size": "EU 30"},
//         ),
//         BienTheSanPhamModel(
//           description:
//               "This is a product description of the producct variation",
//           id: "4",
//           stock: 232,
//           price: 234,
//           image: TImages.nikeJordanOrange,
//           attributeValues: {"Color": "Orange", "Size": "EU 32"},
//         ),
//         BienTheSanPhamModel(
//           description:
//               "This is a product description of the producct variation",
//           id: "7",
//           stock: 222,
//           price: 102,
//           image: TImages.nikeJordanWhiteRed,
//           attributeValues: {"Color": "Red", "Size": "EU 30"},
//         ),
//         BienTheSanPhamModel(
//           description:
//               "This is a product description of the producct variation",
//           id: "8",
//           stock: 25,
//           price: 334,
//           image: TImages.nikeJordanWhiteRed,
//           attributeValues: {"Color": "Red", "Size": "EU 32"},
//         ),
//       ],
//       productType: ProductType.variable.toString(),
//     ),
//     SanPhamModel(
//       id: "004",
//       stock: 69,
//       price: 560,
//       title: "Zara Track Suit",
//       isFeatured: true,
//       thumbnail: TImages.zaraTrackSuitBlack,
//       description:
//           "Tracksuits are a wardrobe staple for fitness and fashion enthusiasts alike for their comfy feel and trendy appearance. Crafted from breathable materials, the outfit helps avoid sweat, keeping you cool and comfortable all day long as well as for workout sessions.",
//       brand: ThuongHieuModel(
//           id: "3",
//           hinhAnh: TImages.zaraLogo,
//           tenThuongHieu: "Zara",
//           soLuongSanPham: 690,
//           danhGiaCao: true),
//       images: [
//         TImages.zaraTrackSuitBlack,
//         TImages.zaraTrackSuitBlue,
//         TImages.zaraTrackSuitRed,
//       ],
//       salePrice: 500,
//       sku: "ABR4568",
//       categoryId: "1",
//       productAttributes: [
//         ThuocTinhSanPhamModel(
//           name: "Color",
//           values: [
//             "Black",
//             "Blue",
//             "Red",
//           ],
//         ),
//         ThuocTinhSanPhamModel(
//           name: "Size",
//           values: ["EU 30", "EU 32"],
//         )
//       ],
//       productVariations: [
//         BienTheSanPhamModel(
//           id: "1",
//           stock: 34,
//           price: 134,
//           salePrice: 122.6,
//           image: TImages.zaraTrackSuitBlack,
//           description:
//               "This is a product description of the producct variation",
//           attributeValues: {"Color": "Black", "Size": "EU 30"},
//         ),
//         BienTheSanPhamModel(
//           id: "2",
//           stock: 15,
//           price: 132,
//           image: TImages.zaraTrackSuitBlack,
//           attributeValues: {"Color": "Black", "Size": "EU 32"},
//           description:
//               "This is a product description of the producct variation",
//         ),
//         BienTheSanPhamModel(
//           id: "3",
//           stock: 0,
//           price: 234,
//           image: TImages.zaraTrackSuitBlue,
//           attributeValues: {"Color": "Blue", "Size": "EU 30"},
//           description:
//               "This is a product description of the producct variation",
//         ),
//         BienTheSanPhamModel(
//           id: "4",
//           stock: 232,
//           price: 234,
//           image: TImages.zaraTrackSuitBlue,
//           attributeValues: {"Color": "Blue", "Size": "EU 32"},
//           description:
//               "This is a product description of the producct variation",
//         ),
//         BienTheSanPhamModel(
//           id: "5",
//           stock: 222,
//           price: 102,
//           image: TImages.zaraTrackSuitRed,
//           attributeValues: {"Color": "Red", "Size": "EU 30"},
//           description:
//               "This is a product description of the producct variation",
//         ),
//         BienTheSanPhamModel(
//           id: "6",
//           stock: 25,
//           price: 334,
//           image: TImages.zaraTrackSuitRed,
//           attributeValues: {"Color": "Red", "Size": "EU 32"},
//           description:
//               "This is a product description of the producct variation",
//         ),
//       ],
//       productType: ProductType.variable.toString(),
//     ),
//     SanPhamModel(
//       id: "005",
//       stock: 100,
//       price: 80000,
//       title: "Acer Nitro V Gaming Laptop",
//       isFeatured: true,
//       thumbnail: TImages.acerLaptop2,
//       description:
//           "Acer Nitro V Gaming Laptop Intel Core i5-13420H Processor (Windows 11 Home/ 8 GB/ 512 GB SSD/ NVIDIA GeForce RTX 3050/ 144Hz) ANV15-51 with FHD 39.62 cm (15.6) IPS Display, Obsidian Black, 2.1 KG",
//       brand: ThuongHieuModel(
//           id: "9",
//           hinhAnh: TImages.acerlogo,
//           tenThuongHieu: "Acer",
//           soLuongSanPham: 265,
//           danhGiaCao: true),
//       images: [
//         TImages.acerLaptop1,
//         TImages.acerLaptop2,
//         TImages.acerLaptop4,
//         TImages.acerLaptop3,
//       ],
//       salePrice: 75000,
//       sku: "GHt8942",
//       categoryId: "2",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "006",
//       stock: 520,
//       price: 1300,
//       title: "Nike Football",
//       isFeatured: true,
//       thumbnail: TImages.adidasFootball,
//       description:
//           "Nike OCEAUNZ CLB Football - Size: 5. 10% off. 1,999. ₹1,799 ; ADIDAS Nylon Pop-up Goal and Target 6 feet",
//       brand: ThuongHieuModel(
//           id: "1",
//           hinhAnh: TImages.nikeLogo,
//           tenThuongHieu: "Nike",
//           soLuongSanPham: 265,
//           danhGiaCao: true),
//       images: [
//         TImages.adidasFootball,
//       ],
//       salePrice: 1250,
//       sku: "GHt8942",
//       categoryId: "1",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "007",
//       stock: 20,
//       price: 25000,
//       title: "Herman Miller Bed",
//       isFeatured: true,
//       thumbnail: TImages.hmBed1,
//       description:
//           "At Herman Miller, we want you to do great things. That's why we make problem-solving designs that are as beautiful as they are useful",
//       brand: ThuongHieuModel(
//           id: "8",
//           hinhAnh: TImages.hermanMillerLogo,
//           tenThuongHieu: "Herman Miller",
//           soLuongSanPham: 265,
//           danhGiaCao: true),
//       images: [
//         TImages.hmBed1,
//         TImages.hmBed2,
//         TImages.hmBed3,
//         TImages.hmBed4,
//       ],
//       salePrice: 22250,
//       sku: "ABR4568",
//       categoryId: "1",
//       productAttributes: [
//         ThuocTinhSanPhamModel(
//           name: "Color",
//           values: ["Black", "Sandal", "Brown", "Dark Brown"],
//         ),
//       ],
//       productVariations: [
//         BienTheSanPhamModel(
//           id: "1",
//           stock: 34,
//           price: 22200,
//           salePrice: 22000,
//           image: TImages.hmBed1,
//           description: "This is a product description of the product variation",
//           attributeValues: {"Color": "Black"},
//         ),
//         BienTheSanPhamModel(
//           id: "2",
//           stock: 56,
//           price: 21200,
//           salePrice: 23000,
//           image: TImages.hmBed2,
//           description: "This is a product description of the product variation",
//           attributeValues: {"Color": "Sandal"},
//         ),
//         BienTheSanPhamModel(
//           id: "3",
//           stock: 56,
//           price: 22500,
//           salePrice: 21000,
//           image: TImages.hmBed3,
//           description: "This is a product description of the product variation",
//           attributeValues: {"Color": "Brown"},
//         ),
//         BienTheSanPhamModel(
//           id: "3",
//           stock: 56,
//           price: 22500,
//           salePrice: 21000,
//           image: TImages.hmBed4,
//           description: "This is a product description of the product variation",
//           attributeValues: {"Color": "Dark Brown"},
//         ),
//       ],
//       productType: ProductType.variable.toString(),
//     ),
//     SanPhamModel(
//       id: "008",
//       stock: 1055,
//       price: 15000,
//       title: "Apple Iphone 8",
//       isFeatured: true,
//       thumbnail: TImages.iphone8_1,
//       description:
//           "iOS 11, up to iOS 16.7.5 64GB/128GB/256GB storage, no card slot",
//       brand: ThuongHieuModel(
//           id: "4",
//           hinhAnh: TImages.appleLogo,
//           tenThuongHieu: "Apple",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.iphone8_1,
//         TImages.iphone8_2,
//         TImages.iphone8_3,
//         TImages.iphone8_4,
//       ],
//       salePrice: 14500,
//       sku: "GHt8942",
//       categoryId: "2",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "009",
//       stock: 500,
//       price: 60000,
//       title: "Apple Iphone 12",
//       isFeatured: true,
//       thumbnail: TImages.iphone12_1,
//       description:
//           "Super Retina XDR display; 5.4-inch (diagonal) all-screen OLED display; 2340-by-1080-pixel resolution at 476 ppi",
//       brand: ThuongHieuModel(
//           id: "4",
//           hinhAnh: TImages.appleLogo,
//           tenThuongHieu: "Apple",
//           soLuongSanPham: 750,
//           danhGiaCao: true),
//       images: [
//         TImages.iphone12_1,
//         TImages.iphone12_2,
//         TImages.iphone12_3,
//         TImages.iphone12_4,
//       ],
//       salePrice: 59000,
//       sku: "ABR4568",
//       categoryId: "2",
//       productAttributes: [
//         ThuocTinhSanPhamModel(
//           name: "Color",
//           values: ["Red", "Blue", "Green", "Black"],
//         ),
//       ],
//       productVariations: [
//         BienTheSanPhamModel(
//           id: "1",
//           stock: 34,
//           price: 60000,
//           salePrice: 58000,
//           image: TImages.iphone12_1,
//           description: "This is a product description of the product variation",
//           attributeValues: {"Color": "Red"},
//         ),
//         BienTheSanPhamModel(
//           id: "2",
//           stock: 34,
//           price: 60000,
//           salePrice: 59000,
//           image: TImages.iphone12_2,
//           description: "This is a product description of the product variation",
//           attributeValues: {"Color": "Blue"},
//         ),
//         BienTheSanPhamModel(
//           id: "3",
//           stock: 34,
//           price: 60000,
//           salePrice: 58500,
//           image: TImages.iphone12_3,
//           description: "This is a product description of the product variation",
//           attributeValues: {"Color": "Green"},
//         ),
//         BienTheSanPhamModel(
//           id: "4",
//           stock: 34,
//           price: 60000,
//           salePrice: 60000,
//           image: TImages.iphone12_4,
//           description: "This is a product description of the product variation",
//           attributeValues: {"Color": "Black"},
//         ),
//       ],
//       productType: ProductType.variable.toString(),
//     ),
//     SanPhamModel(
//       id: "010",
//       stock: 263,
//       price: 500,
//       title: "Puma FlipFlop",
//       isFeatured: true,
//       thumbnail: TImages.pumaSlipper1,
//       description:
//           "Shop from the brand new collection of PUMA® men's sandals and flip-flops",
//       brand: ThuongHieuModel(
//           id: "6",
//           hinhAnh: TImages.pumaLogo,
//           tenThuongHieu: "Puma",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.pumaSlipper1,
//         TImages.pumaSlipper2,
//         TImages.pumaSlipper3,
//         TImages.pumaSlipper4,
//       ],
//       salePrice: 489,
//       sku: "GHt8942",
//       categoryId: "2",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "011",
//       stock: 263,
//       price: 250,
//       title: "Dog Food",
//       isFeatured: true,
//       thumbnail: TImages.dogfood1,
//       description: "A best dog food to feedyour lovely dogs",
//       brand: ThuongHieuModel(
//           id: "10",
//           hinhAnh: TImages.ikeaLogo,
//           tenThuongHieu: "Ikea",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.dogfood1,
//       ],
//       salePrice: 200,
//       sku: "GHt8942",
//       categoryId: "4",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "012",
//       stock: 256,
//       price: 1200,
//       title: "Adidas Tennis Racket",
//       isFeatured: true,
//       thumbnail: TImages.tennisRacket1,
//       description: "A Great Tennis Racket for sports in the market",
//       brand: ThuongHieuModel(
//           id: "2",
//           hinhAnh: TImages.adidasLogo,
//           tenThuongHieu: "Adidas",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.tennisRacket1,
//       ],
//       salePrice: 1000,
//       sku: "GHt8942",
//       categoryId: "1",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "013",
//       stock: 256,
//       price: 2500,
//       title: "Nike Cricket Bat",
//       isFeatured: true,
//       thumbnail: TImages.cricketBat1,
//       description: "A Great Cricket Bat for sports in the market",
//       brand: ThuongHieuModel(
//           id: "1",
//           hinhAnh: TImages.nikeLogo,
//           tenThuongHieu: "Nike",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.cricketBat1,
//       ],
//       salePrice: 2700,
//       sku: "GHt8942",
//       categoryId: "1",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "014",
//       stock: 256,
//       price: 15000,
//       title: "Bedroom Wardobe",
//       isFeatured: true,
//       thumbnail: TImages.bedWardobe1,
//       description: "A Great Bedroom wardobe in the market",
//       brand: ThuongHieuModel(
//           id: "8",
//           hinhAnh: TImages.hermanMillerLogo,
//           tenThuongHieu: "Herman Miller",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.bedWardobe1,
//       ],
//       salePrice: 12500,
//       sku: "GHt8942",
//       categoryId: "1",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "015",
//       stock: 256,
//       price: 1500,
//       title: "Adidas Poyester Jacket",
//       isFeatured: true,
//       thumbnail: TImages.polyJacket1,
//       description: "A Great Polyester Jacket in the market",
//       brand: ThuongHieuModel(
//           id: "2",
//           hinhAnh: TImages.adidasLogo,
//           tenThuongHieu: "Adidas",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.kitchenCounter1,
//       ],
//       salePrice: 1200,
//       sku: "GHt8942",
//       categoryId: "1",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "016",
//       stock: 256,
//       price: 26000,
//       title: "Kitchen Counter",
//       isFeatured: true,
//       thumbnail: TImages.kitchenCounter1,
//       description: "This is a product description of the product variation",
//       brand: ThuongHieuModel(
//           id: "10",
//           hinhAnh: TImages.ikeaLogo,
//           tenThuongHieu: "Ikea",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.kitchenCounter1,
//       ],
//       salePrice: 25000,
//       sku: "GHt8942",
//       categoryId: "1",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "017",
//       stock: 256,
//       price: 30000,
//       title: "Refridgirator",
//       isFeatured: true,
//       thumbnail: TImages.fridge1,
//       description: "This is a product description of the product variation",
//       brand: ThuongHieuModel(
//           id: "10",
//           hinhAnh: TImages.ikeaLogo,
//           tenThuongHieu: "Ikea",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.fridge1,
//       ],
//       salePrice: 25000,
//       sku: "GHt8942",
//       categoryId: "1",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "018",
//       stock: 256,
//       price: 30000,
//       title: "Office Chair",
//       isFeatured: true,
//       thumbnail: TImages.officeChair1,
//       description: "This is a product description of the product variation",
//       brand: ThuongHieuModel(
//           id: "10",
//           hinhAnh: TImages.ikeaLogo,
//           tenThuongHieu: "Ikea",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.officeChair1,
//       ],
//       salePrice: 25000,
//       sku: "GHt8942",
//       categoryId: "1",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "019",
//       stock: 256,
//       price: 300,
//       title: "Nike Flip Flop",
//       isFeatured: true,
//       thumbnail: TImages.flipflop1,
//       description: "This is a product description of the product variation",
//       brand: ThuongHieuModel(
//           id: "1",
//           hinhAnh: TImages.nikeLogo,
//           tenThuongHieu: "Nike",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.flipflop1,
//       ],
//       salePrice: 250,
//       sku: "GHt8942",
//       categoryId: "1",
//       productType: ProductType.single.toString(),
//     ),
//     SanPhamModel(
//       id: "020",
//       stock: 256,
//       price: 300,
//       title: "Zara TShirt",
//       isFeatured: true,
//       thumbnail: TImages.tShirt1,
//       description: "This is a product description of the product variation",
//       brand: ThuongHieuModel(
//           id: "3",
//           hinhAnh: TImages.zaraLogo,
//           tenThuongHieu: "Zara",
//           soLuongSanPham: 350,
//           danhGiaCao: true),
//       images: [
//         TImages.tShirt1,
//       ],
//       salePrice: 250,
//       sku: "GHt8942",
//       categoryId: "1",
//       productType: ProductType.single.toString(),
//     ),
//   ];

//   ////////////////////////BRANDS/////////////////////////
//   static final List<ThuongHieuModel> brands = [
//     ThuongHieuModel(
//         id: "1",
//         hinhAnh: TImages.nikeLogo,
//         tenThuongHieu: "Nike",
//         soLuongSanPham: 265,
//         danhGiaCao: true),
//     ThuongHieuModel(
//         id: "2", 
//         hinhAnh: TImages.adidasLogo,
//         tenThuongHieu: "Adidas",
//         soLuongSanPham: 265,
//         danhGiaCao: true),
//     ThuongHieuModel(
//         id: "3",
//         hinhAnh: TImages.zaraLogo,
//         tenThuongHieu: "Zara", 
//         soLuongSanPham: 690,
//         danhGiaCao: true),
//     ThuongHieuModel(
//         id: "4",
//         hinhAnh: TImages.appleLogo,
//         tenThuongHieu: "Apple",
//         soLuongSanPham: 96,
//         danhGiaCao: true),
//     ThuongHieuModel(
//         id: "5",
//         hinhAnh: TImages.jordanLogo,
//         tenThuongHieu: "Jordan",
//         soLuongSanPham: 480,
//         danhGiaCao: true),
//     ThuongHieuModel(
//         id: "6",
//         hinhAnh: TImages.pumaLogo,
//         tenThuongHieu: "Puma",
//         soLuongSanPham: 480,
//         danhGiaCao: true),
//     ThuongHieuModel(
//         id: "7",
//         hinhAnh: TImages.kenwoodLogo,
//         tenThuongHieu: "Kenwood",
//         soLuongSanPham: 480,
//         danhGiaCao: true),
//     ThuongHieuModel(
//         id: "8",
//         hinhAnh: TImages.hermanMillerLogo,
//         tenThuongHieu: "Herman Miller",
//         soLuongSanPham: 480,
//         danhGiaCao: true),
//     ThuongHieuModel(
//         id: "9",
//         hinhAnh: TImages.acerlogo,
//         tenThuongHieu: "Acer",
//         soLuongSanPham: 480,
//         danhGiaCao: true),
//     ThuongHieuModel(
//         id: "10",
//         hinhAnh: TImages.ikeaLogo,
//         tenThuongHieu: "Ikea",
//         soLuongSanPham: 480,
//         danhGiaCao: true),
//   ];

//   static final List<DanhMucThuongHieuModel> brandCategorys = [
//     DanhMucThuongHieuModel(brandId: "1", categoryId: "6"),
//     DanhMucThuongHieuModel(brandId: "1", categoryId: "1"),
//     DanhMucThuongHieuModel(brandId: "2", categoryId: "3"),
//     DanhMucThuongHieuModel(brandId: "2", categoryId: "1"),
//     DanhMucThuongHieuModel(brandId: "3", categoryId: "3"),
//     DanhMucThuongHieuModel(brandId: "4", categoryId: "2"),
//     DanhMucThuongHieuModel(brandId: "6", categoryId: "6"),
//     DanhMucThuongHieuModel(brandId: "8", categoryId: "5"),
//     DanhMucThuongHieuModel(brandId: "9", categoryId: "2"),
//     DanhMucThuongHieuModel(brandId: "10", categoryId: "4")
//   ];

//   static final List<DanhMucSanPhamModel> productCategorys = [
//     DanhMucSanPhamModel(productId: "001", categoryId: "1"),
//     DanhMucSanPhamModel(productId: "001", categoryId: "6"),
//     DanhMucSanPhamModel(productId: "002", categoryId: "3"),
//     DanhMucSanPhamModel(productId: "003", categoryId: "6"),
//     DanhMucSanPhamModel(productId: "003", categoryId: "1"),
//     DanhMucSanPhamModel(productId: "004", categoryId: "1"),
//     DanhMucSanPhamModel(productId: "004", categoryId: "3"),
//     DanhMucSanPhamModel(productId: "005", categoryId: "2"),
//     DanhMucSanPhamModel(productId: "006", categoryId: "1"),
//     DanhMucSanPhamModel(productId: "007", categoryId: "5"),
//     DanhMucSanPhamModel(productId: "008", categoryId: "2"),
//     DanhMucSanPhamModel(productId: "009", categoryId: "2"),
//     DanhMucSanPhamModel(productId: "010", categoryId: "6"),
//     DanhMucSanPhamModel(productId: "011", categoryId: "4"),
//     DanhMucSanPhamModel(productId: "012", categoryId: "1"),
//     DanhMucSanPhamModel(productId: "013", categoryId: "1"),
//     DanhMucSanPhamModel(productId: "014", categoryId: "5"),
//     DanhMucSanPhamModel(productId: "015", categoryId: "3"),
//     DanhMucSanPhamModel(productId: "016", categoryId: "5"),
//     DanhMucSanPhamModel(productId: "017", categoryId: "5"),
//     DanhMucSanPhamModel(productId: "018", categoryId: "5"),
//     DanhMucSanPhamModel(productId: "019", categoryId: "6"),
//     DanhMucSanPhamModel(productId: "020", categoryId: "3"),

//     //Sub Category
//     DanhMucSanPhamModel(productId: "001", categoryId: "9"),
//     DanhMucSanPhamModel(productId: "004", categoryId: "10"),
//     DanhMucSanPhamModel(productId: "006", categoryId: "11"),
//     DanhMucSanPhamModel(productId: "012", categoryId: "11"),
//     DanhMucSanPhamModel(productId: "013", categoryId: "11"),
//     DanhMucSanPhamModel(productId: "005", categoryId: "12"),
//     DanhMucSanPhamModel(productId: "008", categoryId: "13"),
//     DanhMucSanPhamModel(productId: "009", categoryId: "13"),
//     DanhMucSanPhamModel(productId: "002", categoryId: "14"),
//     DanhMucSanPhamModel(productId: "015", categoryId: "14"),
//     DanhMucSanPhamModel(productId: "011", categoryId: "15"),
//     DanhMucSanPhamModel(productId: "007", categoryId: "16"),
//     DanhMucSanPhamModel(productId: "014", categoryId: "16"),
//     DanhMucSanPhamModel(productId: "001", categoryId: "17"),
//     DanhMucSanPhamModel(productId: "003", categoryId: "18"),
//     DanhMucSanPhamModel(productId: "010", categoryId: "19"),
//     DanhMucSanPhamModel(productId: "016", categoryId: "20"),
//     DanhMucSanPhamModel(productId: "017", categoryId: "20"),
//     DanhMucSanPhamModel(productId: "018", categoryId: "21"),
//     DanhMucSanPhamModel(productId: "019", categoryId: "19"),
//     DanhMucSanPhamModel(productId: "020", categoryId: "22"),
//   ];
// }
