import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String age;
  final String sex;
  final String status;
  final String? latestWeight;
  final String animalType;
  final String serverDomain;


  AnimalCard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.age,
    required this.sex,
    required this.status,
    required this.animalType,
    this.latestWeight,
    required this.serverDomain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String fullImageUrl = imageUrl != null && imageUrl!.isNotEmpty
        ? '$serverDomain$imageUrl'
        : 'assets/fallback_image.png';

    return Container(
      width: 400,
      height: 150,
      child: Card(
        child: Row(
          children: [
            Image.network(
              fullImageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/fallback_image.png', // fallback image
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                );
              },
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0), // Add vertical padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        InkWell(
                          onTap: () {
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF00B375)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text('Edit', style: TextStyle(color: Color(0xFF00B375))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5), // Spacing after title
                    Text('Age: $age'),
                    SizedBox(height: 5),
                    if (latestWeight != null) Text('Weight: $latestWeight kg'),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              _buildInfoBox(sex),
                              SizedBox(width: 5),
                              _buildInfoBox(status),
                              SizedBox(width: 5),
                              _buildInfoBox(animalType),
                            ],
                          ),
                        ),
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

      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF00B375)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF00B375),
          ),
        ),
      ),
    );
  }
}
