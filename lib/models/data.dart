// data.dart - UPDATED Product class with 'price'

import 'package:flutter/material.dart'; // Needed for ImageProvider in some contexts (though not strictly for data models)

// --- Models ---
class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price; // <-- ADDED price field
  final String sellerId;
  final String sellerName;
  final String category;
  final double distanceKm; // Distance from current user location (simulated)

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price, // <-- REQUIRED in constructor
    required this.sellerId,
    required this.sellerName,
    required this.category,
    required this.distanceKm,
  });
}

class Seller {
  final String id;
  final String name;
  final String city;
  final int tier; // e.g., 1 for basic, 2 for verified, 3 for premium
  final String? profileImageUrl; // Optional profile image
  final String description; // Short description of the seller/store
  final List<String> categories; // Categories of products this seller offers

  Seller({
    required this.id,
    required this.name,
    required this.city,
    required this.tier,
    this.profileImageUrl,
    required this.description,
    required this.categories,
  });
}

// New: CartItem model
class CartItem {
  final Product product;
  int quantity; // Quantity can be modified

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}


// --- Dummy Data ---

// Dummy Sellers in Onitsha (for simulation)
List<Seller> dummySellersOnitsha = [
  Seller(
    id: 's1',
    name: 'Mega Electronics',
    city: 'Onitsha',
    tier: 3,
    profileImageUrl: 'assets/seller_profile_1.jpg',
    description: 'Your one-stop shop for all electronics.',
    categories: ['Electronics', 'Home Goods'],
  ),
  Seller(
    id: 's2',
    name: 'Fresh Groceries',
    city: 'Onitsha',
    tier: 2,
    profileImageUrl: 'assets/seller_profile_2.jpg',
    description: 'Fresh and organic produce delivered to your door.',
    categories: ['Groceries'],
  ),
  Seller(
    id: 's3',
    name: 'Fashion Hub',
    city: 'Onitsha',
    tier: 1,
    profileImageUrl: 'assets/seller_profile_3.jpg',
    description: 'Latest fashion trends for men and women.',
    categories: ['Fashion'],
  ),
  Seller(
    id: 's4',
    name: 'Bookworm Store',
    city: 'Onitsha',
    tier: 2,
    profileImageUrl: 'assets/seller_profile_4.jpg',
    description: 'A wide range of books for all ages.',
    categories: ['Books'],
  ),
  Seller(
    id: 's5',
    name: 'Sporty Gear',
    city: 'Onitsha',
    tier: 3,
    profileImageUrl: 'assets/seller_profile_5.jpg',
    description: 'High-quality sports equipment and apparel.',
    categories: ['Sports'],
  ),
  Seller(
    id: 's6',
    name: 'Glamour Beauty',
    city: 'Onitsha',
    tier: 1,
    profileImageUrl: 'assets/seller_profile_6.jpg',
    description: 'Premium beauty products and cosmetics.',
    categories: ['Beauty'],
  ),
  Seller(
    id: 's7',
    name: 'Home Comforts',
    city: 'Onitsha',
    tier: 2,
    profileImageUrl: 'assets/seller_profile_7.jpg',
    description: 'Everything for your home, from decor to appliances.',
    categories: ['Home Goods'],
  ),
];


