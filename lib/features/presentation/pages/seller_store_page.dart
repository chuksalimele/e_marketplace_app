// seller_store_page.dart
import 'package:e_marketplace_app/models/data.dart';
import 'package:flutter/material.dart';

class SellerStorePage extends StatefulWidget {
  final String sellerId;
  final String initialProductCategory; // The category the user clicked from on the home page
  final String productName; // The product name the user clicked from (for context, though not strictly used in this page's UI)

  const SellerStorePage({
    Key? key,
    required this.sellerId,
    required this.initialProductCategory,
    required this.productName,
  }) : super(key: key);

  @override
  _SellerStorePageState createState() => _SellerStorePageState();
}

class _SellerStorePageState extends State<SellerStorePage> {
  Seller? _seller;
  String _currentCategory = ''; // The category currently being displayed
  List<Product> _productsInCategory = []; // Products from this seller in the current category

  @override
  void initState() {
    super.initState();
    // Simulate loading seller details and products for the initial category when the page is created
    _loadSellerAndProducts();
  }

  // --- Simulated Data Loading ---
  void _loadSellerAndProducts() {
    // --- Frontend Only Simulation ---
    // In a real app:
    // 1. Fetch seller details using widget.sellerId from backend API.
    // 2. Fetch products for this seller within the widget.initialProductCategory from backend API.
    // 3. Update state with fetched data.

    print('Simulating loading data for seller: ${widget.sellerId}');
    print('Initial category: ${widget.initialProductCategory}');

    // Find the seller in dummy data
    final seller = getSellerById(widget.sellerId);
    if (seller != null) {
       setState(() {
        _seller = seller;
        _currentCategory = widget.initialProductCategory; // Set initial category
        // Get dummy products for this seller and initial category
        _productsInCategory = getProductsBySellerAndCategory(widget.sellerId, category: _currentCategory);
       });
    } else {
       // Handle case where seller is not found (show error, pop page, etc.)
       print('Error: Seller with ID ${widget.sellerId} not found.');
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Seller not found! (Simulated)')),
       );
       // Optionally pop the page if seller data is crucial and missing
       // Navigator.pop(context);
    }
  }

  // --- Simulate Switching Categories ---
  void _switchCategory(String category) {
     // --- Frontend Only Simulation ---
    // In a real app:
    // 1. Send request to backend to get products for this seller and the selected category.
    // 2. Update state with new products received from backend.
     print('Simulating switching to category: $category');

     setState(() {
        _currentCategory = category;
         // Get dummy products for this seller and the newly selected category
        _productsInCategory = getProductsBySellerAndCategory(widget.sellerId, category: _currentCategory);
     });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Switched to category: $category (Simulated)')),
       );
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    // Show loading indicator or error if seller data is not loaded yet
    if (_seller == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Loading Store...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Build the store page once seller data is available
    return Scaffold(
      appBar: AppBar(
        title: Text(_seller!.name), // Seller's store name
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title: Products in current category
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Products in ${_currentCategory}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // List of products in the current category
          Expanded( // Make the list fill remaining space
            child: _productsInCategory.isEmpty
                ? Center(child: Text('No products found in ${_currentCategory} for this seller.'))
                : ListView.builder( // Use ListView for vertical list of products
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: _productsInCategory.length,
                    itemBuilder: (context, index) {
                      final product = _productsInCategory[index];
                      // Using ListTile for product items in the list
                      return ListTile(
                        leading: Container( // Placeholder for product image
                           width: 50,
                           height: 50,
                           color: Colors.grey[300],
                           child: product.imageUrl.startsWith('assets/')
                                ? Image.asset(product.imageUrl, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { return Icon(Icons.image); })
                                : Icon(Icons.image), // Fallback if not an asset path
                         ),
                        title: Text(product.name),
                        subtitle: Text(product.category),
                         trailing: Icon(Icons.arrow_forward_ios, size: 16), // Indicate tappable
                         onTap: () {
                           // In a real app, navigate to a detailed Product Page, passing product.id
                           print('Simulating tapping product: ${product.name}');
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text('Tapped on product: ${product.name} (Simulated)')),
                            );
                         },
                      );
                    },
                  ),
          ),

           const SizedBox(height: 16), // Spacing before categories list

           // Section Title: Other Categories from this Seller
           if (_seller!.categories.isNotEmpty) // Only show if seller has other categories listed in dummy data
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
             child: Text(
                'More from ${_seller!.name}',
               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
           ),

           // List of other categories (horizontal scrollable)
           if (_seller!.categories.isNotEmpty)
            SizedBox( // Give the horizontal list a fixed height
              height: 50, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Make it horizontal
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _seller!.categories.length,
                itemBuilder: (context, index) {
                  final category = _seller!.categories[index];
                  // Highlight the current category
                  final isCurrent = category == _currentCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0), // Spacing between category buttons
                    child: FilterChip( // Use FilterChip for a toggle-like button
                      label: Text(category),
                      selected: isCurrent, // Selected if it's the current category
                      onSelected: (bool selected) {
                         if (!isCurrent) { // Only switch if tapping a different category
                           _switchCategory(category); // Simulate switching
                         }
                      },
                       selectedColor: Theme.of(context).primaryColor,
                       labelStyle: TextStyle(color: isCurrent ? Colors.white : Colors.black),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 80), // Space for FAB to not overlap content
        ],
      ),

      // Floating Action Button (FAB) for Category Navigation
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // --- FAB Action: Show Category Selection ---
           // Simulate showing a bottom sheet with categories to pick.
           print('FAB tapped - showing category options.');
           showModalBottomSheet(
             context: context,
             builder: (BuildContext context) {
               return SafeArea(
                 child: Column(
                    mainAxisSize: MainAxisSize.min, // Make column take minimum space based on content
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Select a Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      // Use a limited height ListView inside the bottom sheet
                       LimitedBox( // Limits the size of its child if it's unbounded
                          maxHeight: 200, // Max height for the category list in the bottom sheet
                          child: ListView.builder(
                           shrinkWrap: true, // Important if inside a Column or Wrap
                           itemCount: _seller!.categories.length,
                           itemBuilder: (context, index) {
                             final category = _seller!.categories[index];
                             return ListTile(
                               title: Text(category),
                               trailing: _currentCategory == category ? Icon(Icons.check, color: Colors.green) : null,
                               onTap: () {
                                  if (_currentCategory != category) {
                                    _switchCategory(category); // Switch category
                                  }
                                 Navigator.pop(context); // Close the bottom sheet
                               },
                             );
                           },
                         ),
                       ),
                      // Add a small padding at the bottom if needed
                       const SizedBox(height: 8),
                   ],
                 ),
               );
             },
           );
        },
        label: Text('Categories'), // Text on the FAB
        icon: const Icon(Icons.category_outlined), // Icon on the FAB
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Position FAB
    );
  }
}