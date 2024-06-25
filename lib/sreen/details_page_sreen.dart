import 'package:ebuy/controller/cart_controller.dart';
import 'package:ebuy/model/product_model.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebuy/sreen/cart_sreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "ebuy",
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Get.to(const CartScreen());
            },
            child: Padding(
              padding: EdgeInsets.only(right: 12.w, left: 10.w),
              child: badges.Badge(
                badgeContent: SizedBox(
                  width: 15.w,
                  height: 15.h,
                  child: Obx(
                    () => Center(
                      child: Text(
                        cartController.count.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  size: 30.r,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(12.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider for Images
              if (product?.images != null && product!.images!.isNotEmpty)
                CarouselSlider.builder(
                  itemCount: product!.images!.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return Container(
                      height: 300.h,
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(product!.images![index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 300.h,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                )
              else
                Container(
                  height: 300.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://imgs.search.brave.com/apJqtvNN-RbG9V___YTunKBNX_9ch9sMaPnz4Rpb7S8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9wZWJi/bGVseS5jb20vY2F0/ZWdvcmllcy9zb2Fw/L3Vuc3BsYXNoLXdv/b2Rlbi5qcGc_d2lk/dGg9NzIwJnF1YWxp/dHk9NzU",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              //single image
              // Container(
              //   height: 300.h,
              //   width: double.infinity.w,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage(product?.images?[0] ??
              //           "https://imgs.search.brave.com/apJqtvNN-RbG9V___YTunKBNX_9ch9sMaPnz4Rpb7S8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9wZWJi/bGVseS5jb20vY2F0/ZWdvcmllcy9zb2Fw/L3Vuc3BsYXNoLXdv/b2Rlbi5qcGc_d2lk/dGg9NzIwJnF1YWxp/dHk9NzU"),
              //       fit: BoxFit.fill,
              //     ),
              //     borderRadius: BorderRadius.all(
              //         Radius.circular(8.r)),
              //   ),
              // ),
              //end image
              SizedBox(height: 16.h),
              // Title
              Text(
                product?.title ?? "Product Title",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              // Details
              Text(
                "Details",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              // Description
              Text(
                product?.description ?? "Product Description",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 12.h),
              const Divider(color: Colors.black38),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Price
                  Text(
                    "Price \n\$${product?.price.toString() ?? '0.00'}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (product != null) {
                        cartController.addToCart(product!);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50.w,
                        vertical: 15.h,
                      ),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
