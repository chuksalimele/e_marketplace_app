import 'package:e_marketplace_app/features/presentation/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/seller_info_header.dart';
import '../widgets/seller_product_grid.dart';
import '../widgets/see_more_seller_products_fab.dart';

class SellerDetailsPage extends StatelessWidget {

  const SellerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final seller = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final bool isPaidUser = seller['isPaid'] ?? false;

    return Scaffold(
      appBar: TransparentAppBar(
        title: Text('${seller['name']} Store'),
      ),
      body: Column(
        children: [
          SellerInfoHeader(seller: seller),
          Expanded(
            child: SellerProductGrid(seller: seller),
          ),
        ],
      ),
      floatingActionButton: isPaidUser ?
                const SeeMoreSellerProductsFAB() : null,
    );
  }
}
