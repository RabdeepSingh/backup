import 'package:beaconstac_app/Data.dart';
import 'dart:convert';
import 'package:beaconstac_app/Data.dart';
import 'package:http/http.dart' as http;
import '../hiddenValues.dart';

String impressionDetail =
    "https://api.beaconstac.com/reporting/2.0/?organization=$orgId&method=Products.getImpressionDetail";
int totalUserCount = 0;

Future<List<QRData>> setDataForUser(
    int timestamp1, int timestamp2, String dropDownValue) async {
  var res;
  try {
    res = await http.post(
      Uri.parse(impressionDetail),
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
    print('ERROR MSG FROM USER COUNT  :  $err');
  }

  Map<String, dynamic> userData = jsonDecode(res.body);
  // Map<String, int> userFetchData = Map();

  Map<String, Set<String>> userFetchData = Map();
  Set<String> uniqueUser = Set();

  for (int i = userData['points'].length - 1; i >= 0; i--) {
    var n = userData['points'][i];
    if (dropDownValue == 'Today' || dropDownValue == 'Yesterday') {
      String scanTime = n[6].split('T')[1];
      scanTime = scanTime.split('.')[0];
      String ipAddress = n[7];

      uniqueUser.add(ipAddress);

      if (userFetchData[scanTime] == null) {
        userFetchData[scanTime] = Set();
        userFetchData[scanTime]!.add(ipAddress);
      } else {
        userFetchData[scanTime]!.add(ipAddress);
      }
    } else {
      String scanTime = n[6].split('T')[0];
      String ipAddress = n[7];
      if (userFetchData[scanTime] == null) {
        userFetchData[scanTime] = Set();
        userFetchData[scanTime]!.add(ipAddress);
      } else {
        userFetchData[scanTime]!.add(ipAddress);
      }
    }
  }

  // print(userFetchData);
  totalUserCount = uniqueUser.length;
  List<QRData> userCountData = [];

  userFetchData.forEach((key, value) {
    userCountData.add(QRData(key, value.length));
    totalUserCount++;
  });
  return userCountData;
}
