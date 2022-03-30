import 'package:beaconstac_app/Data.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../hiddenValues.dart';

String productImpressionDetail =
    "https://api.beaconstac.com/reporting/2.0/?organization=$orgId&method=Products.getImpressionDetail";

//Device OS Data
Future<List<QRData>> setDataForDeviceOS(int timestamp1, int timestamp2) async {
  var res;
  try {
    res = await http.post(
      Uri.parse(productImpressionDetail),
      headers: <String, String>{
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'product_type': 'qr',
        'from': timestamp1,
        'to': timestamp2,
      }),
    );
  } catch (err) {
    print('ERROR MSG FROM DEVICE OS :  $err');
  }

  Map<String, dynamic> userData = jsonDecode(res.body);
  Map<String, int> pieChartFetchData = SplayTreeMap();

  userData['points'].forEach((n) {
    String temp = n[8];
    int check = 1;
    if (temp.contains('Linux') && !temp.contains('Android')) check = 2;
    if (temp.contains('iPhone')) check = 3;
    if (temp.contains('Windows')) check = 4;
    if (temp.contains('Mac')) check = 5;

    switch (check) {
      case 1:
        pieChartFetchData['Android'] == null
            ? pieChartFetchData['Android'] = 1
            : pieChartFetchData['Android'] = pieChartFetchData['Android']! + 1;
        break;
      case 2:
        pieChartFetchData['Linux'] == null
            ? pieChartFetchData['Linux'] = 1
            : pieChartFetchData['Linux'] = pieChartFetchData['Linux']! + 1;
        break;
      case 3:
        pieChartFetchData['iPhone'] == null
            ? pieChartFetchData['iPhone'] = 1
            : pieChartFetchData['iPhone'] = pieChartFetchData['iPhone']! + 1;
        break;
      case 4:
        pieChartFetchData['Windows'] == null
            ? pieChartFetchData['Windows'] = 1
            : pieChartFetchData['Windows'] = pieChartFetchData['Windows']! + 1;
        break;
      case 5:
        pieChartFetchData['Mac'] == null
            ? pieChartFetchData['Mac'] = 1
            : pieChartFetchData['Mac'] = pieChartFetchData['Mac']! + 1;
    }
  });

  List<QRData> pieChartData = [];
  pieChartFetchData.forEach((k, v) => pieChartData.add(QRData(k, v)));
  return pieChartData;
}
