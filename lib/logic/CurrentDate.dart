List<String> setCurrentDate(String dropDownValue) {
  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now();
  DateTime temp = DateTime.now();
  String dropDownValueDate = "";
  //as per date data is manipulated by using switch case
  switch (dropDownValue) {
    case 'Today':
      date1 = temp.subtract(Duration(
          hours: temp.hour,
          minutes: temp.minute,
          seconds: temp.second,
          microseconds: temp.microsecond));
      date2 = temp;
      dropDownValueDate = '${date1.day}-${date1.month}-${date1.year}';
      break;

    case 'Yesterday':
      date1 = temp.subtract(Duration(
          days: 1,
          hours: temp.hour,
          minutes: temp.minute,
          seconds: temp.second,
          microseconds: temp.microsecond));
      date2 = temp.subtract(Duration(days: 1));
      date2 = date2.add(Duration(
          hours: 24 - date2.hour,
          minutes: 60 - date2.minute,
          seconds: 60 - date2.second));
      dropDownValueDate = '${date1.day}-${date1.month}-${date1.year}';
      break;

    case 'Last 7 days':
      date1 = temp.subtract(Duration(
          days: 7,
          hours: temp.hour,
          minutes: temp.minute,
          seconds: temp.second,
          microseconds: temp.microsecond));
      date2 = date2.subtract(Duration(days: 1));
      date2 = date2.add(Duration(
          hours: 24 - date2.hour - 1,
          minutes: 60 - date2.minute - 1,
          seconds: 60 - date2.second - 1));
      dropDownValueDate =
          '${date1.day}-${date1.month}-${date1.year} to ${date2.day}-${date2.month}-${date2.year}';
      break;

    case 'Last 30 days':
      date1 = temp.subtract(Duration(
          days: 30,
          hours: temp.hour,
          minutes: temp.minute,
          seconds: temp.second,
          microseconds: temp.microsecond));
      date2 = temp.subtract(Duration(days: 1));
      date2 = date2.add(Duration(
          hours: 24 - date2.hour - 1,
          minutes: 60 - date2.minute - 1,
          seconds: 60 - date2.second - 1));
      dropDownValueDate =
          '${date1.day}-${date1.month}-${date1.year} to ${date2.day}-${date2.month}-${date2.year}';
      break;

    case 'Last 90 days':
      date1 = temp.subtract(Duration(
          days: 90,
          hours: temp.hour,
          minutes: temp.minute,
          seconds: temp.second,
          microseconds: temp.microsecond));
      date2 = temp.subtract(Duration(days: 1));
      date2 = date2.add(Duration(
          hours: 24 - date2.hour - 1,
          minutes: 60 - date2.minute - 1,
          seconds: 60 - date2.second - 1));
      dropDownValueDate =
          '${date1.day}-${date1.month}-${date1.year} to ${date2.day}-${date2.month}-${date2.year}';
      break;

    case 'Lifetime':
      date1 = DateTime(2000);
      date2 = temp;
      dropDownValueDate =
          '${date1.day}-${date1.month}-${date1.year} to ${date2.day}-${date2.month}-${date2.year}';
      break;

    case 'Custom':
      date1 = DateTime(1970);
      date2 = temp;
      dropDownValueDate =
          '${date1.day}-${date1.month}-${date1.year} to ${date2.day}-${date2.month}-${date2.year}';
  }

  String timestamp1 = date1.millisecondsSinceEpoch.toString();
  String timestamp2 = date2.millisecondsSinceEpoch.toString();
  List<String> res = [timestamp1, timestamp2, dropDownValueDate];

  return res;
}
