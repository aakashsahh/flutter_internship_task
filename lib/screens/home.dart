import 'package:flutter/material.dart';
import 'package:flutter_internship_task/widgets/products.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductListWidget(),
      // appBar: AppBar(
      //   title: const Text(
      //     "Online Store",
      //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
      //   ),
      //   elevation: 0.0,
      // ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {},
      //     backgroundColor: const Color.fromARGB(255, 48, 14, 77),
      //     child: const Icon(
      //       color: Colors.white,
      //       Icons.shopping_cart,
      //     )),
    );
  }
}
