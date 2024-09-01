import 'package:flutter/material.dart';
import 'package:recipe_app/models/meal.dart';

class MealDetails {
  int id;
  String title;
  int servings;
  String image;
  int readyInMinute;
  List<ExtendedIngrediant> ingrediants;
  MealDetails({
    required this.id,
    required this.title,
    required this.servings,
    required this.image,
    required this.readyInMinute,
    required this.ingrediants,
  });

  factory MealDetails.fromjson(Map<String, dynamic> json){
    return MealDetails(
      id: (json['id'] as num).toInt(),
     title: (json['title']as num).toString(),
      servings: json['servings'],
       image: json['image'],
        readyInMinute: (json ['readyMinutes']as num).toInt(),
         ingrediants:( json ['extendedIngredients']as List<dynamic>)
         .map((element) => ExtendedIngrediant.fromjson(element))
         .toList());
  }
}

class ExtendedIngrediant {
  int id;
  int amount;
  String name;
  String unit;

  ExtendedIngrediant({
    required this.id,
    required this.amount,
    required this.name,
    required this.unit,
  });

  factory ExtendedIngrediant.fromjson(Map<String, dynamic> json) {
    return ExtendedIngrediant(
      id: (json['id']as num).toInt(),
       amount: (json['amount']as num).toInt(),
        name: json['name'],
         unit: json['unit'] );
  }
}
