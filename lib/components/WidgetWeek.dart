import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:flutter/material.dart';

Widget setScansByTimeOfDay(TextStyle styleForTitle) {
  return Container(
    decoration: decorationContainer(),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          setHeading("Scans by time of day", styleForTitle),
          SizedBox(height: 20),
          //  SafeArea(
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: HeatMapCalendar(
          //       input: {
          //         TimeUtils.removeTime(
          //             DateTime.now().subtract(Duration(days: 3))): 5,
          //         TimeUtils.removeTime(
          //             DateTime.now().subtract(Duration(days: 2))): 35,
          //         TimeUtils.removeTime(
          //             DateTime.now().subtract(Duration(days: 1))): 14,
          //         TimeUtils.removeTime(DateTime.now()): 5,
          //       },
          //       colorThresholds: {
          //         0: Colors.grey,
          //         1: Colors.blue[100] ?? Colors.blue,
          //         10: Colors.blue[300] ?? Colors.blue,
          //         30: Colors.blue[500] ?? Colors.blue,
          //       },
          //       weekDaysLabels: [
          //         'Sun',
          //         'Mon',
          //         'Tue',
          //         'Wed',
          //         'Thu',
          //         'Fri',
          //         'Sat'
          //       ],
          //       monthsLabels: [
          //         "10pm",
          //         "8pm",
          //         "6pm",
          //         "4pm",
          //         "2pm",
          //         "12pm",
          //         "10am",
          //         "8am",
          //         "6am",
          //         "4am",
          //         "2am",
          //         "12am",
          //       ],
          //       squareSize: 16.0,
          //       textOpacity: 0.3,
          //       labelTextColor: Colors.grey,
          //       dayTextColor: Colors.grey,
          //     ),
          //   ),
          // )
        ],
      ),
    ),
  );
}
