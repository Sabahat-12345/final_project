import 'dart:convert';
import 'package:final_project/models/news_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var newsList = <Article>[].obs;

  final String _apiKey =
      '3706be01c9074ec1aa89b22f5939c2ac'; // Replace with your actual API key
  final String _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey';

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  void fetchNews() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('$_baseUrl&apiKey=$_apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newsResponse = NewsResponse.fromJson(data);
        newsList.assignAll(newsResponse.articles);
      } else {
        Get.snackbar("Error",
            "Failed to load news. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }
}
