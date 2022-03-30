import 'package:beaconstac_app/Data.dart';
import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget setTopPerformance(List<QRData> barGraphData, TextStyle styleForTitle,
    TextStyle styleForBody) {
  return Container(
    decoration: decorationContainer(),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          setHeading("Top Performing", styleForTitle),
          SizedBox(height: 20),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(
                arrangeByIndex: true,
                majorGridLines: MajorGridLines(width: 0),
                axisLine: AxisLine(width: 0),
                labelStyle: styleForBody),
            primaryYAxis: NumericAxis(
              labelStyle: styleForBody,
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<QRData, String>>[
              BarSeries<QRData, String>(
                  dataSource: barGraphData,
                  width: 0.2,
                  xValueMapper: (QRData data, _) => data.x,
                  yValueMapper: (QRData data, _) => data.y,
                  name: '',
                  color: Color.fromARGB(255, 214, 232, 194))
            ],
          ),
        ],
      ),
    ),
  );
}
