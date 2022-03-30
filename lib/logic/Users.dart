import 'package:beaconstac_app/Data.dart';

int totalUserCount = 0;

Future<List<QRData>> setDataForUser(int timestamp1, int timestamp2) async {
  List<QRData> userCountData = [];
  print('USER DATA: None For Now');
  userCountData = [
    QRData('10 Mar 22', 0),
    QRData('11 Mar 22', 0),
    QRData('12 Mar 22', 0),
    QRData('13 Mar 22', 0),
    QRData('14 Mar 22', 0),
    QRData('15 Mar 22', 1)
  ];
  return userCountData;
}
