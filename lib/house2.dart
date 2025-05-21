import 'package:flutter/material.dart';

class House2 extends StatefulWidget {
  const House2({Key? key}) : super(key: key);

  @override
  State<House2> createState() => _House2State();
}

class _House2State extends State<House2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "House for rent katuwana", // Set the title as "Home 1"
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
              "images/h2.jpg", // Replace with your image path
              fit: BoxFit.cover,
              height: 200.0, // Adjust the height as needed
            ),
            SizedBox(height: 24.0), // Increased space between image and description
            Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Nestled on Sunflower Lane, this charming house offers a tranquil retreat from the bustling city life. Surrounded by lush greenery, the property boasts a serene ambiance, perfect for those seeking peace and quiet. With spacious interiors and modern amenities, this address promises a comfortable lifestyle.",
            ),
            SizedBox(height: 24.0), // Increased space between description and price
            Text(
              "Price",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "\ Rs 25,000/=",
            ),
            SizedBox(height: 24.0), // Increased space between price and location
            Text(
              "Location",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "23A, Sunflower Lane, Katuwana",
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