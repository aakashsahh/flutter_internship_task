import 'package:flutter/material.dart';
import 'package:flutter_internship_task/models/product_model.dart';
import 'package:flutter_internship_task/screens/detail_screen.dart';
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
        title: const Text(
          "Online Store",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color.fromARGB(255, 48, 14, 77),
          child: const Icon(
            color: Colors.white,
            Icons.shopping_cart,
          )),
      body: _products.isNotEmpty // Check if the list is not empty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(product: product),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            ListTile(
                              leading: Hero(
                                tag: Key(product.id.toString()),
                                child: Image.network(product.image),
                              ),
                              title: Text(product.title),
                              trailing: Text(
                                '\$${product.price}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.end,
                              buttonPadding: EdgeInsets.zero,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    //addToCart(product);
                                  },
                                  child: const Row(
                                    children: [
                                      Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )
                                      // Text(
                                      //   //isInCart ? "Done" : "Add to Cart",
                                      //   style: const TextStyle(
                                      //     fontSize: 16,
                                      //   ),
                                      // ),
                                      // Visibility(
                                      //   visible: isInCart,
                                      //   child: const Icon(Icons.done),
                                      // ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ]),
                        ),
                      ));
                },
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
