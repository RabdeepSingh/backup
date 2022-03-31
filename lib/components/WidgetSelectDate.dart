import 'package:beaconstac_app/Data.dart';
import 'package:beaconstac_app/components/WidgetLocation.dart';
import 'package:beaconstac_app/components/WidgetTopPerformance.dart';
import 'package:beaconstac_app/components/WidgetWeek.dart';
import 'package:beaconstac_app/logic/CurrentDate.dart';
import 'package:beaconstac_app/logic/topPerforming.dart';
import 'package:flutter/material.dart';

class setSelectedDate extends StatefulWidget {
  String dropDownValue;
  final Function callbackFunction;
  String dropDownValueDate;

  setSelectedDate(
      {Key? key,
      required this.dropDownValue,
      required this.dropDownValueDate,
      required this.callbackFunction})
      : super(key: key);

  @override
  State<setSelectedDate> createState() => _setSelectedDateState();
}

class _setSelectedDateState extends State<setSelectedDate> {
  final List<String> items = [
    'Today',
    'Yesterday',
    'Last 7 days',
    'Last 30 days',
    'Last 90 days',
    'Lifetime',
    'Custom'
  ];

  String itemDate = "";
  String valDate = "";
  @override
  void initState() {
    itemDate = widget.dropDownValue;
    valDate = widget.dropDownValueDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 0.2,
                      style: BorderStyle.solid,
                      color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      // value: widget.dropDownValue,
                      value: itemDate,
                      style:
                          TextStyle(color: Color.fromARGB(255, 83, 108, 121)),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          widget.dropDownValue = newValue!;
                          List<String> temp = setCurrentDate(newValue);
                          itemDate = newValue;
                          valDate = temp[2];
                          widget.callbackFunction(
                              int.parse(temp[0]), int.parse(temp[1]));
                        });
                      }),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
                decoration: ShapeDecoration(
                  color: Color.fromARGB(255, 25, 133, 172),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 0.2,
                        style: BorderStyle.solid,
                        color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                height: 40,
                width: 30,
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Text(
                    valDate,
                    // widget.dropDownValueDate,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
