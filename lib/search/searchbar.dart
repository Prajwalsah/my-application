import 'package:flutter/material.dart';
import 'package:authentification/bottom_bar/report.dart';
import 'package:authentification/select_crop/select_crop.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}
class _SearchBarState extends State<SearchBar> {
  bool _folded = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 400),
      width: _folded ? 300:300,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((32)),
        color: Colors.white,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children:<Widget> [
          Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16),
                child: _folded
                ? TextField(
                  decoration: InputDecoration(
                    hintText: 'Select Location',
                    hintStyle: TextStyle(color: Colors.blue[300]),
                    border: InputBorder.none),
                )
                :null,
              )
          ),
          AnimatedContainer(
              duration: Duration(milliseconds: 400),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular((_folded ? 32 : 0 ),),
                  bottomRight: Radius.circular((32)),
                  bottomLeft:Radius.circular((_folded ? 32 : 0 ),),
                ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  _folded ?
                  Icons.close_sharp: Icons.search_off_rounded,
                  color: Colors.blue[900],
                ),
              ),
                onTap: (){
                  setState(() {
                    _folded =! _folded;
                  });
                },
              ),
            )
          )
        ],
      ),
    );
  }
}
