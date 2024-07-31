// lib/views/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find<CartController>();

  //var cartItems = cartController.cartItems.first.price;
  double  totalPrice=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (cartController.cartItems.isEmpty) {
                return Center(child: Text('Your cart is empty'));
              } else {
                return ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    var product = cartController.cartItems[index];
                    return ListTile(
                      leading: Image.network(product.image, width: 50),
                      title: Text(product.title),
                      subtitle: Text('${product.price} TL'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          cartController.cartItems.removeAt(index);
                        },
                      ),
                    );
                  },
                );
              }
            }),
          ),
          Padding(padding: EdgeInsets.all(5),
          child: Obx(() {
              double totalPrice = cartController.cartItems.fold(0, (sum, item) => sum + item.price);
              return Text(
                'Total Price: ${totalPrice.toStringAsFixed(2)} TL',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),),
        ElevatedButton(onPressed: (){}, child: Text("Odemeye Gec"),)
        ],
        
      ),
    );
  }
}
