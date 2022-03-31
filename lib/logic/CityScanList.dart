import 'package:beaconstac_app/logic/subLogics/PrecisionDouble.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../hiddenValues.dart';

String productImpressionDistribution =
    "https://api.beaconstac.com/reporting/2.0/?organization=$orgId&method=Products.getImpressionDistribution";

int totalScan = 0;
Future<List<List<String>>> setScanPerCity(
    int timestamp1, int timestamp2) async {
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
    listCityFetchData[nameOfCity] = 0;
    for (int i = 3; i < n[2].length; i += 18) {
      listCityFetchData[nameOfCity] =
          listCityFetchData[nameOfCity]! + n[2][i] as int;
      totalScan = totalScan + n[2][i] as int;
    }
  });

  List<List<String>> listOfCity = [];

  listCityFetchData.forEach((k, v) {
    List<String> temp = [
      k,
      v.toString(),
      (int.parse(toPrecision(v / totalScan)) * 100).toString()
    ];
    listOfCity.add(temp);
  });

  return listOfCity;
}
