import 'package:beaconstac_app/components/utility/BoxDecorate.dart';
import 'package:beaconstac_app/components/utility/Heading.dart';
import 'package:flutter/material.dart';

Widget setScansByLocation(TextStyle styleForHeading, TextStyle styleForBody) {
  return Container(
    decoration: decorationContainer(),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          setHeading("Scans by location", styleForHeading),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset('images/m2.png', width: 30, height: 30),
                    Text("IP Cluster", style: styleForBody),
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  Image.asset('images/m1.png', width: 30, height: 30),
                  Text("GPS Cluster", style: styleForBody),
                ],
              ))
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset('images/ip.png', width: 30, height: 30),
                    Text("IP", style: styleForBody),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset('images/gps.png', width: 30, height: 30),
                    Text("GPS", style: styleForBody),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text("LOCATION ADD ON"),
          // Container(
          //   child: Stack(
          //     children: [
          //       GoogleMap(
          //         mapType: MapType.hybrid,
          //         initialCameraPosition: _kGooglePlex,
          //         onMapCreated: (GoogleMapController controller) {
          //           _controller.complete(controller);
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   alignment: Alignment.bottomRight,
          //   height: 500,
          //   child: IconButton(
          //     color: Colors.white,
          //     icon: const Icon(Icons.directions_boat),
          //     onPressed: _goToTheLake,
          //   ),
          // ),
        ],
      ),
    ),
  );
} //build