import 'package:flutter/material.dart';

class House1 extends StatefulWidget {
  const House1({Key? key}) : super(key: key);

  @override
  State<House1> createState() => _House1State();
}

class _House1State extends State<House1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "House for rent Homagama", // Set the title as "Home 1"
          style: TextStyle(color: Colors.white), // Change title color to white
        ),
        centerTitle: true, // Center the title
        backgroundColor: Colors.blue, // Change app bar color to blue
      ),
      body: Container(
        color: Colors.greenAccent, // Setting background color to green
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "images/h1.jpg", // Replace with your image path
              fit: BoxFit.cover,
              height: 200.0, // Adjust the height as needed
            ),
            SizedBox(height: 24.0), // Increased space between image and description
            Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Situated on Orchid Road, this cozy house offers a warm and inviting atmosphere. Surrounded by colorful gardens and mature trees, the property provides a picturesque setting for everyday living. With its convenient location and charming appeal, this address is sure to impress.",
            ),
            SizedBox(height: 24.0), // Increased space between description and price
            Text(
              "Price",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "\ Rs 20,000/=", // Removed the extra space
            ),
            SizedBox(height: 24.0), // Increased space between price and location
            Text(
              "Location",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "12B, Orchid Road, Homagama",
            ),
            SizedBox(height: 24.0), // Increased space between location and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement call functionality
                  },
                  icon: Icon(Icons.call),
                  label: Text("Call"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement chat functionality
                  },
                  icon: Icon(Icons.chat),
                  label: Text("Chat"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement book now functionality
                  },
                  icon: Icon(Icons.book),
                  label: Text("Book Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}