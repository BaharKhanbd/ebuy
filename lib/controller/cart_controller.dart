import 'package:ebuy/model/cart.dart';
import 'package:ebuy/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartList = <CartItem>[].obs;

  int get count => cartList.length;

  double get totalPrice => cartList.fold(0, (sum, item) => sum + item.product.price! * item.quantity);

  void addToCart(ProductModel product) {
    var existingItem = cartList.firstWhereOrNull((element) => element.product.id == product.id);

    if (existingItem != null) {
      Get.snackbar(
        'Already in Cart',
        '${product.title} is already in your cart.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.only(top: 5.h),
      );
    } else {
      cartList.add(CartItem(product: product));
    }
  }

  void removeFromCart(ProductModel product) {
    cartList.removeWhere((element) => element.product.id == product.id);
  }

  void incrementQuantity(ProductModel product) {
    var existingItem = cartList.firstWhereOrNull((element) => element.product.id == product.id);

    if (existingItem != null) {
      existingItem.quantity += 1;
      cartList.refresh();
    }
  }

  void decrementQuantity(ProductModel product) {
    var existingItem = cartList.firstWhereOrNull((element) => element.product.id == product.id);

    if (existingItem != null && existingItem.quantity > 1) {
      existingItem.quantity -= 1;
      cartList.refresh();
    } else {
      removeFromCart(product);
    }
  }
}
