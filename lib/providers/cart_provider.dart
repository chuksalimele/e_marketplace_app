// lib/providers/cart_provider.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../services/api_service.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  final ApiService _apiService = ApiService();

  List<CartItem> get items => _items;

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  Future<List<CartItem>> getCartItems() async {
    _items = await _apiService.getCart();
    notifyListeners();
    return _items;
  }

  Future<void> addToCart(Product product) async {
    await _apiService.addToCart(product.id, 1);
    final existingItem = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );
    if (_items.contains(existingItem)) {
      existingItem.quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  Future<void> increaseQuantity(CartItem cartItem) async {
    await _apiService.updateCartItem(
      cartItem.product.id,
      cartItem.quantity + 1,
    );
    cartItem.quantity++;
    notifyListeners();
  }

  Future<void> decreaseQuantity(CartItem cartItem) async {
    if (cartItem.quantity > 1) {
      await _apiService.updateCartItem(
        cartItem.product.id,
        cartItem.quantity - 1,
      );
      cartItem.quantity--;
    } else {
      await _apiService.removeFromCart(cartItem.product.id);
      _items.remove(cartItem);
    }
    notifyListeners();
  }

  Future<void> removeFromCart(CartItem cartItem) async {
    await _apiService.removeFromCart(cartItem.product.id);
    _items.remove(cartItem);
    notifyListeners();
  }
}
