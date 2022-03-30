import 'package:beaconstac_app/components/WidgetLocation.dart';
import 'package:beaconstac_app/components/WidgetWeek.dart';
import 'package:beaconstac_app/logic/CurrentDate.dart';
import 'package:flutter/material.dart';

Widget setSelectedDate(
    String dropDownValue, String dropDownValueDate, List<String> items) {
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
                    width: 0.2, style: BorderStyle.solid, color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: dropDownValue,
                    style: TextStyle(color: Color.fromARGB(255, 83, 108, 121)),
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
                      dropDownValue = newValue!;
                      print('HERE $dropDownValue');
                      List<String> temp = setCurrentDate(dropDownValue);
                      setSelectedDate(dropDownValue, temp[2], items);

                      // Analytics1.setInitialValues(temp[0],temp[1]);

                      // setTopPerformance(topPerf, TextStyle(), TextStyle());

                      // setScansByCity(listOfCity, TextStyle(), TextStyle());

                      // setScans(ScansQRData, scanCount, TextStyle(), TextStyle());

                      // setDevicesUsed(pieChartData, TextStyle(), TextStyle(), TextStyle());

                      // setUser(userCountData, TotalUserCount, TextStyle(),TextStyle());

                      setScansByTimeOfDay(TextStyle());

                      setScansByLocation(TextStyle(), TextStyle());
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
                  "$dropDownValueDate",
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
