import 'package:channab_frm/api/ApiService.dart';
import 'package:flutter/material.dart';
import '../widgets/animalCard.dart';
import '../widgets/filter.dart';
import 'animalDetailPage.dart';  // Import AnimalDetailPage

class AnimalListPage extends StatelessWidget {
  final ApiService _apiService = ApiService();
  AnimalListPage({Key? key}) : super(key: key);

  String calculateAge(String dob) {
    DateTime birthDate = DateTime.parse(dob);
    DateTime today = DateTime.now();
    int years = today.year - birthDate.year;
    int months = today.month - birthDate.month;
    int days = today.day - birthDate.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += (days < 0 ? 11 : 12);
    }

    if (days < 0) {
      final monthAgo = DateTime(today.year, today.month - 1, birthDate.day);
      days = today.difference(monthAgo).inDays + 1;
    }

    List<String> ageParts = [];
    if (years > 0) ageParts.add('${years} Year${years != 1 ? 's' : ''}');
    if (months > 0) ageParts.add('${months} Month${months != 1 ? 's' : ''}');
    if (days > 0) ageParts.add('${days} Day${days != 1 ? 's' : ''}');

    return ageParts.join(' ');
  }


  @override
  Widget build(BuildContext context) {
    final token = ModalRoute.of(context)!.settings.arguments as String?;
    if (token != null) {
      _apiService.authToken = token;
      print("Received Token: $token"); // Add this line to print the token
    } else {
      // Handle the case when token is null
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Animals List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Row(
              children: [
                 // Filter icon to the left
                 // Space between filter icon and scrolling list
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(10, (index) => _buildTypeBox('Type ${index + 1}', index)),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FilterIconWidget(),
              ],
            ),
          ),


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
        ],
      ),
    );
  }


Widget _buildTypeBox(String text, int index) {
    return Container(
      width: 77,
      height: 26,
      margin: EdgeInsets.only(right: 8), // Small gap between the boxes
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: _getColorForIndex(index)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: _getColorForIndex(index),
        ),
      ),
    );
  }

  Color _getColorForIndex(int index) {
    // Define a list of colors or generate colors dynamically
    List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple, Colors.pink, Colors.yellow, Colors.teal, Colors.cyan, Colors.amber];
    return colors[index % colors.length];
  }

}
