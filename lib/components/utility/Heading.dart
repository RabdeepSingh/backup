import 'package:flutter/material.dart';

Widget setHeading(String title, TextStyle styleForHeading) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(title, style: styleForHeading),
  );
}

Widget setHeadingWithCount(
    String title, String count, TextStyle styleForTitle) {
  return Align(
    alignment: Alignment.topLeft,
    child: RichText(
      text: TextSpan(text: "", style: styleForTitle, children: <TextSpan>[
        TextSpan(
          text: "$title\n",
        ),
        TextSpan(
          text: count,
          style: TextStyle(
              color: Color.fromARGB(255, 37, 149, 255),
              fontWeight: FontWeight.w600),
        ),
      ]),
    ),
  );
}
