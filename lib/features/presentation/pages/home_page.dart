// home_page.dart - REMOVED errorBuilder from DecorationImage in Carousel

import 'package:e_marketplace_app/features/presentation/widgets/seller_card.dart';
import 'package:e_marketplace_app/models/data.dart';
import 'package:flutter/material.dart';
// Import carousel_slider with a prefix (alias)
import 'package:carousel_slider/carousel_slider.dart' as carousel; // <-- ADDED 'as carousel'
// seller_store_page.dart is navigated via named route, no direct import needed here

// home_page.dart - Carousel Clickable & Sticky Search Bar with Combined Scrolling
// home_page.dart - Search Results Label Added Back Correctly

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _searchResults = dummyProductsOnitsha; // Products currently displayed in the grid
  String _currentCity = 'Onitsha';
  final TextEditingController _searchController = TextEditingController();

  bool _isLoggedIn = false; // Simulate login state

   void _toggleLoginStatus() {
      setState(() {
         _isLoggedIn = !_isLoggedIn;
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Simulating: User is now ${_isLoggedIn ? 'Logged In' : 'Logged Out'}')),
          );
      });
   }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    print('Performing search for: "$query" in $_currentCity');
    // In a real app, this would fetch data based on location, query, and potentially user tier
    setState(() {
      if (query.isEmpty) {
        _searchResults = dummyProductsOnitsha; // Show all dummy products in the city if search is empty
      } else {
        _searchResults = dummyProductsOnitsha
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()) ||
                product.sellerName.toLowerCase().contains(query.toLowerCase()) ||
                 product.category.toLowerCase().contains(query.toLowerCase())
                )
            .toList();

         // Simulate sorting by distance (dummy data already has distance)
         _searchResults.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
      }
    });

     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Search simulated for "$query"')),
     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // --- Sticky AppBar with Search Bar ---
            SliverAppBar(
              title: const Text('Buyer Marketplace'),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 1,
              pinned: true,
              floating: false,
              expandedHeight: kToolbarHeight + 72.0,

              actions: [
                IconButton(
                   icon: Icon(_isLoggedIn ? Icons.logout : Icons.login),
                   tooltip: _isLoggedIn ? 'Simulate Logout' : 'Simulate Login',
                   onPressed: _toggleLoginStatus,
                ),
                TextButton.icon(
                  onPressed: () {
                     print('Simulating city selection');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Current City: $_currentCity (Tap to Change - Simulated)')),
                     );
                  },
                  icon: const Icon(Icons.location_on_outlined),
                  label: Text(_currentCity),
                  style: TextButton.styleFrom(foregroundColor: Colors.black54),
                ),
                if (!_isLoggedIn)
                  TextButton(
                     onPressed: () {
                        Navigator.pushNamed(context, '/login');
                     },
                     child: const Text('Login'),
                     style: TextButton.styleFrom(foregroundColor: Theme.of(context).primaryColor),
                  ),
              ],

              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(72.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for products...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    ),
                     onSubmitted: _performSearch,
                  ),
                ),
              ),
            ),
            // <------------------------------------------>

            // --- Advertisement Carousel (SliverToBoxAdapter) ---
             if (dummyAdvertisedProducts.isNotEmpty)
             SliverToBoxAdapter(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                     child: Text('Featured Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                   ),
                   carousel.CarouselSlider.builder(
                     itemCount: dummyAdvertisedProducts.length,
                     itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                       final product = dummyAdvertisedProducts[itemIndex];
                       final seller = getSellerById(product.sellerId);

                       return InkWell(
                          onTap: () {
                             print('Tapped on carousel item: ${product.name}');
                             Navigator.pushNamed(
                               context,
                               '/seller_store',
                               arguments: {
                                 'sellerId': product.sellerId,
                                 'initialProductCategory': product.category,
                                 'productName': product.name,
                               },
                             );
                          },
                          child: Container(
                             margin: const EdgeInsets.symmetric(horizontal: 5.0),
                             decoration: BoxDecoration(
                                color: Colors.blueGrey[100],
                                borderRadius: BorderRadius.circular(10.0),
                                 image: DecorationImage(
                                    image: AssetImage(product.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                             ),
                             child: Stack(
                                children: [
                                   Container(
                                      decoration: BoxDecoration(
                                         color: Colors.black.withOpacity(0.3),
                                         borderRadius: BorderRadius.circular(10.0),
                                      ),
                                   ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          product.sellerName,
                                           style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14.0,
                                          ),
                                           maxLines: 1,
                                           overflow: TextOverflow.ellipsis,
                                        ),
                                         if (seller != null)
                                          Text(
                                           'Tier ${seller.tier}',
                                            style: const TextStyle(
                                             color: Colors.amberAccent,
                                             fontSize: 12.0,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                             ),
                          ),
                       );
                     },
                     options: carousel.CarouselOptions(
                       height: 180.0,
                       enlargeCenterPage: true,
                       autoPlay: true,
                       aspectRatio: 16 / 9,
                       autoPlayCurve: Curves.fastOutSlowIn,
                       enableInfiniteScroll: true,
                       autoPlayAnimationDuration: const Duration(milliseconds: 800),
                       viewportFraction: 0.8,
                     ),
                   ),
                 ],
               ),
             ),
            // <-------------------------------------------------->

             // --- ADDED: Search Results Label (SliverToBoxAdapter) ---
             SliverToBoxAdapter( // Wrap Padding in SliverToBoxAdapter to include it in CustomScrollView
               child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                     child: Align(
                       alignment: Alignment.centerLeft,
                       child: Text(
                         _searchResults.isEmpty ? 'No results found' : 'Products near you',
                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                         ),
                     ),
                   ),
             ),
            // <---------------------------------------------------->


            // --- Search Results GridView (SliverGrid) ---
             SliverPadding( // Use SliverPadding to add padding around the grid
                padding: const EdgeInsets.all(16.0),
                sliver: _searchResults.isEmpty
                   ? SliverFillRemaining(
                       child: Center(child: Text('Search or browse for products.')),
                      hasScrollBody: false,
                     )
                   : SliverGrid.builder(
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         crossAxisSpacing: 16.0,
                         mainAxisSpacing: 16.0,
                         childAspectRatio: 0.75,
                       ),
                       itemCount: _searchResults.length,
                       itemBuilder: (context, index) {
                         final product = _searchResults[index];
                         return SellerCard(product: product);
                       },
                     ),
             ),
            // <------------------------------------------>
          ],
        ),
      ),
    );
  }
}
