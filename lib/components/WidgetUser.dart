import 'package:beaconstac_app/Data.dart';
import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget setUser(List<QRData> userCountData, int TotalUserCount,
    TextStyle styleForTitle, TextStyle styleForBody) {
  return Container(
    decoration: decorationContainer(),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          setHeadingWithCount(
              "Users", TotalUserCount.toString(), styleForTitle),
          SizedBox(height: 20),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                axisLine: AxisLine(width: 0),
                labelRotation: 90,
                labelStyle: styleForBody),
            primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 1,
                interval: 0.2,
                labelStyle: styleForBody),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<QRData, String>>[
              LineSeries<QRData, String>(
                dataSource: userCountData,
                xValueMapper: (QRData data, _) => data.x,
                yValueMapper: (QRData data, _) => data.y,
                name: 'Viewers',
                color: Color.fromARGB(255, 37, 149, 255),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
