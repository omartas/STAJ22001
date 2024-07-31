// lib/controllers/auth_controller.dart
import 'package:e_commerce_getx/controllers/product_controller.dart';
import 'package:get/get.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  
  var isLoggedIn = false.obs;
  var username = ''.obs;
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }
  var user = User(
    id: 0,
    email: '',
    username: '',
    password: '',
    name: Name(firstname: '', lastname: ''),
    phone: '',
    address: Address(
      geolocation: Geolocation(lat: '', long: ''),
      city: '',
      street: '',
      number: 0,
      zipcode: '',
    ),
  ).obs;

  void login(String username, String password) async {
    String token = "dummy_token";
    try {
      User fetchedUser = await ApiService().fetchUser(username, password);
      user.value = fetchedUser;
      isLoggedIn.value = true;
      await AuthService.login(token);
      this.username.value = username;
    
      Get.offAllNamed('/home');
    
      
    } catch (e) {
      Get.snackbar('Error', 'Invalid username or password $e');
    }
  }
  Future<void> logout() async {
    await AuthService.logout();
    username.value = '';
    Get.offAllNamed('/login'); // Çıkış yaptıktan sonra login ekranına dön
  }
  Future<bool> checkLoginStatus() async {
    isLoggedIn.value = await AuthService.isLoggedIn();
    if (isLoggedIn.value) {
      username.value = await AuthService.getUsername() ?? '';
    }
    return isLoggedIn.value;
  }
  
}
