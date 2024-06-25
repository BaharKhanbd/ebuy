import 'dart:convert';


import 'package:ebuy/model/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  List<ProductModel> postList = [];

  Future<List<ProductModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // postList.clear();  
      for (Map<String, dynamic> item in data) {
        postList.add(ProductModel.fromJson(item));
      }
      return postList;
    } else {
      return postList;
    }
  }
}