import 'package:flutter/material.dart';
import 'package:recipe_app/Api/api_service.dart';
import 'package:recipe_app/meal_details.dart';
import 'package:recipe_app/models/meal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Meal>> meals;

  @override
  void initState() {
    super.initState();
    meals = ApiService.getAllMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
        ),
        body: FutureBuilder<List<Meal>>(
          future: meals,
          builder: (context, Snapshot) {
            if (Snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (Snapshot.hasError) {
              return Center(
                child: Text('${Snapshot.error}'),
              );
            } else if (!Snapshot.hasData || Snapshot.data!.isEmpty) {
              return Center(
                child: Text('Not found data'),
              );
            } else {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: Snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Meal meal = Snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (Context) => DetailsScreen(meal: meal)));
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.network(
                              meal.image,
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              meal.title,
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
