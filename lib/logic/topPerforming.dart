import 'dart:convert';
import 'package:beaconstac_app/Data.dart';
import 'package:http/http.dart' as http;
import '../hiddenValues.dart';

String productOverview =
    "https://api.beaconstac.com/reporting/2.0/?organization=$orgId&method=Products.getOverview";

Future<List<QRData>> setDataForTopPerforming(
    int timestamp1, int timestamp2) async {
  var res;
  try {
    res = await http.post(
      Uri.parse(productOverview),
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
    print('ERROR MSG FROM TOP PERFORMING :  $err');
  }

  Map<String, dynamic> userData = jsonDecode(res.body);
  List<QRDetail> barGraphFetchData = [];

  userData['points'].forEach(
      (n) => barGraphFetchData.add(new QRDetail(n[0], n[1], n[2], n[3])));
  barGraphFetchData
      .sort((a, b) => b.impression_count.compareTo(a.impression_count));

  List<QRData> barGraphData = [];

  if (barGraphFetchData.length < 5) {
    for (int i = barGraphFetchData.length - 1; i >= 0; i--) {
      barGraphData.add(QRData(barGraphFetchData[i].product_name,
          barGraphFetchData[i].impression_count));
    }
  } else {
    for (int i = 4; i >= 0; i--) {
      barGraphData.add(QRData(barGraphFetchData[i].product_name,
          barGraphFetchData[i].impression_count));
    }
  }
  return barGraphData;
}
