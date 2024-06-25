import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebuy/controller/product_controller.dart';
import 'package:ebuy/controller/slider_controller.dart';
import 'package:ebuy/model/product_model.dart';
import 'package:ebuy/sreen/details_page_sreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePageSreen extends StatefulWidget {
  const HomePageSreen({super.key});

  @override
  State<HomePageSreen> createState() => _HomePageSreenState();
}

class _HomePageSreenState extends State<HomePageSreen> {
  final CarouselController carouselController = CarouselController();
  final CarouselIndexController carouselIndexController =
      Get.put(CarouselIndexController());

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("ebuy",
            style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: productController.getPostApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching data"));
          } else {
            var productImages = snapshot.data
                ?.expand((product) => product.images ?? [])
                .toList();
            return Column(
              children: [
                if (productImages != null && productImages.isNotEmpty)
                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: CarouselSlider(
                          items: productImages
                              .map(
                                (url) => Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  width: double.infinity.w,
                                ),
                              )
                              .toList(),
                          carouselController: carouselController,
                          options: CarouselOptions(
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            aspectRatio: 2,
                            viewportFraction: 0.8,
                            onPageChanged: (index, reason) {
                              carouselIndexController.updateIndex(index);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Categories",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward, size: 24.sp),
                              onPressed: () {
                                // Handle arrow button press
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        height: 220.h, // Adjust height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            var category = snapshot.data?[index].category;
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: GestureDetector(
                                onTap: () {
                                  
                                },
                                child: Container(
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2.r,
                                        blurRadius: 5.r,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      // Category Image
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          child: Image.network(
                                            category?.image ??
                                                "https://via.placeholder.com/100",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // Go to Text
                                      Positioned(
                                        left: 8.w,
                                        bottom: 8.h,
                                        child: InkWell(
                                          onTap: (){},
                                          child: Container(
                                            height:
                                                30.h, // Set the desired height
                                            width: 70.w, // Set the desired width
                                            padding: EdgeInsets.only(left: 4.w,right: 4.w), 
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(255, 231, 236, 231), // Set your desired background color here
                                              borderRadius: BorderRadius.circular(
                                                  8.0.r), // Set border radius here
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Go to",
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Category Name Text
                                      Positioned(
                                        left: 8.w,
                                        top: 8.h,
                                        child: Text(
                                          category?.name.toString() ??
                                              "Category",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 3.r,
                                                color: Colors.black,
                                                offset: Offset(1.r, 1.r),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h,),
                   Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Best Selling",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward, size: 24.sp),
                              onPressed: () {
                                // Handle arrow button press
                              },
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 16.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      var product = snapshot.data?[index];
                      return Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: GestureDetector(
                          onTap: () {
                            if (product != null) {
                              Get.to(DetailsScreen(product: product));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2.r,
                                  blurRadius: 5.r,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image
                                Container(
                                  height: 200.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(product?.images?[0] ??
                                          "https://imgs.search.brave.com/apJqtvNN-RbG9V___YTunKBNX_9ch9sMaPnz4Rpb7S8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9wZWJi/bGVseS5jb20vY2F0/ZWdvcmllcy9zb2Fw/L3Vuc3BsYXNoLXdv/b2Rlbi5qcGc_d2lk/dGg9NzIwJnF1YWxp/dHk9NzU"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.r),
                                      topRight: Radius.circular(8.r),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                // Category Name
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Text(
                                    product?.category?.name.toString() ??
                                        "Title not found",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                // Product Title
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Text(
                                    product?.title.toString() ??
                                        "Title not found",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                // Price
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Text(
                                    "\$${product?.price.toString() ?? 'Price not found'}",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
