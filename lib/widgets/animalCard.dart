import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String age;
  final String sex;
  final String status;
  final String animalType;

  AnimalCard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.age,
    required this.sex,
    required this.status,
    required this.animalType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 150,
      child: Card(
        child: Row(
          children: [
            (imageUrl != null && imageUrl!.isNotEmpty)
                ? Image.network(
              imageUrl!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'assets/fallback_image.png', // Path to your fallback image asset
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Age: $age'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          _buildInfoBox('$sex'),
                          SizedBox(width: 5),
                          _buildInfoBox('$status'),
                          SizedBox(width: 5),
                          _buildInfoBox('$animalType'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String text) {
    return Container(
      width: 100,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF00B375)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF00B375),
        ),
      ),
    );
  }
}
