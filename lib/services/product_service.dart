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

  Future<List<Product>> searchProducts(String query) async {
  try {
    final response = await http.get(Uri.parse('$apiUrl?q=$query'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print('Search query: $query');
      print('API response: $data');
      return List<Product>.from(data.map((json) => Product.fromJson(json)));
    } else {
      print('Error in API response: ${response.statusCode}');
      print('Raw API response: ${response.body}');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}

}
