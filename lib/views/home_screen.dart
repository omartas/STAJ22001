

// lib/views/home_screen.dart
import 'package:e_commerce_getx/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce_getx/controllers/product_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';

class HomeScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  final AuthController authController = Get.put(AuthController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(()=> Text(productController.selectedCategory.value)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: Obx(() => Stack(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.only(left: 40.0),
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () => Get.toNamed('/cart'),
                    ),
                    if (cartController.cartCount > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            cartController.cartCount.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                )),
          ),
        ],
      ),
      drawer: HomePageDrawer(authController: authController, productController: productController),
      body: Obx(() {
        if (productController.allProducts.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
          ),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed('/productDetail', arguments: product);
              },
              child: Card(
                shadowColor: Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      product.image,
                      height: 155,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product.title, maxLines: 2),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${product.price} TL'),
                          Text('${product.rating.rate} *'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
      }),
    );
  }
}

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key? key,
    required this.authController,
    required this.productController,
  }) : super(key: key);

  final AuthController authController;
  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:24.0),
      child: Drawer(
        child: Column(

          children: [
            SizedBox(height: 25,),
            Obx(() => Text(
              'Merhaba, ${authController.username.value}',
              style: TextStyle(fontSize: 24),
            )),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: productController.categories.length,
                itemBuilder: (context, index) {
                  final category = productController.categories[index];
                  return Card(
                    child: ListTile(
                      title: Text(category),
                      onTap: () {
                        productController.filterProductsByCategory(category);
                        Get.back(); // Close the drawer
                      },
                    ),
                  );
                },
              )),
            ),
            TextButton(onPressed: (){authController.logout();}, child:Text("Cikis Yap"))
          ],
        ),
      ),
    );
  }
}




class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    Key? key,
    required this.productController,
  }) : super(key: key);

  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.allProducts.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
          ),
          itemCount: productController.allProducts.length,
          itemBuilder: (context, index) {
            var product = productController.allProducts[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed('/productDetail', arguments: product);
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      product.image,
                      height: 175,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product.title, maxLines: 2),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${product.price} TL'),
                          Text('${product.rating.rate}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }
}

/*
// lib/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  
  final AuthController authController = Get.put(AuthController());

  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          Obx(() => Stack(
                children: [
                  IconButton(
                    padding: const EdgeInsets.only(left: 40.0),
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () => Get.toNamed('/cart'),
                  ),
                  if (cartController.cartCount > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cartController.cartCount.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    IconButton(
                      
                      icon: Icon(Icons.exit_to_app),
                      onPressed: authController.logout,
          ),
                ],
              )),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Categories'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            // Kategorileri dinamik olarak listelemek için
            Obx(() {
              var categories = productController.productList
                  .map((product) => product.category)
                  .toSet()
                  .toList();
                  print("$categories : categories");
                  print(productController.productList);
              return Column(
                children: categories.map((category) {
                  return ListTile(
                    title: Text(category),
                    onTap: () {
                      // Kategoriye göre filtreleme işlemi
                      productController.fetchProducts();
                      print("$category : category");
                      print(productController.productList);
                      Get.back();
                    },
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
      body: Obx(() {
        if (productController.productList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
            ),
            itemCount: productController.productList.length,
            itemBuilder: (context, index) {
              var product = productController.productList[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed('/productDetail', arguments: product);
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        product.image,
                        height: 175,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product.title, maxLines: 2),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$${product.price}'),
                            Text('${product.rating.rate}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
*/