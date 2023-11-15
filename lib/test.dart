import 'package:flutter/material.dart';
import '../widgets/animalCard.dart';
import 'filter_icon_widget.dart'; // Import the FilterIconWidget

class AnimalCard extends StatelessWidget {
  // ... existing properties ...

  AnimalCard({
// ... existing constructor parameters ...
}) : super(key: key);

@override
Widget build(BuildContext context) {
// ... existing image loading logic ...

return Container(
width: 400,
height: 150,
child: Card(
child: Row(
children: [
// ... existing image widget ...

Expanded(
child: Padding(
padding: EdgeInsets.symmetric(vertical: 5.0), // Add vertical padding
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
// Add your edit action here
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

// ... existing _buildInfoBox method ...
}
