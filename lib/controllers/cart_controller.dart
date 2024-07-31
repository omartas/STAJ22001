// lib/controllers/cart_controller.dart
import 'package:get/get.dart';
import '../models/product.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  void addToCart(Product product) {
    cartItems.add(product);
    Get.snackbar('Success', 'Product added to cart');
  }

  int get cartCount => cartItems.length;
}
