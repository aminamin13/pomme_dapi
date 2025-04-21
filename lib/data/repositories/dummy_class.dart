import 'package:pomme_dapi/features/shop/models/banners_model.dart';
import 'package:pomme_dapi/features/shop/models/brand_category_model.dart';
import 'package:pomme_dapi/features/shop/models/brands_model.dart';
import 'package:pomme_dapi/features/shop/models/category_model.dart';
import 'package:pomme_dapi/features/shop/models/product_attribute_model.dart';
import 'package:pomme_dapi/features/shop/models/product_category_model.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/features/shop/models/product_variation_model.dart';
import 'package:pomme_dapi/routes/routes.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';

class AppDummyData {
  // Categories
  static final List<CategoryModel> categories = [
    CategoryModel(
      id: "1",
      name: "Sports",
      image: AppImages.sportIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: "5",
      name: "Furniture",
      image: AppImages.furnitureIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: "2",
      name: "electronics",
      image: AppImages.electronicsIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: "3",
      name: "Clothes",
      image: AppImages.clothIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: "4",
      name: "Animals",
      image: AppImages.animalIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: "7",
      name: "Cosmetics",
      image: AppImages.cosmeticsIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: "14",
      name: "Jewelery",
      image: AppImages.jeweleryIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: "6",
      name: "Shoes",
      image: AppImages.shoeIcon,
      isFeatured: true,
    ),

    // subCategories for sports
    CategoryModel(
      id: "8",
      name: "Sports Shoes",
      image: AppImages.sportIcon,
      isFeatured: false,
      parentId: '1',
    ),
    CategoryModel(
      id: "9",
      name: "Track suits",
      image: AppImages.sportIcon,
      isFeatured: false,
      parentId: '1',
    ),
    CategoryModel(
      id: "10",
      name: "Sports Equipment",
      image: AppImages.sportIcon,
      isFeatured: false,
      parentId: '1',
    ),

    // subCategories for furniture
    CategoryModel(
      id: "11",
      name: "Bedrom set",
      image: AppImages.furnitureIcon,
      isFeatured: false,
      parentId: '5',
    ),
    CategoryModel(
      id: "12",
      name: "Kitchen set",
      image: AppImages.furnitureIcon,
      isFeatured: false,
      parentId: '5',
    ),
    CategoryModel(
      id: "13",
      name: "salon set",
      image: AppImages.furnitureIcon,
      isFeatured: false,
      parentId: '5',
    ),

    CategoryModel(
      id: "14",
      name: "Laptops",
      image: AppImages.electronicsIcon,
      isFeatured: false,
      parentId: '2',
    ),
    CategoryModel(
      id: "15",
      name: "Mobiles",
      image: AppImages.electronicsIcon,
      isFeatured: false,
      parentId: '2',
    ),

    CategoryModel(
      id: "16",
      name: "Shirts",
      image: AppImages.clothIcon,
      isFeatured: false,
      parentId: '3',
    ),
  ];

