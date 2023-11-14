import 'package:flutter/material.dart';
import '../widgets/animalCard.dart';
import 'filter_icon_widget.dart'; // Import the FilterIconWidget

class AnimalCard extends StatelessWidget {
  // ... existing properties ...

  @override
  Widget build(BuildContext context) {
    String fullImageUrl = imageUrl != null ? 'http://example.com$imageUrl' : 'assets/fallback_image.png';

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
            Expanded(  // Wrap with Expanded to prevent overflow
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
                          _buildInfoBox(sex),
                          SizedBox(width: 5),
                          _buildInfoBox(status),
                          SizedBox(width: 5),
                          _buildInfoBox(animalType),
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

// ... _buildInfoBox method ...
}
