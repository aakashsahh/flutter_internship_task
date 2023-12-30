import 'package:flutter/material.dart';
import 'package:flutter_internship_task/models/product_model.dart';
import 'package:flutter_internship_task/services/product_service.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final ProductService _productService = ProductService();
  late List<Product> _products = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _productService.fetchProducts();
      setState(() {
        _products = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
      // Show a SnackBar with a generic error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error Loading products. Please try again later')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: _products.isNotEmpty // Check if the list is not empty
          ? ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(
                    product.title,
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text('\$${product.price.toString()}'),
                  // Add more UI components as needed (e.g., product image)
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
