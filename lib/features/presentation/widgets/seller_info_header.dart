import 'package:flutter/material.dart';

class SellerInfoHeader extends StatelessWidget {
  final Map<String, dynamic> seller;

  const SellerInfoHeader({super.key, required this.seller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(seller['name'] ?? ''),
      subtitle: Text('City: ${seller['city'] ?? 'Unknown'}\nDistance: ${seller['distance'] ?? 'N/A'}'),
      leading: const Icon(Icons.store),
    );
  }
}
