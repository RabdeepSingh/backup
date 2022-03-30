import 'package:beaconstac_app/Data.dart';
import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Divider.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

bool toggle1 = true;
Widget setScans(List<QRData> ScansQRData, int scanCount,
    TextStyle styleForTitle, TextStyle styleForBody) {
  return Container(
    decoration: decorationContainer(),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          setHeadingWithCount("Scans", scanCount.toString(), styleForTitle),
          SizedBox(height: 20),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                  labelRotation: 90,
                  labelStyle: styleForBody),
              primaryYAxis: NumericAxis(labelStyle: styleForBody),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<QRData, String>>[
                LineSeries<QRData, String>(
                    dataSource: ScansQRData,
                    xValueMapper: (QRData data, _) => data.x,
                    yValueMapper: (QRData data, _) => data.y,
                    name: 'Scans  ',
                    color: Color.fromARGB(255, 37, 149, 255))
              ]),
          dividerCall(),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              iconSize: 60,
              tooltip: "Download XLS file for QR scanned per week",
              color: Colors.blue,
              icon: toggle1
                  ? Image.asset("images/xls1.png")
                  : Image.asset("images/xls2.png"),
              onPressed: () {
                // setState(() {
                //   toggle1 = !toggle1;
                // });
              },
            ),
          ),
        ],
      ),
    ),
  );
}
