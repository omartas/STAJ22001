
// lib/main.dart
import 'package:e_commerce_getx/controllers/auth_controller.dart';
import 'package:e_commerce_getx/controllers/theme_controller.dart';
import 'package:e_commerce_getx/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/login_screen.dart';
import 'views/home_screen.dart';
import 'views/product_detail_screen.dart';
import 'views/cart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final authController = Get.put(AuthController(), permanent: true);
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  // Check login status
  await authController.checkLoginStatus();
  bool isLoggedIn =await AuthService.isLoggedIn();
  
  // Initialize AuthController and ThemeController
  Get.put(AuthController(), permanent: true);
  Get.put(ThemeController(), permanent: true);
  
  runApp(MyApp(isLoggedIn: isLoggedIn));
  
  
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter E-commerce',
      
      initialRoute: isLoggedIn ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/productDetail', page: () => ProductDetailScreen()),
        GetPage(name: '/cart', page: () => CartScreen()),
      ],
    );
  }
}
