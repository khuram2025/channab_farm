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


// ... [previous code] ...

Expanded(
child: FutureBuilder<List<dynamic>>(
future: _apiService.fetchAnimals(),
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return CircularProgressIndicator();
} else if (snapshot.hasError) {
print('Error fetching animals: ${snapshot.error}');
return Text('Error: ${snapshot.error}');
} else {
return ListView.builder(
itemCount: snapshot.data!.length,
itemBuilder: (context, index) {
var animal = snapshot.data![index];
return GestureDetector(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => AnimalDetailPage(
animalId: animal['id'],  // Pass the animal ID
apiService: _apiService,
),
),
);
},
child: AnimalCard(
imageUrl: animal['image_url'],
serverDomain: 'http://farmapp.channab.com',
title: animal['tag'],
age: calculateAge(animal['dob']),
sex: animal['sex'],
latestWeight: animal['latest_weight'] != null ? animal['latest_weight'].toString() : null,
status: animal['status'],
animalType: animal['animal_type'],
),
);
},
);
}
},
),
),

// ... [rest of the code] ...
