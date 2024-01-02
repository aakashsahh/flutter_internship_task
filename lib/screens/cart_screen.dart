import 'package:flutter/material.dart';
import 'package:flutter_internship_task/models/cart_item.dart';
import 'package:flutter_internship_task/screens/detail_screen.dart';

class Cart {
  List<CartItem> items = [];
}

class CartScreen extends StatefulWidget {
  final Cart cart;
  final List<CartItem> cartItems;

  const CartScreen({Key? key, required this.cart, required this.cartItems}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    calculateTotalPrice();
  }

//To calculate total price of products in the cart
  void calculateTotalPrice() {
    double total = 0;
    for (var cartItem in widget.cartItems) {
      total += cartItem.product.price * cartItem.quantity;
    }
    setState(() {
      totalPrice = total;
    });
  }

//To remove products from cart
  void removeCartItem(CartItem cartItem) {
    setState(() {
      widget.cartItems.remove(cartItem);
      calculateTotalPrice(); // Update the total price
    });
  }

  //to increase quantity of product
  void increaseQuantity(CartItem cartItem) {
    setState(() {
      cartItem.quantity++;
      calculateTotalPrice();
    });
  }

  //to decrease quantity of product
  void decreaseQuantity(CartItem cartItem) {
    setState(() {
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
        calculateTotalPrice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.deepPurple),
        ),
      ),
      body: Column(
        children: [
          // Display cart items
          Expanded(
            child: widget.cartItems.isNotEmpty
                ? ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = widget.cartItems[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(product: cartItem.product),
                                  ));
                            },
                            leading: Image.network(cartItem.product.image),
                            title: Text(
                              cartItem.product.title,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            subtitle: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    decreaseQuantity(cartItem);
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Expanded(
                                    child: Text(
                                  '${cartItem.quantity}',
                                  textAlign: TextAlign.center,
                                )),
                                IconButton(
                                  onPressed: () {
                                    increaseQuantity(cartItem);
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 50,
                              child: Text(
                                '\$${cartItem.product.price * cartItem.quantity}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400, color: Colors.deepPurpleAccent),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            onLongPress: () {
                              removeCartItem(cartItem);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Sucessfully removed from cart!!'),
                              ));
                            },
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ),
          ),
          // Display total price
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          // Checkout button
          ElevatedButton(
            onPressed: () {
              // Implement the checkout functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Checkout functionality not implemented')),
              );
            },
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
