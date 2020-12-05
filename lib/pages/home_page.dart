import 'package:flutter/material.dart';
import 'package:flutterapp/pages/albums_page.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/pages/posts_page.dart';
import 'package:flutterapp/pages/todos_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, @required this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Posts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album),
            title: Text('Albums'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            title: Text('Todos'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: bottomTapped,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        children: [
          PostsPage(
            user: widget.user,
          ),
          AlbumsPage(
            user: widget.user,
          ),
          TodosPage(
            user: widget.user,
          ),
        ],
      ),
    );
  }
}
