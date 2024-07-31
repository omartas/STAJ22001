// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/user.dart';

class ApiService {
  static var client = http.Client();
  static const String _baseUrl = 'https://fakestoreapi.com';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
static Future<List<Product>> fetchProductsByCategory(String category) async {
    var response = await client.get(Uri.parse('$_baseUrl/products/category/$category'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      // Eger hata varsa, bos bir liste döndürelim
      return [];
    }
  }
  Future<User> fetchUser(String username, String password) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/1'));
    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body));
      if (user.username == username && user.password == password) {
        return user;
      } else {
        throw Exception('Invalid username or password');
      }
    } else {
      throw Exception('Failed to load user');
    }
  }
}
