import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:authentification/select_crop/select_crop.dart';

class SelectCrop extends StatefulWidget {
  @override
  _SelectCropState createState() => _SelectCropState();
}

class _SelectCropState extends State<SelectCrop> {
  String _selected;
  List _myJson = ['1', 'BS', 'JHSW;'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, right: 10, left: 10),
      child: Scaffold(
        body: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 200,
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      hint: Text('Select Crop'),
                      value: _selected,
                      onChanged: (newValue) {
                        setState(
                          () {
                            _selected = newValue;
                          },
                        );
                      },
                      items: _myJson.map(
                        (crop) {
                          return DropdownMenuItem(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(),
                                )
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
