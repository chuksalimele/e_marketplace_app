// lib/screens/cart_screen.dart
import 'package:e_marketplace_app/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_card.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: FutureBuilder<List<CartItem>>(
        future: cart.getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final cartItems = snapshot.data ?? [];
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder:
                (context, index) => CartItemCard(cartItem: cartItems[index]),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed:
                  cart.items.isEmpty
                      ? null
                      : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(),
                        ),
                      ),
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
