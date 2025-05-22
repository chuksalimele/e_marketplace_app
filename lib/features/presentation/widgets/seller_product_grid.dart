import 'package:flutter/material.dart';

class SellerProductGrid extends StatelessWidget {
  final Map<String, dynamic> seller;

  const SellerProductGrid({super.key, required this.seller});

  @override
  Widget build(BuildContext context) {
    // Simulated product categories for now
    final List<String> productCategories = ['Phones', 'Laptops', 'Tablets'];

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3 / 2,
      ),
      itemCount: productCategories.length,
      itemBuilder: (context, index) {
        return Card(
          child: Center(
            child: Text(
              productCategories[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
