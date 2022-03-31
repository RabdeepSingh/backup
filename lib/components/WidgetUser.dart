import 'package:beaconstac_app/Data.dart';
import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SetUser extends StatefulWidget {
  final List<QRData> userCountData;
  final int TotalUserCount;
  SetUser({Key? key, required this.userCountData, required this.TotalUserCount})
      : super(key: key);

  @override
  State<SetUser> createState() => _SetUserState();
}

class _SetUserState extends State<SetUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationContainer(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            setHeadingWithCount("Users", widget.TotalUserCount.toString(),
                Theme.of(context).textTheme.headline1!),
            SizedBox(height: 20),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                  labelRotation: 90,
                  labelStyle: Theme.of(context).textTheme.bodyText1),
              primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: 1,
                  interval: 0.2,
                  labelStyle: Theme.of(context).textTheme.bodyText1),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<QRData, String>>[
                LineSeries<QRData, String>(
                  dataSource: widget.userCountData,
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
}
