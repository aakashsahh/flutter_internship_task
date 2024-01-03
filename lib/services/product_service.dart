import 'dart:convert';
import 'package:flutter_internship_task/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String apiUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      if (data != null) {
        return List<Product>.from(data.map((json) => Product.fromJson(json)));
      } else {
        throw Exception('API response is null');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
