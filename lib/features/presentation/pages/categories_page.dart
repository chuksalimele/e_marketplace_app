// categories_page.dart - REAL WORLD CODE
import 'package:e_marketplace_app/models/data.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  void _onCategoryTapped(BuildContext context, String category) {
    // In a real app, you would navigate to a products listing page,
    // passing the selected category as an argument.
    print('Tapped on category: $category');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing products in "$category" (Simulated)')),
    );
    // Example navigation (if you had a products_list_page.dart)
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsListPage(category: category)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop by Categories'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: dummyProductCategories.isEmpty
          ? const Center(
              child: Text(
                'No categories available yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two categories per row
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.2, // Adjust aspect ratio for better look
              ),
              itemCount: dummyProductCategories.length,
              itemBuilder: (context, index) {
                final category = dummyProductCategories[index];
                // You could map specific icons or images to categories if you expand data.dart
                IconData categoryIcon = Icons.category_outlined;
                switch (category) {
                  case 'Electronics': categoryIcon = Icons.devices_other; break;
                  case 'Groceries': categoryIcon = Icons.local_grocery_store; break;
                  case 'Fashion': categoryIcon = Icons.dry_cleaning; break;
                  case 'Home Goods': categoryIcon = Icons.home_work_outlined; break;
                  case 'Books': categoryIcon = Icons.book_outlined; break;
                  case 'Sports': categoryIcon = Icons.sports_baseball_outlined; break;
                  case 'Beauty': categoryIcon = Icons.face_outlined; break;
                  default: categoryIcon = Icons.category_outlined;
                }

                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () => _onCategoryTapped(context, category),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(categoryIcon, size: 50, color: Theme.of(context).primaryColor),
                        const SizedBox(height: 10),
                        Text(
                          category,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}