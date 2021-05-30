import 'package:flutter/material.dart';
import 'package:authentification/drawer_screen/main_drawer.dart';
import 'package:authentification/googlemap/maps.dart';


class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Maps(),
            //SelectCrop(),
            // Maps(),
          ],
        ),
      ),

    );
  }
}
