import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Divider.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:beaconstac_app/components/utility/Popup.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SetScanByCity extends StatefulWidget {
  final List<List<String>> listOfCity;
  final String dropDownValueDate;

  SetScanByCity(
      {Key? key, required this.listOfCity, required this.dropDownValueDate})
      : super(key: key);

  @override
  State<SetScanByCity> createState() => _SetScanByCityState();
}

class _SetScanByCityState extends State<SetScanByCity> {
  bool toggle = true;
  bool errorToggle = false;
  List<DataRow> _createDataRows() {
    List<DataRow> temp = [];
    widget.listOfCity.forEach((val) {
      temp.add(DataRow(cells: <DataCell>[
        DataCell(Text(val[0],
            style: TextStyle(
                fontFamily: 'Roboto',
                color: Color.fromARGB(255, 89, 91, 98),
                fontWeight: FontWeight.w400))),
        DataCell(Text(val[1],
            style: TextStyle(
                fontFamily: 'Roboto',
                color: Color.fromARGB(255, 37, 149, 255),
                fontWeight: FontWeight.w400))),
        DataCell(Text(val[2] + ' %',
            style: TextStyle(
                fontFamily: 'Roboto',
                color: Color.fromARGB(255, 89, 91, 98),
                fontWeight: FontWeight.w400)))
      ]));
    });
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationContainer(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            setHeading("Scans By City", Theme.of(context).textTheme.headline1!),
            SizedBox(height: 20),
            widget.listOfCity.length == 0
                ? (Text("No Data to show.",
                    style: Theme.of(context).textTheme.bodyText1))
                : Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          dividerThickness: 0,
                          columns: [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                          ],
                          dataTextStyle: Theme.of(context).textTheme.bodyText1,
                          headingTextStyle:
                              Theme.of(context).textTheme.bodyText2,
                          rows: _createDataRows(),
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
                            setState(() {
                              toggle = !toggle;
                              _generateCSVandView(context).whenComplete(() {
                                if (!errorToggle) {
                                  popUp("Downloading", Colors.green);
                                }
                              });
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateCSVandView(context) async {
    List<List<String>> csvData = [
      <String>['City State', 'Country', 'Scans'],
      ...widget.listOfCity.map((item) => [item[0], item[1], item[2]])
    ];
    try {
      String csv = const ListToCsvConverter().convert(csvData);

      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/QRData_${widget.dropDownValueDate}.csv';
      final File file = File(path);
      // Save csv String
      await file.writeAsString(csv);
    } catch (e) {
      errorToggle = true;
      popUp("Oops! Something went wrong", Colors.red);
    }
  }
}