// Dummy Products in Onitsha (with new prices)
List<Product> dummyProductsOnitsha = [
  Product(
    id: 'p1',
    name: 'Smartphone X',
    imageUrl: 'assets/product_images/phone_1.jpg',
    price: 120000.00, // Added price
    sellerId: 's1',
    sellerName: 'Mega Electronics',
    category: 'Electronics',
    distanceKm: 2.5,
  ),
  Product(
    id: 'p2',
    name: 'Organic Apples (1kg)',
    imageUrl: 'assets/product_images/apples_1.jpg',
    price: 1500.00, // Added price
    sellerId: 's2',
    sellerName: 'Fresh Groceries',
    category: 'Groceries',
    distanceKm: 1.2,
  ),
  Product(
    id: 'p3',
    name: 'Stylish Men\'s Shirt',
    imageUrl: 'assets/product_images/shirt_1.jpg',
    price: 8500.00, // Added price
    sellerId: 's3',
    sellerName: 'Fashion Hub',
    category: 'Fashion',
    distanceKm: 3.8,
  ),
  Product(
    id: 'p4',
    name: 'Laptop Pro 15',
    imageUrl: 'assets/product_images/laptop_1.jpg',
    price: 350000.00, // Added price
    sellerId: 's1',
    sellerName: 'Mega Electronics',
    category: 'Electronics',
    distanceKm: 2.7,
  ),
  Product(
    id: 'p5',
    name: 'Fresh Tomatoes (500g)',
    imageUrl: 'assets/product_images/tomatoes_1.jpg',
    price: 800.00, // Added price
    sellerId: 's2',
    sellerName: 'Fresh Groceries',
    category: 'Groceries',
    distanceKm: 1.5,
  ),
  Product(
    id: 'p6',
    name: 'Women\'s Casual Dress',
    imageUrl: 'assets/product_images/dress_1.jpg',
    price: 12000.00, // Added price
    sellerId: 's3',
    sellerName: 'Fashion Hub',
    category: 'Fashion',
    distanceKm: 4.0,
  ),
  Product(
    id: 'p7',
    name: 'The Great Gatsby',
    imageUrl: 'assets/product_images/book_1.jpg',
    price: 4500.00, // Added price
    sellerId: 's4',
    sellerName: 'Bookworm Store',
    category: 'Books',
    distanceKm: 0.9,
  ),
  Product(
    id: 'p8',
    name: 'Basketball Hoop',
    imageUrl: 'assets/product_images/basketball_hoop_1.jpg',
    price: 75000.00, // Added price
    sellerId: 's5',
    sellerName: 'Sporty Gear',
    category: 'Sports',
    distanceKm: 5.1,
  ),
  Product(
    id: 'p9',
    name: 'Facial Cleanser',
    imageUrl: 'assets/product_images/cleanser_1.jpg',
    price: 6000.00, // Added price
    sellerId: 's6',
    sellerName: 'Glamour Beauty',
    category: 'Beauty',
    distanceKm: 2.0,
  ),
  Product(
    id: 'p10',
    name: 'Smart Television',
    imageUrl: 'assets/product_images/tv_1.jpg',
    price: 250000.00, // Added price
    sellerId: 's1',
    sellerName: 'Mega Electronics',
    category: 'Electronics',
    distanceKm: 2.9,
  ),
  Product(
    id: 'p11',
    name: 'Blender',
    imageUrl: 'assets/product_images/blender_1.jpg',
    price: 22000.00, // Added price
    sellerId: 's7',
    sellerName: 'Home Comforts',
    category: 'Home Goods',
    distanceKm: 1.8,
  ),
  Product(
    id: 'p12',
    name: 'Running Shoes',
    imageUrl: 'assets/product_images/shoes_1.jpg',
    price: 18000.00, // Added price
    sellerId: 's5',
    sellerName: 'Sporty Gear',
    category: 'Sports',
    distanceKm: 5.5,
  ),
];


// Dummy Advertised Products (a subset of the main products, with prices)
List<Product> dummyAdvertisedProducts = [
  dummyProductsOnitsha[0], // Smartphone X
  dummyProductsOnitsha[3], // Laptop Pro 15
  dummyProductsOnitsha[6], // The Great Gatsby
  dummyProductsOnitsha[9], // Smart Television
];

// New: Dummy Cart Items (Simulated)
List<CartItem> dummyCartItems = [
  CartItem(product: dummyProductsOnitsha[0], quantity: 2), // Smartphone X, quantity 2
  CartItem(product: dummyProductsOnitsha[3], quantity: 1), // Laptop Pro 15, quantity 1
  CartItem(product: dummyProductsOnitsha[6], quantity: 3), // The Great Gatsby, quantity 3
];

// New: List of all product categories (derived from dummy products for consistency)
final List<String> dummyProductCategories = [
  'Electronics', 'Groceries', 'Fashion', 'Home Goods', 'Books', 'Sports', 'Beauty'
].toSet().toList(); // Using Set to ensure uniqueness, then converting back to List


// --- Helper Functions ---

Seller? getSellerById(String sellerId) {
  try {
    return dummySellersOnitsha.firstWhere((seller) => seller.id == sellerId);
  } catch (e) {
    return null; // Seller not found
  }
}

List<Product> getProductsBySellerAndCategory(String sellerId, {String? category}) {
  List<Product> products = dummyProductsOnitsha.where((p) => p.sellerId == sellerId).toList();
  if (category != null && category.isNotEmpty) {
    products = products.where((p) => p.category == category).toList();
  }
  return products;
}