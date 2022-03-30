import 'package:beaconstac_app/logic/subLogics/PrecisionDouble.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../hiddenValues.dart';

String productImpressionDistribution =
    "https://api.beaconstac.com/reporting/2.0/?organization=$orgId&method=Products.getImpressionDistribution";

int totalScan = 0;
Future<List<DataRow>> setScanPerCity(int timestamp1, int timestamp2) async {
  var res;
  try {
    res = await http.post(
      Uri.parse(productImpressionDistribution),
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
    print('ERROR MSG FROM CITY :  $err');
  }
  Map<String, dynamic> userData = jsonDecode(res.body);
  Map<String, int> listCityFetchData = SplayTreeMap();

  totalScan = 0;
  userData['points'].forEach((n) {
    String nameOfCity = n[1];
    print("here $nameOfCity");
    listCityFetchData[nameOfCity] = 0;
    for (int i = 3; i < n[2].length; i += 18) {
      listCityFetchData[nameOfCity] =
          listCityFetchData[nameOfCity]! + n[2][i] as int;
      totalScan = totalScan + n[2][i] as int;
    }
  });

  List<DataRow> listOfCity = [];

  print('City Data $listCityFetchData $listCityFetchData');
  listCityFetchData.forEach((k, v) {
    listOfCity.add(DataRow(cells: <DataCell>[
      DataCell(Text('$k',
          style: TextStyle(
              fontFamily: 'Roboto',
              color: Color.fromARGB(255, 89, 91, 98),
              fontWeight: FontWeight.w400))),
      DataCell(Text('$v',
          style: TextStyle(
              fontFamily: 'Roboto',
              color: Color.fromARGB(255, 37, 149, 255),
              fontWeight: FontWeight.w400))),
      DataCell(Text('${toPrecision((v / totalScan) * 100)} %',
          style: TextStyle(
              fontFamily: 'Roboto',
              color: Color.fromARGB(255, 89, 91, 98),
              fontWeight: FontWeight.w400)))
    ]));
  });

  return listOfCity;
}
