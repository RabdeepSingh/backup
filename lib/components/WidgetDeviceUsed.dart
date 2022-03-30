import 'package:beaconstac_app/Data.dart';
import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Divider.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

bool toggle2 = true;
Widget setDevicesUsed(List<QRData> pieChartData, TextStyle styleForHeading,
    TextStyle styleForLabel, TextStyle styleForBody) {
  return Container(
    decoration: decorationContainer(),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          setHeading("Devices used", styleForHeading),
          SizedBox(height: 20),
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
                  title:
                      LegendTitle(text: 'DEVICE OS', textStyle: styleForLabel),
                  // textStyle: Theme.of(context).textTheme.headline3),
                  textStyle: styleForBody,
                  isVisible: true,
                  isResponsive: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CircularSeries>[
                PieSeries<QRData, String>(
                    dataSource: pieChartData,
                    radius: "100",
                    name: '',
                    xValueMapper: (QRData data, _) => data.x,
                    yValueMapper: (QRData data, _) => data.y),
              ]),
          dividerCall(),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              iconSize: 60,
              tooltip: "Download XLS file for QR scanned by particular OS",
              color: Colors.blue,
              icon: toggle2
                  ? Image.asset("images/xls1.png")
                  : Image.asset("images/xls2.png"),
              onPressed: () {
                // setState(() {
                //   toggle2 = !toggle2;
                // });
              },
            ),
          ),
        ],
      ),
    ),
  );
}
