import 'package:flutter/material.dart';

final List<String> _labels = [
  'test1',
  'test2',
  'test3',
  'test4',
  'test5',
];
bool toggle3 = true;
Widget setSelectLabel() {
  return Container(
    height: 100,
    child: Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              // controller: TextEditingController(text: user.password),
              // onChanged: (value) {
              //   user.password = value;
              // },
              // validator: (value) {
              //   if (value != null && value.isEmpty) {
              //     return 'Password Required';
              //   }
              //   return null;
              // },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Color.fromARGB(255, 159, 159, 159)),
                hintText: 'Select labels',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 204, 204, 204))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blueAccent)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.redAccent)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.redAccent)),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0))),
                  backgroundColor: toggle3
                      ? MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 37, 149, 255))
                      : MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 13, 131, 241)),
                  side: toggle3
                      ? MaterialStateProperty.all(
                          BorderSide(
                            width: 10.0,
                            color: Color.fromARGB(100, 37, 149, 255),
                            // style: BorderStyle.solid,
                          ),
                        )
                      : MaterialStateProperty.all(
                          BorderSide(
                            width: 0.0,
                          ),
                        ),
                ),
                onPressed: () {
                  // setState(() {
                  //   toggle3 = !toggle3;
                  // });
                },
                child: Text("EXPORT",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w500))),
          ),
        ],
      ),
    ),
  );
}
