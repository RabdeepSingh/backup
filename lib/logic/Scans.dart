import 'dart:collection';
import 'package:beaconstac_app/Data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../hiddenValues.dart';

String productImpressionDetail =
    "https://api.beaconstac.com/reporting/2.0/?organization=$orgId&method=Products.getImpressionDetail";

int totalScansQR = 0;

Future<List<QRData>> setScanCount(
    int timestamp1, int timestamp2, String dropDownValue) async {
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
    print('ERROR MSG FROM SCAN COUNT $err');
  }

  Map<String, dynamic> userData = jsonDecode(res.body);
  Map<String, int> ScansQRFetchData = SplayTreeMap();
  if (userData['points'] != null) {
    totalScansQR = userData['points'].length ?? 0;

    userData['points'].forEach((n) {
      String timestampForScan = n[6];
      ScansQRFetchData[timestampForScan] = 0;
      if (ScansQRFetchData[timestampForScan] == null) {
        ScansQRFetchData[timestampForScan] = 1;
      } else {
        ScansQRFetchData[timestampForScan] =
            ScansQRFetchData[timestampForScan]! + 1;
      }
    });
  }

  List<QRData> scansQRData = [];
  Map<String, int> curMap = Map();

  if (dropDownValue == 'Today' || dropDownValue == 'Yesterday') {
    ScansQRFetchData.forEach((k, v) {
      List<String> l = k.split('T');
      String cur = l[1].split('.')[0];
      if (curMap[cur] == null)
        curMap[cur] = 1;
      else
        curMap[cur] = curMap[cur]! + 1;
    });
  } else {
    ScansQRFetchData.forEach((k, v) {
      String cur = k.split('T')[0];
      if (curMap[cur] == null)
        curMap[cur] = 1;
      else
        curMap[cur] = curMap[cur]! + 1;
    });
  }

  curMap.forEach((key, value) {
    scansQRData.add(QRData(key, value));
  });
  return scansQRData;
}
