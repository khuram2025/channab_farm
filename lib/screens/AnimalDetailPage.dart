import 'package:channab_frm/screens/AnimalUploadEditPage.dart';
import 'package:channab_frm/widgets/familyTab.dart';
import 'package:channab_frm/widgets/milkingTab.dart';
import 'package:flutter/material.dart';

import '../widgets/wightTab.dart';

class AnimalDetailPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String age;
  final String status;
  final String type;
  final String lactation;
  final String weight;

  AnimalDetailPage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.age,
    required this.status,
    required this.type,
    required this.lactation,
    required this.weight,
  }) : super(key: key);


  @override
  _AnimalDetailPageState createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  int _selectedIndex = 0; // To track the selected tab

  @override
  Widget build(BuildContext context) {
    List<Widget> _tabWidgets = [
      _InfoWidget(
        title: widget.title,
        age: widget.age,
        status: widget.status,
        type: widget.type,
        lactation: widget.lactation,
        weight: widget.weight,
      ),
      FamilyTab(),
      WeightTab(),
     MilkingTab(),
      Center(child: Text('Health')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {/* Notification logic */},
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AnimalUploadEditPage()),
                        );
                      },
                    ),

                  ],
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 500),
            width: MediaQuery.of(context).size.width,
            height: 250,  // Set the height to 300 pixels
            child: Image.network(widget.imageUrl, fit: BoxFit.cover),
          ),


          Container(
            color: Colors.grey[300], // Background color for tabs
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  5,
                      (index) => _buildTabItem(index, ['Info', 'Family', 'Weight', 'Milking', 'Health'][index]),
                ),
              ),
            ),
          ),
          Expanded(
            child: _tabWidgets[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _selectedIndex == index ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }
}


class _InfoWidget extends StatelessWidget {
  final String title, age, status, type, lactation, weight;

  _InfoWidget({
    required this.title,
    required this.age,
    required this.status,
    required this.type,
    required this.lactation,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Title', title),
            SizedBox(height: 8), // Added vertical space
            _buildInfoRow('Age', age),
            SizedBox(height: 8), // Added vertical space
            _buildInfoRow('Status', status),
            SizedBox(height: 8), // Added vertical space
            _buildInfoRow('Type', type),
            SizedBox(height: 8), // Added vertical space
            _buildInfoRow('Lactation', lactation),
            SizedBox(height: 8), // Added vertical space
            _buildInfoRow('Weight', weight),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0), // Increased vertical padding
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700], // Adjusted label color
                fontSize: 16, // Adjusted font size
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16, // Adjusted value font size
                color: Colors.black87, // Adjusted value color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
