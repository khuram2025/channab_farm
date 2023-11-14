import 'package:channab_frm/widgets/animalCard.dart';
import 'package:flutter/material.dart';


class FamilyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFamilySection(context, 'Father', 'Image URL', 'Name', 'Age'),
            _buildFamilySection(context, 'Mother', 'Image URL', 'Name', 'Age'),
            _buildChildrenSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilySection(BuildContext context, String relation, String imageUrl, String name, String age) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              relation,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {/* Edit logic */},
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {/* Delete logic */},
                ),
              ],
            ),
          ],
        ),
        // AnimalCard(
        //   imageUrl: imageUrl,
        //   title: name,
        //   age: age,
        // ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildChildrenSection(BuildContext context) {
    // Assuming you have a list of children details
    // Replace with actual data
    List<Map<String, String>> children = [
      {'imageUrl': 'Image URL', 'name': 'Child 1', 'age': 'Age'},
      // Add more children here
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Children',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Column(
        //   children: children.map((child) => AnimalCard(
        //     imageUrl: child['imageUrl']!,
        //     title: child['name']!,
        //     age: child['age']!,
        //   )).toList(),
        // ),
      ],
    );
  }
}
