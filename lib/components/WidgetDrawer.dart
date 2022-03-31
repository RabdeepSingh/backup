import 'package:flutter/material.dart';

class setDrawer extends StatelessWidget {
  final logout;
  setDrawer(this.logout);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu',
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500))),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text(
              'Logout',
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
