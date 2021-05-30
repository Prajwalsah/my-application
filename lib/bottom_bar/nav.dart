//import 'dart:html';
import 'package:authentification/bottom_bar/history.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:authentification/HomePage.dart';
import 'report.dart';
import 'package:authentification/search/searchbar.dart';
import 'package:authentification/Start.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}
class _NavState extends State<Nav> {

  int _currentIndex = 0;
  final List<Widget> children = [HomePage(), Report(), History()];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.green,
        height: 40,
        backgroundColor: Colors.teal,
        //buttonBackgroundColor: Colors.brown,
        onTap: onTappedBar,
        index: _currentIndex,
        items: <Widget>[
          Icon(Icons.home, size:25, color: Colors.black),
          Icon(Icons.calculate_outlined, size:25, color: Colors.black),
          Icon(Icons.history, size:25, color: Colors.black),
        ],
      ),
    );
  }
}