import 'package:flutter/material.dart';
import 'package:recipe_app/Api/api_service.dart';
import 'package:recipe_app/models/meal.dart';
import 'package:recipe_app/models/meal_details.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.meal});
  final Meal meal;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<MealDetails> mealDetails;
  @override
  void initState() {
    super.initState();
    mealDetails = ApiService.getMealDetails(widget.meal.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Details'),
      ),
      body: FutureBuilder<MealDetails>(
        future: mealDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('Not found data'),
            );
          } else {
            MealDetails? meal = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Image.network(meal!.image),
                  ),
                  Text(meal.title),
                  Text('${meal.readyInMinute}'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: meal.ingrediants.length,
                    itemBuilder: (context, index) {
                      final ingredient = meal.ingrediants[index];
                      return Row(
                        children: [
                          Container(
                            height: 7,
                            width: 7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green.shade500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${ingredient.amount} ${ingredient.unit}${ingredient.name} ',
                            style: const TextStyle(fontSize: 19),
                          ),
                          const SizedBox(height: 50),
                        ],
                      );
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
