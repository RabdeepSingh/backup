import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Divider.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:flutter/material.dart';

bool toggle = true;
Widget setScansByCity(List<DataRow> listOfCity, TextStyle styleForHeading,
    TextStyle styleForLabel) {
  return Container(
    decoration: decorationContainer(),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          setHeading("Scans By City", styleForHeading),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              dividerThickness: 0,
              columns: [
                DataColumn(label: Text('')),
                DataColumn(label: Text('')),
                DataColumn(label: Text('')),
              ],
              rows: listOfCity,
            ),
          ),
          dividerCall(),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              tooltip: "Download XLS file for QR scanned by city",
              color: Colors.blue,
              iconSize: 60,
              icon: toggle
                  ? Image.asset("images/xls1.png")
                  : Image.asset("images/xls2.png"),
              onPressed: () {
                // setState(() {
                //   toggle = !toggle;
                // });
              },
            ),
          )
        ],
      ),
    ),
  );
}
