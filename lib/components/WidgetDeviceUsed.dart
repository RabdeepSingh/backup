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

class SetDevicesUsed extends StatefulWidget {
  final List<QRData> pieChartData;
  final String dropDownValueDate;
  SetDevicesUsed({
    Key? key,
    required this.pieChartData,
    required this.dropDownValueDate,
  }) : super(key: key);

  @override
  State<SetDevicesUsed> createState() => SsetDevicesUsedState();
}

class SsetDevicesUsedState extends State<SetDevicesUsed> {
  bool toggle = true;
  bool errorToggle = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationContainer(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            setHeading("Devices used", Theme.of(context).textTheme.headline1!),
            SizedBox(height: 20),
            widget.pieChartData.length == 0
                ? Text("No data to show.",
                    style: Theme.of(context).textTheme.bodyText1!)
                : Column(
                    children: [
                      SfCircularChart(
                          palette: const <Color>[
                            Color.fromARGB(255, 224, 241, 187),
                            Color.fromARGB(255, 139, 184, 200),
                            Color.fromARGB(255, 252, 186, 153),
                            Color.fromARGB(255, 192, 184, 33),
                            Color.fromARGB(255, 25, 183, 170),
                            Color.fromARGB(255, 41, 104, 141),
                            Color.fromARGB(255, 25, 104, 183),
                            Color.fromARGB(255, 101, 25, 183)
                          ],
                          legend: Legend(
                              title: LegendTitle(
                                  text: 'DEVICE OS',
                                  textStyle:
                                      Theme.of(context).textTheme.headline3),
                              textStyle: Theme.of(context).textTheme.bodyText1,
                              isVisible: true,
                              isResponsive: true),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <CircularSeries>[
                            PieSeries<QRData, String>(
                                dataSource: widget.pieChartData,
                                radius: "100",
                                name: '',
                                xValueMapper: (QRData data, _) => data.x,
                                yValueMapper: (QRData data, _) => data.y),
                          ]),
                      dividerCall(),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          visualDensity: VisualDensity(),
                          iconSize: 60,
                          tooltip:
                              "Download XLS file for QR scanned by particular OS",
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
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateCSVandView(context) async {
    List<List<String>> csvData = [
      <String>['Operating system,Scans'],
      ...widget.pieChartData.map((item) => [item.x, item.y.toString()])
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