  /// Banners
  static final List<BannersModel> banners = [
    BannersModel(
      imageUrl: AppImages.banner1,
      targetScreen: AllRoutes.order,
      active: false,
      id: '1',
    ),
    BannersModel(
      imageUrl: AppImages.banner2,
      targetScreen: AllRoutes.cart,
      active: true,
      id: '2',
    ),
    BannersModel(
      imageUrl: AppImages.banner3,
      targetScreen: AllRoutes.favourites,
      active: true,
      id: '3',
    ),
    BannersModel(
      imageUrl: AppImages.banner4,
      targetScreen: AllRoutes.search,
      active: true,
      id: '4',
    ),
    BannersModel(
      imageUrl: AppImages.banner5,
      targetScreen: AllRoutes.settings,
      active: true,
      id: '5',
    ),
    BannersModel(
      imageUrl: AppImages.banner6,
      targetScreen: AllRoutes.userAddress,
      active: true,
      id: '6',
    ),
    BannersModel(
      imageUrl: AppImages.banner8,
      targetScreen: AllRoutes.checkout,
      active: false,
      id: '7',
    ),
  ];
  static final List<ProductModel> products = [
    ProductModel(
      id: "001",
      title: "Green Nike sports shoes",
      stock: 15,
      price: 135,
      isFeatured: true,
      thumbnail: AppImages.productImage1,
      description: "Green Nick sports shoes",
      brand: BrandModel(
        id: "1",
        name: "Nike",
        image: AppImages.nikeLogo,
        isFeatured: true,
        productsCount: 265,
      ),
      images: [
        AppImages.productImage1,
        AppImages.productImage23,
        AppImages.productImage21,
        AppImages.productImage9,
      ],
      salePrice: 30,
      sku: "ABR4568",
      categoryId: "1",
      productAttributes: [
        ProductAttributeModel(
          name: "Size",
          values: ["EU 30", "EU 32", "EU 34"],
        ),
        ProductAttributeModel(name: "Color", values: ["Green", "Red", "Black"]),
      ],
      productVariations: [
        ProductVariationModel(
          id: "1",
          stock: 34,
          price: 134,
          salePrice: 122.6,
          image: AppImages.productImage1,
         // description: "This is the description",
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: "2",
          stock: 16,
          price: 132,
          image: AppImages.productImage23,
        //  description: "This is the description",
          attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: "3",
          stock: 0,
          price: 234,
          image: AppImages.productImage23,
         // description: "This is the description",
          attributeValues: {'Color': 'Black', 'Size': 'M'},
        ),
        ProductVariationModel(
          id: '4',
          stock: 222,
          price: 232,
          image: AppImages.productImage1,
          attributeValues: {'Color': 'Green', 'Size': 'EU 32'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '5',
          stock: 0,
          price: 334,
          image: AppImages.productImage21,
          attributeValues: {'Color': 'Red', 'Size': 'EU 34'},
        ),

        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 332,
          image: AppImages.productImage21,
          attributeValues: {'Color': 'Red', 'Size': 'EU 32'},
        ), // Product VariationModel
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '002',
      title: 'Blue T-shirt for all ages',
      stock: 15,
      price: 35,
      isFeatured: true,
      thumbnail: AppImages.productImage69,
      description:
          'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', image: AppImages.zaraLogo, name: 'ZARA'),
      images: [
        AppImages.productImage68,
        AppImages.productImage69,
        AppImages.productImage5,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '003',
      title: 'Leather brown Jacket',
      stock: 15,
      price: 38000,
      isFeatured: false,
      thumbnail: AppImages.productImage64,
      description:
          'This is a Product description for Leather brown Jacket. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', image: AppImages.zaraLogo, name: 'ZARA'),
      images: [
        AppImages.productImage64,
        AppImages.productImage65,
        AppImages.productImage66,
        AppImages.productImage67,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '004',
      title: '4 Color collar t-shirt dry fit',
      stock: 15,
      price: 135,
      isFeatured: false,
      thumbnail: AppImages.productImage60,
      description:
          'This is a Product description for 4 Color collar t-shirt dry fit. There are more things that can be added but its just a demo and nothing else.',
      brand: BrandModel(id: '6', image: AppImages.zaraLogo, name: 'ZARA'),
      images: [
        AppImages.productImage60,
        AppImages.productImage61,
        AppImages.productImage62,
        AppImages.productImage63,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(
          name: 'Color',
          values: ['Red', 'Yellow', 'Green', 'Blue'],
        ),
        ProductAttributeModel(
          name: 'Size',
          values: ['EU 30', 'EU 32', 'EU 34'],
        ),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 34,
          price: 134,
          salePrice: 122.6,
          image: AppImages.productImage60,
         // description:
             // 'This is a Product description for 4 Color collar t-shirt dry fit',
          attributeValues: {'Color': 'Red', 'Size': 'EU 34'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 132,
          image: AppImages.productImage60,
          attributeValues: {'Color': 'Red', 'Size': 'EU 32'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '3',
          stock: 0,
          price: 234,
          image: AppImages.productImage61,
          attributeValues: {'Color': 'Yellow', 'Size': 'EU 34'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '4',
          stock: 222,
          price: 232,
          image: AppImages.productImage61,
          attributeValues: {'Color': 'Yellow', 'Size': 'EU 32'},
        ), // ProductVariationModel
        ProductVariationModel(
          id: '5',
          stock: 0,
          price: 334,
          image: AppImages.productImage62,
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 332,
          image: AppImages.productImage62,
          attributeValues: {'Color': 'Green', 'Size': 'EU 30'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '7',
          stock: 0,
          price: 334,
          image: AppImages.productImage63,
          attributeValues: {'Color': 'Blue', 'Size': 'EU 30'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '8',
          stock: 11,
          price: 332,
          image: AppImages.productImage63,
          attributeValues: {'Color': 'Blue', 'Size': 'EU 34'},
        ), // Product VariationModel
      ],
      productType: "ProductType.variable",
    ),

    ProductModel(
      id: '005',
      title: 'Nike Air Jordon Shoes',
      stock: 15,
      price: 35,
      isFeatured: false,
      thumbnail: AppImages.productImage10,
      description:
          'Nike Air Jordon Shoes for running. Quality product, Long Lasting',
      brand: BrandModel(
        id: '1',
        image: AppImages.nikeLogo,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage7,
        AppImages.productImage8,
        AppImages.productImage9,
        AppImages.productImage10,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(
          name: 'Color',
          values: ['Orange', 'Black', 'Brown'],
        ),
        ProductAttributeModel(
          name: 'Size',
          values: ['EU 30', 'EU 32', 'EU 34'],
        ),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 16,
          price: 36,
          salePrice: 12.6,
          image: AppImages.productImage8,
          //description:
            //  'Flutter is Googles mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
          attributeValues: {'Color': 'Orange', 'Size': 'EU 34'},
        ), // ProductVariationModel
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 35,
          image: AppImages.productImage7,
          attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '3',
          stock: 14,
          price: 34,
          image: AppImages.productImage9,
          attributeValues: {'Color': 'Brown', 'Size': 'EU 34'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '4',
          stock: 13,
          price: 33,
          image: AppImages.productImage7,
          attributeValues: {'Color': 'Black', 'Size': 'EU 34'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '5',
          stock: 12,
          price: 32,
          image: AppImages.productImage9,
          attributeValues: {'Color': 'Brown', 'Size': 'EU 32'},
        ), // Product VariationModel
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 31,
          image: AppImages.productImage8,
          attributeValues: {'Color': 'Drange', 'Size': 'EU 32'},
        ), // Product VariationModel
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '006',
      title: 'SAMSUNG Galaxy S9 (Pink, 64 GB) (4 GB RAM)',
      stock: 15,
      price: 750,
      isFeatured: false,
      thumbnail: AppImages.productImage11,
      description:
          'SAMSUNG Galaxy S9 (Pink, 64 GB) (4 GB RAM), Long Battery timing',
      brand: BrandModel(id: '7', image: AppImages.appleLogo, name: 'Samsung'),
      images: [
        AppImages.productImage11,
        AppImages.productImage12,
        AppImages.productImage13,
        AppImages.productImage12,
      ],
      salePrice: 650,
      sku: 'ABR4568',
      categoryId: '2',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ), // ProductModel
    // ProductModel
    ProductModel(
      id: '007',
      title: 'TOMI Dog food',
      stock: 15,
      price: 20,
      isFeatured: false,
      thumbnail: AppImages.productImage18,
      description:
          'This is a Product description for TOMI Dog food. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '7', image: AppImages.appleLogo, name: 'Tomi'),
      salePrice: 10,
      sku: 'ABR4568',
      categoryId: '4',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ), // ProductModel
    ProductModel(
      id: '009',
      title: 'Nike Air Jordon 19 Blue',
      stock: 15,
      price: 400,
      isFeatured: false,
      thumbnail: AppImages.productImage19,
      description:
          'This is a Product description for Nike Air Jordon. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: AppImages.nikeLogo, name: 'Nike'),
      images: [
        AppImages.productImage19,
        AppImages.productImage20,
        AppImages.productImage21,
        AppImages.productImage22,
      ],
      salePrice: 200,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ), // ProductModel
    // ProductModel
  ];

  static final List<BrandModel> brands = [
    BrandModel(
      id: '10',
      name: 'Apple',
      image: AppImages.appleLogo,
      productsCount: 200,
      isFeatured: true,
    ),
    BrandModel(
      id: '2',
      name: 'Ikea',
      image: AppImages.ikeaLogo,
      productsCount: 200,
      isFeatured: true,
    ),
    BrandModel(
      id: '1',
      name: 'Nike',
      image: AppImages.nikeLogo,
      productsCount: 200,
      isFeatured: true,
    ),
    BrandModel(
      id: '4',
      name: 'Kenwood',
      image: AppImages.kenwoodLogo,
      productsCount: 200,
      isFeatured: true,
    ),
    BrandModel(
      id: '5',
      name: 'Puma',
      image: AppImages.pumaLogo,
      productsCount: 200,
      isFeatured: true,
    ),
    BrandModel(
      id: '6',
      name: 'Zara',
      image: AppImages.zaraLogo,
      productsCount: 200,
      isFeatured: true,
    ),
    BrandModel(
      id: '7',
      name: 'Adidas',
      image: AppImages.adidasLogo,
      productsCount: 200,
      isFeatured: true,
    ),
    BrandModel(
      id: '8',
      name: 'Jordan',
      image: AppImages.jordanLogo,
      productsCount: 200,
      isFeatured: true,
    ),
    BrandModel(
      id: '9',
      name: 'Jewelery',
      image: AppImages.jeweleryIcon,
      productsCount: 200,
      isFeatured: true,
    ),
  ];
  static final List<BrandCategoryModel> brandCategories = [
    // Nike (ID: '1')
    BrandCategoryModel(brandId: '1', categoryId: '1'), // Sports
    BrandCategoryModel(brandId: '1', categoryId: '8'), // Sports Shoes
    BrandCategoryModel(brandId: '1', categoryId: '9'), // Track suits
    BrandCategoryModel(brandId: '1', categoryId: '10'), // Sports Equipment
    BrandCategoryModel(brandId: '1', categoryId: '6'), // Shoes
    // Zara (ID: '6')
    BrandCategoryModel(brandId: '6', categoryId: '16'), // Shirts
    // Samsung (ID: '7')
    BrandCategoryModel(brandId: '7', categoryId: '2'), // Electronics
    BrandCategoryModel(brandId: '7', categoryId: '14'), // Laptops
    BrandCategoryModel(brandId: '7', categoryId: '15'), // Mobiles
    // Adidas (ID: '7')
    BrandCategoryModel(brandId: '7', categoryId: '1'), // Sports
    BrandCategoryModel(brandId: '7', categoryId: '8'), // Sports Shoes
    // Apple (ID: '10')
    BrandCategoryModel(brandId: '10', categoryId: '4'), // Animals
    // Puma (ID: '5')
    BrandCategoryModel(brandId: '5', categoryId: '1'), // Sports
    BrandCategoryModel(brandId: '5', categoryId: '8'), // Sports Shoes
  ];
  static final List<ProductCategoryModel> productCategories = [
    // Nike Air Max (ID: '001')
    ProductCategoryModel(productId: '001', categoryId: '1'), // Sports
    ProductCategoryModel(productId: '001', categoryId: '8'), // Sports Shoes
    // Adidas UltraBoost (ID: '002')
    ProductCategoryModel(productId: '002', categoryId: '1'), // Sports
    ProductCategoryModel(productId: '002', categoryId: '8'), // Sports Shoes
    // Zara Denim Jacket (ID: '003')
    ProductCategoryModel(productId: '003', categoryId: '3'), // Clothes
    ProductCategoryModel(productId: '003', categoryId: '16'), // Shirts
    // Apple MacBook Pro (ID: '004')
    ProductCategoryModel(productId: '004', categoryId: '2'), // Electronics
    ProductCategoryModel(productId: '004', categoryId: '14'), // Laptops
    // Ikea Bed Frame (ID: '005')
    ProductCategoryModel(productId: '005', categoryId: '5'), // Furniture
    ProductCategoryModel(productId: '005', categoryId: '11'), // Bedroom set
    // Samsung Galaxy S21 (ID: '006')
    ProductCategoryModel(productId: '006', categoryId: '2'), // Electronics
    ProductCategoryModel(productId: '006', categoryId: '15'), // Mobiles
    // Puma Sports Pants (ID: '007')
    ProductCategoryModel(productId: '007', categoryId: '1'), // Sports
    ProductCategoryModel(productId: '007', categoryId: '8'), // Sports Shoes
    // Tomi Dog Food (ID: '007')
    ProductCategoryModel(productId: '007', categoryId: '4'), // Animals
  ];
}
