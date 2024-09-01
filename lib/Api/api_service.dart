import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/meal.dart';
import 'package:recipe_app/models/meal_details.dart';

class ApiService {
  static const String apikey = '3a50d11f005c409cb1c5dae246c67020';
  static Future<List<Meal>> getAllMeals() async {
    const String baseUrl =
        "https://api.spoonacular.com/recipes/comp1exsearch?apikey=$apikey";

    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> parsed = jsonDecode(response.body)['results'];
        return parsed.map((element) => Meal.fromjson(element)).toList();
      } else {
        throw Exception('Faild to load meals');
      }
    } catch (e) {
      throw Exception('Faild to load meals $e');
    }
  }

  static Future<MealDetails> getMealDetails(int id) async {
    String baseurl =
        'https//api.spoonacular.com/recipes/$id/information?apikey=$apikey&includeNuterition=false';
    try {
      final response = await http.get(Uri.parse(baseurl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> parsed = jsonDecode(response.body);
        return MealDetails.fromjson(parsed);
      } else {
        throw Exception('Faild to load meal details');
      }
    } catch (e) {
      throw Exception('Faild to load meal details $e');
    }
  }
}
