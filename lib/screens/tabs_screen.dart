import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabScreen(this.favoriteMeals);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;
  @override
  initState() {
    //as in initstate widget is available elsewhere not
    _pages = [
      //a list containing widgets that would be displayed when onTap is pressed
      {
        'page': CategoriesScreen(),
        'title': "Categories",
      },
      {
        'page': FavoriteScreen(
            widget.favoriteMeals), //map is basically a kind of dictionary
        'title':
            "Favorites", //we can add whatever we want here even collection of widgets
      } //it's done so when clicked appbar name can be changed
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      //drawer: Drawer(
      //child: Text('Drawer'),//also adds the swipe gesture
      //), //with a nice backdrop i.e slides open with app view behind and allows to add content to drawer
      body: _pages[_selectedPageIndex]['page'], //access page key
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        //backgroundColor: can be added
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        //likewise selected font size and unselected font size can also be managed
        currentIndex: _selectedPageIndex,
        //it tells that which item is selected
        type: BottomNavigationBarType
            .shifting, //will add a transition and remove bgcolor as well
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}

/*Widget build(BuildContext context) {
    return DefaultTabController( //for upper tabBar we can simply deal with stateless widget but for bottom we'll need the staeful widget because the flutter is designed that way
      length: 2,
      //initialIndex:0 or 1, that is if 1 given then it'll first load second tab by default
      child: Scaffold(
          appBar: AppBar(
              title: Text('Meals'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.category,
                    ),
                    text: 'Categories',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.star,
                    ),
                    text: 'Favorites',
                  ),
                ],
              )),
          body: TabBarView(
            children: <Widget>[
              CategoriesScreen(),
              FavoriteScreen(),
            ],
          )),
    );
  }
}*/
