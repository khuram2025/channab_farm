import 'package:flutter/material.dart';
import 'package:channab_frm/api/ApiService.dart';
import 'package:channab_frm/widgets/familyTab.dart';
import 'package:channab_frm/widgets/milkingTab.dart';

import 'package:channab_frm/screens/AnimalUploadEditPage.dart';

import '../widgets/wightTab.dart';

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
  late List<Map<String, dynamic>> weightData;
  late List<dynamic> milkRecords;

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
          milkRecords = animalData['milk_records'] ?? [];
          return _buildAnimalDetailPage(context, animalData);
        } else {
          return Scaffold(body: Center(child: Text("No animal data found")));
        }
      },
    );
  }

  Scaffold _buildAnimalDetailPage(BuildContext context, Map<String, dynamic> animalData) {
    String imageUrl = animalData['image_url'] ?? 'assets/fallback_image.png'; // Provide a default or handle nulls
    String title = animalData['tag'] ?? 'N/A';
    String age = 'Calculate age from DOB'; // You need to calculate age from DOB
    String status = animalData['status'] ?? 'N/A';
    String type = animalData['animal_type'] ?? 'N/A';
    String lactation = 'N/A'; // You need to handle lactation data
    String weight = animalData['latest_weight']?.toString() ?? 'N/A';

    List<Widget> _tabWidgets = [
      _InfoWidget(
        title: title,
        age: age,
        status: status,
        type: type,
        lactation: lactation,
        weight: weight,
      ),
      FamilyTab(), // You might need to adjust this tab based on actual data structure
      WeightTab(weightData: weightData),
      MilkingTab(milkRecords: milkRecords, animalId: widget.animalId, apiService: widget.apiService,),

      Center(child: Text('Health')),
    ];
    String baseUrl = 'http://farmapp.channab.com'; // Your API base URL
    String fullimageUrl = baseUrl + (animalData['image'] ?? '/assets/fallback_image.png'); // Concatenate base URL with image path

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
                  title,
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
            height: 250,
          child: Image.network(fullimageUrl, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/fallback_image.png', fit: BoxFit.cover); // Fallback image
        }),
          ),
          Container(
            color: Colors.grey[300],
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
              child: _buildTabContent(),
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
  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return _InfoWidget(title: '', status: '', age: '', type: '', lactation: '', weight: '',/* ... */);
      case 1:
        return FamilyTab(/* ... */);
      case 2:
        return WeightTab(weightData: weightData);
      case 3:
        return MilkingTab(
          milkRecords: milkRecords,
          animalId: widget.animalId,
          apiService: widget.apiService,
        );

    case 4:
        return Center(child: Text('Health'));
      default:
        return Center(child: Text('No content available'));
    }
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
            SizedBox(height: 8),
            _buildInfoRow('Age', age),
            SizedBox(height: 8),
            _buildInfoRow('Status', status),
            SizedBox(height: 8),
            _buildInfoRow('Type', type),
            SizedBox(height: 8),
            _buildInfoRow('Lactation', lactation),
            SizedBox(height: 8),
            _buildInfoRow('Weight', weight),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
