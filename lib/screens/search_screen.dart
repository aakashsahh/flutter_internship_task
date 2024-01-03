import 'package:flutter/material.dart';
import 'package:flutter_internship_task/models/product_model.dart';
import 'package:flutter_internship_task/screens/detail_screen.dart';

class SearchPage extends StatefulWidget {
  final List<Product> allProducts;
  final Function(dynamic) onSearch;

  const SearchPage({
    Key? key,
    required this.allProducts,
    required this.onSearch,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  late List<Product> searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all products
      setState(() {
        searchResults = widget.allProducts;
      });
    } else {
      // Perform the search based on the query
      setState(() {
        searchResults =
            widget.allProducts.where((product) => product.title.toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(labelText: 'Search'),
              onChanged: _performSearch,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call the onSearch function with the search query
                widget.onSearch(_searchController.text);
              },
              child: const Text('Search'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
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
                    ),
                  );
                },
              ),
            ),
            if (searchResults.isEmpty) // Check if there are no search results
              const Text('No results found.'), // Display an error message
          ],
        ),
      ),
    );
  }
}
