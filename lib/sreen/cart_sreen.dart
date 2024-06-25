import 'package:ebuy/controller/cart_controller.dart';
import 'package:ebuy/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title:  Text(
            "ebuy",
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
          ),
        ),
     
      body: Obx(() {
        if (cartController.cartList.isEmpty) {
          return Center(
            child: Text(
              "No items in the cart",
              style: TextStyle(fontSize: 18.sp),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartList.length,
                itemBuilder: (context, index) {
                  CartItem cartItem = cartController.cartList[index];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: Row(
                      children: [
                        // Image
                        Container(
                          height: 140.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                cartItem.product.images?[0] ??
                                    "https://imgs.search.brave.com/apJqtvNN-RbG9V___YTunKBNX_9ch9sMaPnz4Rpb7S8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9wZWJi/bGVseS5jb20vY2F0/ZWdvcmllcy9zb2Fw/L3Vuc3BsYXNoLXdv/b2Rlbi5qcGc_d2lk/dGg9NzIwJnF1YWxp/dHk9NzU",
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                cartItem.product.title ?? "Title not found",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              // Price
                              Text(
                                "\$${cartItem.product.price}",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              // Increment/Decrement Container
                              Container(
                                width: 100.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 1.w,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0.r),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          cartController.decrementQuantity(
                                              cartItem.product);
                                        },
                                        child: const Icon(Icons.remove),
                                      ),
                                      Text(
                                        cartItem.quantity.toString(),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cartController.incrementQuantity(
                                              cartItem.product);
                                        },
                                        child: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // Delete Button
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              cartController.removeFromCart(cartItem.product);
                            },
                            child: Icon(
                              Icons.delete,
                              size: 35.r,
                              color: Colors.red.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // SizedBox(height: 12.h),
            // const Divider(color: Colors.black38),
            SizedBox(height: 12.h),
            // Subtotal
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subtotal:",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "\$ ${cartController.totalPrice.toString()}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Shipping
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shipping:",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "\$ ${cartController.totalPrice.toString()}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            const Divider(color: Colors.black38),
            SizedBox(height: 12.h),
            // Total
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "\$${cartController.totalPrice}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: InkWell(
                onTap: () {
                  // Implement your order placement logic here
                  // This could include navigating to a checkout screen or performing payment processing
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: Center(
                    child: Text(
                      "Order Now",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        );
      }),
    );
  }
}
