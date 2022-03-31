import 'package:beaconstac_app/Data.dart';
import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SetTopPerformance extends StatefulWidget {
  final List<QRData> barGraphData;
  SetTopPerformance({Key? key, required this.barGraphData}) : super(key: key);

  @override
  State<SetTopPerformance> createState() => _SetTopPerformanceState();
}

class _SetTopPerformanceState extends State<SetTopPerformance> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationContainer(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            setHeading(
                "Top Performing", Theme.of(context).textTheme.headline1!),
            SizedBox(height: 20),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                  arrangeByIndex: true,
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                  labelStyle: Theme.of(context).textTheme.bodyText1),
              primaryYAxis: NumericAxis(
                labelStyle: Theme.of(context).textTheme.bodyText1,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<QRData, String>>[
                BarSeries<QRData, String>(
                    dataSource: widget.barGraphData,
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
}
