//What happens when we click on meal
import 'dart:async';
import 'package:flutter/foundation.dart'; //used to use @required on all elements of constructor

enum Complexity {
  Simple,
  Challenging,
  Hard,
  //behind the scene dart will map the values 0,1,2 viz normal int, and we could also use labels
}
//to describe how affordable meal is

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl; //as can be get from net, will not have to hard code
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity; //= Complexity.Simple; like this we can use
  //final int complexity;//0 is simple, 1 is medium and 2 is tough we as a developer shall remeber so we'll use enum
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  //for constructor best to use named arguments to not forget the order
  const Meal({
    @required this.id,
    @required this.categories,
    @required this.title,
    @required this.imageUrl,
    @required this.ingredients,
    @required this.steps,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
  });
}
