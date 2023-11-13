import 'package:flutter/material.dart';
import '../widgets/customeAppBar.dart';
import '../widgets/custome_tab.dart';
import '../widgets/sidemenu.dart';


class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      drawer: SideMenu(),
      body: GridView.count(
        crossAxisCount: 2, // Two columns
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          CustomTab(title: "Income", price: "\$1000"),
          CustomTab(title: "Expense", price: "\$500"),
          CustomTab(title: "Profit", price: "\$1500"),
          CustomTab(title: "Milk", price: "\$200"),
        ],
      ),
    );
  }
}
