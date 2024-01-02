import 'package:flutter/material.dart';
import 'package:flutter_internship_task/models/product_model.dart';
import 'package:flutter_internship_task/screens/detail_screen.dart';
import 'package:flutter_internship_task/services/product_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ProductService _productService = ProductService();
  List<Product> _searchResults = [];

  Future<void> _searchProducts(String query) async {
    try {
      print('Search query: $query');
      final results = await _productService.searchProducts(query);
      print('Search results: $results');
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      // Handle error fetching products
      print('Error searching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for products',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final String searchQuery = _searchController.text;
                    _searchProducts(searchQuery);
                  },
                ),
              ),
            ),
          ),
          // Display the search results
          Expanded(
            child: _searchResults.isNotEmpty
                ? ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final product = _searchResults[index];
                      return ListTile(
                        leading: Image.network(product.image),
                        title: Text(product.title),
                        subtitle: Text('Price: \$${product.price}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(product: product),
                            ),
                          );
                        },
                      );
                    },
                  )
                : const Center(
                    child: Text('No results found'),
                  ),
          ),
        ],
      ),
    );
  }
}
