import 'package:authentification/drawer_screen/main_drawer.dart';
import 'package:authentification/googlemap/maps.dart';
import 'package:authentification/search/searchbar.dart';
import 'package:authentification/select_crop/select_crop.dart';
import 'package:flutter/material.dart';
import 'package:authentification/bottom_bar/report.dart';
import 'package:authentification/googlemap/maps.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SearchBar(),
            SelectCrop(),
           // Maps(),
          ],
        ),
      ),
    );
  }
}
