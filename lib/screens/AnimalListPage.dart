import 'package:flutter/material.dart';
import '../widgets/animalCard.dart';
import '../widgets/filter.dart';
import 'animalDetailPage.dart';  // Import AnimalDetailPage

class AnimalListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
              itemCount: 10,  // Number of items in the list
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimalDetailPage(
                        imageUrl: 'https://via.placeholder.com/150',
                        title: 'Animal ${index + 1}',
                        age: 'Age Placeholder',
                        status: 'Status Placeholder',
                        type: 'Type Placeholder',
                        lactation: 'Lactation Placeholder',
                        weight: 'Weight Placeholder',
                      ),
                    ),
                  ),
                  child: AnimalCard(
                    imageUrl: 'https://via.placeholder.com/150',
                    title: 'Animal ${index + 1}',
                    age: '${index + 1} years',
                  ),
                );
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
