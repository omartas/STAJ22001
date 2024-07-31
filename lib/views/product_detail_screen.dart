// lib/views/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  final Product product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            Image.network(
              product.image,
              height: 250,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10),
            Text(product.title, style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text('${product.price} TL', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                cartController.addToCart(product);
              },
              child: Text('Add to Cart'),
            ),
            Text(product.description),
            
          ],
        ),
      ),
    );
  }
}
