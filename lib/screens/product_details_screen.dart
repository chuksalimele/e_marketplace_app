// lib/screens/product_details_screen.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl, height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              product.name,
              style:
                  Theme.of(
                    context,
                  ).textTheme.titleLarge, // Fixed: headline6 -> titleLarge
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(product.description),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).addToCart(product);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Added to cart')));
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
