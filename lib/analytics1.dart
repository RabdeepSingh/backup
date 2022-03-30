import 'package:beaconstac_app/Data.dart';
import 'package:beaconstac_app/components/WidgetCityScan.dart';
import 'package:beaconstac_app/components/WidgetDeviceUsed.dart';
import 'package:beaconstac_app/components/WidgetDrawer.dart';
import 'package:beaconstac_app/components/WidgetLocation.dart';
import 'package:beaconstac_app/components/WidgetScan.dart';
import 'package:beaconstac_app/components/WidgetSelectDate.dart';
import 'package:beaconstac_app/components/WidgetSelectLabel.dart';
import 'package:beaconstac_app/components/WidgetTopPerformance.dart';
import 'package:beaconstac_app/components/WidgetUser.dart';
import 'package:beaconstac_app/components/WidgetWeek.dart';
import 'package:beaconstac_app/logic/CityScanList.dart';
import 'package:beaconstac_app/logic/CurrentDate.dart';
import 'package:beaconstac_app/logic/DeviceOS.dart';
import 'package:beaconstac_app/logic/Scans.dart';
import 'package:beaconstac_app/logic/Users.dart';
import 'package:beaconstac_app/logic/topPerforming.dart';
import 'package:flutter/material.dart';
import 'logic/subLogics/Orientation.dart';

class Analytics1 extends StatefulWidget {
  Analytics1({Key? key}) : super(key: key);

  @override
  State<Analytics1> createState() => _Analytics1State();
}

class _Analytics1State extends State<Analytics1> {
  int timestamp1 = 0;
  int timestamp2 = 0;

  final List<String> items = [
    'Today',
    'Yesterday',
    'Last 7 days',
    'Last 30 days',
    'Last 90 days',
    'Lifetime',
    'Custom'
  ];
  String dropDownValue = 'Today';
  String dropDownValueDate = "";

  List<QRData> topPerf = [];

  List<DataRow> listOfCity = [];

  List<QRData> ScansQRData = [];
  int scanCount = 0;

  List<QRData> pieChartData = [];

  List<QRData> userCountData = [];
  int TotalUserCount = 0;

  void setInitialValues(int timestamp1, int timestamp2) {
    // Top Performing value
    setDataForTopPerforming(timestamp1, timestamp2)
        .then((val) => val.forEach((element) {
              topPerf.add(element);
            }))
        .whenComplete(() {
      setState(() {
        setTopPerformance(topPerf, Theme.of(context).textTheme.headline1!,
            Theme.of(context).textTheme.bodyText1!);
      });
      print('1 TOP PERFORMING : $topPerf');
    });

    // City Scan Value
    setScanPerCity(timestamp1, timestamp2).then((value) {
      value.forEach((element) {
        listOfCity.add(element);
      });
    }).whenComplete(() {
      setState(() {
        setScansByCity(listOfCity, Theme.of(context).textTheme.headline1!,
            Theme.of(context).textTheme.bodyText1!);
      });
      print('2 CITY SCAN :  $listOfCity');
    });

    // Scan Count Value
    setScanCount(timestamp1, timestamp2, dropDownValue)
        .then((value) => value.forEach((element) {
              ScansQRData.add(element);
            }))
        .whenComplete(() {
      setState(() {
        scanCount = totalScansQR;
        setScans(ScansQRData, scanCount, Theme.of(context).textTheme.headline1!,
            Theme.of(context).textTheme.bodyText1!);
      });
      print('3 SCAN $scanCount  - $ScansQRData');
    });

    setDataForDeviceOS(timestamp1, timestamp2)
        .then((value) => value.forEach((element) {
              pieChartData.add(element);
            }))
        .whenComplete(() {
      setState(() {
        setDevicesUsed(
            pieChartData,
            Theme.of(context).textTheme.headline1!,
            Theme.of(context).textTheme.headline3!,
            Theme.of(context).textTheme.bodyText1!);
      });
      print('4 DEVICE OS $pieChartData');
    });

    setDataForUser(timestamp1, timestamp2)
        .then((value) => value.forEach((element) {
              userCountData.add(element);
            }))
        .whenComplete(() {
      setState(() {
        TotalUserCount = totalUserCount;
        setUser(
            userCountData,
            TotalUserCount,
            Theme.of(context).textTheme.headline1!,
            Theme.of(context).textTheme.bodyText1!);
      });
    });
    print('5 USER : $totalUserCount - $userCountData');
  }

  @override
  void initState() {
    List<String> dateRelatedInfo = setCurrentDate(dropDownValue);
    timestamp1 = int.parse(dateRelatedInfo[0]);
    timestamp2 = int.parse(dateRelatedInfo[1]);
    dropDownValueDate = dateRelatedInfo[2];
    // print('$timestamp1 $timestamp2 $dropDownValue $dropDownValueDate');

    setInitialValues(timestamp1, timestamp2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    allOrientation();
    return Scaffold(
      drawer: setDrawer(),
      appBar: AppBar(
        title: Text("Analytics"),
        centerTitle: false,
      ),
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                setSelectedDate(dropDownValue, dropDownValueDate, items),
                SizedBox(height: 30),
                setSelectLabel(),
                SizedBox(height: 30),
                setTopPerformance(
                    topPerf,
                    Theme.of(context).textTheme.headline1!,
                    Theme.of(context).textTheme.bodyText1!),
                SizedBox(height: 30),
                setScansByCity(
                    listOfCity,
                    Theme.of(context).textTheme.headline1!,
                    Theme.of(context).textTheme.bodyText1!),
                SizedBox(height: 30),
                setScans(
                    ScansQRData,
                    scanCount,
                    Theme.of(context).textTheme.headline1!,
                    Theme.of(context).textTheme.bodyText1!),
                SizedBox(height: 30),
                setDevicesUsed(
                    pieChartData,
                    Theme.of(context).textTheme.headline1!,
                    Theme.of(context).textTheme.headline3!,
                    Theme.of(context).textTheme.bodyText1!),
                SizedBox(height: 30),
                setUser(
                    userCountData,
                    TotalUserCount,
                    Theme.of(context).textTheme.headline1!,
                    Theme.of(context).textTheme.bodyText1!),
                SizedBox(height: 30),
                setScansByTimeOfDay(Theme.of(context).textTheme.headline1!),
                SizedBox(height: 30),
                setScansByLocation(Theme.of(context).textTheme.headline1!,
                    Theme.of(context).textTheme.bodyText1!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
