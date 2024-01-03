import 'package:flutter/material.dart';
import 'package:flutter_internship_task/models/product_model.dart';
import 'package:flutter_internship_task/screens/cart_screen.dart';
import 'package:flutter_internship_task/screens/detail_screen.dart';
import 'package:flutter_internship_task/screens/search_screen.dart';
import 'package:flutter_internship_task/services/product_service.dart';
import 'package:flutter_internship_task/models/cart_item.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final ProductService _productService = ProductService();
  late List<Product> _products = []; // Initialize with an empty list
  final List<CartItem> _cartItems = []; // Maintain a list of cart items
  late List<Product> _allProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _productService.fetchProducts();
      setState(() {
        _allProducts = products;
        _products = products;
      });
    } catch (e) {
      // Show a SnackBar with a generic error message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Unable to load products!'),
      ));
    }
  }
  void _searchProducts(dynamic result) {
  setState(() {
    if (result is String) {
      // Show all products
      _products = _allProducts;
    } else if (result is List<Product>) {
      // Show search results
      _products = result;
    }
  });
}

  //To add products in cart
  void addToCart(Product product) {
    // Check if the product is already in the cart
    var cartItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product),
    );

    // If the product is in the cart, increase the quantity, otherwise add a new item
    if (_cartItems.contains(cartItem)) {
      cartItem.quantity++;
    } else {
      _cartItems.add(cartItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Online Store",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.deepPurple),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SearchPage(
                    allProducts: _allProducts,
                      onSearch: _searchProducts,
                  )),
                );
              },
              icon: const Icon(
                Icons.search,
                color: Colors.deepPurple,
              ),
            ),
          )
        ],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Open the cart screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen(cart: Cart(), cartItems: _cartItems)),
            );
          },
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
                              leading: Image.network(product.image),
                              title: Text(
                                product.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
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
                                    addToCart(product);
                                  },
                                  child: const Row(
                                    children: [
                                      Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )
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
