// lib/services/api_service.dart
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class ApiService {
  // Simulated product data
  final List<Product> _mockProducts = [
    Product(
      id: '1',
      name: 'Sample Product 1',
      description: 'A high-quality product for testing.',
      price: 29.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      id: '2',
      name: 'Sample Product 2',
      description: 'Another great product.',
      price: 49.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      id: '3',
      name: 'Sample Product 3',
      description: 'Perfect for your needs.',
      price: 19.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  // Simulated cart data
  final List<CartItem> _mockCart = [];

  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));
    return _mockProducts;
  }

  Future<List<CartItem>> getCart() async {
    await Future.delayed(Duration(seconds: 1));
    return _mockCart;
  }

  Future<void> addToCart(String productId, int quantity) async {
    await Future.delayed(Duration(seconds: 1));
    final product = _mockProducts.firstWhere((p) => p.id == productId);
    final existingItem = _mockCart.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: product, quantity: 0),
    );
    if (_mockCart.contains(existingItem)) {
      existingItem.quantity += quantity;
    } else {
      _mockCart.add(CartItem(product: product, quantity: quantity));
    }
  }

  Future<void> updateCartItem(String productId, int quantity) async {
    await Future.delayed(Duration(seconds: 1));
    final item = _mockCart.firstWhere((item) => item.product.id == productId);
    if (quantity > 0) {
      item.quantity = quantity;
    } else {
      _mockCart.remove(item);
    }
  }

  Future<void> removeFromCart(String productId) async {
    await Future.delayed(Duration(seconds: 1));
    _mockCart.removeWhere((item) => item.product.id == productId);
  }

  Future<Map<String, dynamic>> checkout(
    Map<String, String> checkoutData,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    return {
      'orderId': '123',
      'status': 'success',
      'total': _mockCart.fold(
        0.0,
        (sum, item) => sum + item.product.price * item.quantity,
      ),
    };
  }
}
