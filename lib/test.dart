import 'package:flutter/material.dart';
import '../widgets/animalCard.dart';
import 'filter_icon_widget.dart'; // Import the FilterIconWidget

// Inside ApiService class

import 'package:flutter/material.dart';
import 'package:channab_frm/api/ApiService.dart';
import 'package:channab_frm/screens/AnimalDetailScreen.dart'; // Import AnimalDetailScreen
//... other imports
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ... Existing imports ...

class AnimalDetailPage extends StatefulWidget {
  final int animalId;
  final ApiService apiService;

  AnimalDetailPage({
    Key? key,
    required this.animalId,
    required this.apiService,
  }) : super(key: key);

  @override
  _AnimalDetailPageState createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  int _selectedIndex = 0;
  late List<Map<String, dynamic>> weightData; // Declare variable to store weight data

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: widget.apiService.fetchAnimalDetails(widget.animalId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text("Error: ${snapshot.error}")));
        } else if (snapshot.hasData) {
          var animalData = snapshot.data!;
          weightData = animalData['weights']?.map<Map<String, dynamic>>((item) => {
            'date': item['date'],
            'weight_kg': item['weight_kg'],
            'description': item['description'],
          }).toList() ?? [];
          return _buildAnimalDetailPage(context, animalData);
        } else {
          return Scaffold(body: Center(child: Text("No animal data found")));
        }
      },
    );
  }

  // ... Other methods ...

  Scaffold _buildAnimalDetailPage(BuildContext context, Map<String, dynamic> animalData) {
    // ... Existing code ...

    List<Widget> _tabWidgets = [
      // ... Other tabs ...
      WeightTab(weightData: weightData), // Pass weight data to WeightTab
      // ... Other tabs ...
    ];

    // ... Remaining code ...
  }

// ... Remaining code ...
}
