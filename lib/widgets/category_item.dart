import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title; //the outputs that we wanna display
  final Color color;
  CategoryItem(
    this.id,
    this.title,
    this.color,
  );
  //void selectcategory(BuildContext ctx) {
  //Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
  //return CategoryMealsScreen(id, title); //automatically gets back button
  //}));
  //}
  void selectcategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectcategory(context), //action on tap
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(
          15), //border radius is same as widget one, to be on same design and border
      child: Container(
          padding: const EdgeInsets.all(15),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          //decoration is used to make grid items look attractive
          //Gradient: first val lighter color, that's our color with less opacity and second arg is darker color, i.e. our color value passed as argument
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.7),
                color,
              ],
              begin:
                  Alignment.topLeft, //from where to begin the linerar gradient
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
