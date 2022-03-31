import 'dart:io';

import 'package:beaconstac_app/Data.dart';
import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Divider.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:beaconstac_app/components/utility/Popup.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SetScans extends StatefulWidget {
  final List<QRData> scansQRData;
  final int scanCount;
  final String dropDownValueDate;
  SetScans({
    Key? key,
    required this.scansQRData,
    required this.scanCount,
    required this.dropDownValueDate,
  }) : super(key: key);

  @override
  State<SetScans> createState() => _SetScansState();
}

class _SetScansState extends State<SetScans> {
  bool toggle = true;
  bool errorToggle = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationContainer(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            setHeadingWithCount("Scans", widget.scanCount.toString(),
                Theme.of(context).textTheme.headline1!),
            SizedBox(height: 20),
            SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    axisLine: AxisLine(width: 0),
                    labelRotation: 90,
                    labelStyle: Theme.of(context).textTheme.bodyText1),
                primaryYAxis: NumericAxis(
                    labelStyle: Theme.of(context).textTheme.bodyText1),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<QRData, String>>[
                  LineSeries<QRData, String>(
                      dataSource: widget.scansQRData,
                      xValueMapper: (QRData data, _) => data.x,
                      yValueMapper: (QRData data, _) => data.y,
                      name: 'Scans  ',
                      color: Color.fromARGB(255, 37, 149, 255))
                ]),
            if (widget.scansQRData.length != 0)
              (Column(
                children: [
                  dividerCall(),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      iconSize: 60,
                      tooltip: "Download XLS file for QR scanned per week",
                      color: Colors.blue,
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
              ))
          ],
        ),
      ),
    );
  }

  Future<void> _generateCSVandView(context) async {
    List<List<String>> csvData = [
      <String>['Date', 'Scans'],
      ...widget.scansQRData.map((item) => [item.x, item.y.toString()])
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
