import 'dart:ui';
import './screens/meal_detail_screen.dart';
import './dummy_data.dart';
import './screens/category_meals_screen.dart';
import 'package:flutter/material.dart';
import './screens/categories_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'Lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false; //as we don't wanna generate that item
        }
        if (_filters['Lactose'] == true && !meal.isLactoseFree) {
          return false; //as we don't wanna generate that item
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false; //as we don't wanna generate that item
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false; //as we don't wanna generate that item
        }
        return true; //when all filter satisfied to keep meal
      }).toList(); //as this filterdata is got by us, and overwrite the above exactly same structured filter data
    });
  }

  void _toggleFavorite(String mealId) {
    //toggle method either add or remove logic is there, so if already in list then remove else add
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      }); //entire app rebuilds so not optimal
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        //fontFamily: 'Raleway', //issue because of it, after commenting issue resolved
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline1: TextStyle(
              fontSize: 20,
              //fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
        //named route way where path is on the file having the class or page being loaded
      },
      onUnknownRoute: (settings) {
        //to prevent app from crash when unknown route is mapped
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      }, //always marks the entry point of the application
    );
  }
}
//onGenerateRoute:(settings){  ---> Highly usful in the case of dynamic routes and all
//print(setting.arguments);
//if(settings.name=='/meal_detail'){
//return a screen of our choice}
//else if() return screen
//else return screen or do something
//return MaterialPageRoute(builder:(ctx)=>CategoriesScreen())}
