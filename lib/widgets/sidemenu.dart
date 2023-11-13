import 'package:flutter/material.dart';

import '../screens/AnimalListPage.dart';


class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Animal List'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimalListPage()),
              );
            },
          ),
          // Add more items here
        ],
      ),
    );
  }
}
