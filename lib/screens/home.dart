import 'package:flutter/material.dart';
import 'package:flutter_internship_task/widgets/products.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductListWidget(),
    );
  }
}
