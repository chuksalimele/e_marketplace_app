import 'package:flutter/material.dart';

class SeeMoreSellerProductsFAB extends StatelessWidget {
  const SeeMoreSellerProductsFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        // Navigate to other categories
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Navigate to more item categories')),
        );
      },
      icon: const Icon(Icons.category),
      label: const Text('More Categories'),
    );
  }
}
