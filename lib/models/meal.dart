import 'package:flutter/material.dart';

class Meal {
  int id;
  String image, title;

  Meal({
    required this.id,
    required this.image,
    required this.title,
  });

  factory Meal.fromjson(Map<String, dynamic> json) {
    return Meal(id: json['id'], image: json['image'], title: json['title']);
  }
}
