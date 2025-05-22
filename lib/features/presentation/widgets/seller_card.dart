import 'package:e_marketplace_app/models/data.dart';
import 'package:flutter/material.dart';


// Custom Widget for SellerCard - UPDATED to use Navigator.pushNamed
class SellerCard extends StatelessWidget {
  final Product product;

  const SellerCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final Seller? seller = getSellerById(product.sellerId);

     if (seller == null) {
       return Card(
         elevation: 2.0,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
         child: Center(child: Text('Seller Not Found')),
       );
     }

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          // --- UPDATED: Use Navigator.pushNamed with arguments ---
          Navigator.pushNamed(
            context,
            '/seller_store', // Navigate to the '/seller_store' route
            arguments: { // Pass arguments as a Map
              'sellerId': product.sellerId,
              'initialProductCategory': product.category,
              'productName': product.name, // Keep product name for context if needed
            },
          );
          // ------------------------------------------------------
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                 child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                     errorBuilder: (context, error, stackTrace) {
                       return Container(
                         color: Colors.grey[300],
                         child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
                       );
                     },
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),

                  Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                        CircleAvatar(
                           radius: 15,
                           backgroundColor: Colors.grey[300],
                           backgroundImage: seller.profileImageUrl != null
                               ? AssetImage(seller.profileImageUrl!)
                               : null,
                           child: seller.profileImageUrl == null
                               ? Icon(Icons.person_outline, size: 18, color: Colors.grey[600])
                               : null,
                         ),
                        const SizedBox(width: 8.0),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                seller.name,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                seller.city,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                     ],
                  ),
                  const SizedBox(height: 8.0),

                   Text(
                    '${product.distanceKm.toStringAsFixed(1)} km away',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}