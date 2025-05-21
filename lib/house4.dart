import 'package:flutter/material.dart';

class House4 extends StatefulWidget {
  const House4({Key? key}) : super(key: key);

  @override
  State<House4> createState() => _House4State();
}

class _House4State extends State<House4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "House for rent pitipana", // Set the title as "Home 1"
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
              "images/h4.webp", // Replace with your image path
              fit: BoxFit.cover,
              height: 200.0, // Adjust the height as needed
            ),
            SizedBox(height: 24.0), // Increased space between image and description
            Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Positioned on Rosewood Street, this elegant house exudes sophistication and charm. Featuring refined architecture and tasteful interiors, the property offers a luxurious living experience. With its peaceful surroundings and easy access to amenities, this address is perfect for those with discerning tastes.",
            ),
            SizedBox(height: 24.0), // Increased space between description and price
            Text(
              "Price",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              " Rs 10,000/=",
            ),
            SizedBox(height: 24.0), // Increased space between price and location
            Text(
              "Location",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "34C, Rosewood Street, Pitipana",
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