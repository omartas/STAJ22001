
// lib/controllers/product_controller.dart
import 'package:get/get.dart';
import 'package:e_commerce_getx/models/product.dart';
import 'package:e_commerce_getx/services/api_service.dart';

class ProductController extends GetxController {
  var allProducts = <Product>[].obs;
  var products = <Product>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoriesAndProducts();
  }

  Future<void> fetchCategoriesAndProducts() async {
    try {
      final fetchedProducts = await ApiService.fetchProducts();
      allProducts.value = fetchedProducts;
      products.value = fetchedProducts;

      // Extract unique categories
      final uniqueCategories = fetchedProducts
          .map((product) => product.category)
          .toSet()
          .toList();
      categories.value = ['All Products', ...uniqueCategories];
    } catch (e) {
      // Handle errors
    }
  }

  void filterProductsByCategory(String category) {
    selectedCategory.value = category;
    if (category.isEmpty || category == 'All Products') {
      products.value = allProducts;
    } else {
      products.value = allProducts.where((product) => product.category == category).toList();
    }
  }
}




/*
// lib/controllers/product_controller.dart
import 'package:get/get.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
    print(productList);
  }

  void fetchProducts() async {
    try {
      isLoading(true);
       var products = await ApiService.fetchProducts();
      if (products != null) {
        productList.assignAll(products);
        print(productList);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchProductsByCategory(String category) async {
    try {
      isLoading(true);
      var products = await ApiService.fetchProductsByCategory(category);
      if (products != null) {
        productList.assignAll(products);
        print(productList);
      }
    } finally {
      isLoading(false);
    }
  }
}

*/