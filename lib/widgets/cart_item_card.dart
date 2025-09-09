// lib/widgets/cart_item_card.dart
import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  CartItemCard({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        cartItem.product.imageUrl,
        width: 50,
        fit: BoxFit.cover,
      ), // Fixed: leading슈페이드 -> leading
      title: Text(cartItem.product.name),
      subtitle: Text(
        '\$${cartItem.product.price.toStringAsFixed(2)} x ${cartItem.quantity}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed:
                () => Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).decreaseQuantity(cartItem),
          ),
          Text('${cartItem.quantity}'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed:
                () => Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).increaseQuantity(cartItem),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed:
                () => Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).removeFromCart(cartItem),
          ),
        ],
      ),
    );
  }
}
