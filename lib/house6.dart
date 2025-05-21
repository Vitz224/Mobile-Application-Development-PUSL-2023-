import 'package:flutter/material.dart';

class House6 extends StatefulWidget {
  const House6({Key? key}) : super(key: key);

  @override
  State<House6> createState() => _House6State();
}

class _House6State extends State<House6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "House for rent Pitipana", // Set the title
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
              "images/h6.jpg", // Replace with your image path
              fit: BoxFit.cover,
              height: 200.0, // Adjust the height as needed
            ),
            SizedBox(height: 24.0), // Increased space between image and description
            Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Perched on Rosewood Road, this modern house exudes contemporary elegance and sophistication. With its sleek architectural design and upscale finishes, it presents a luxurious living environment for discerning homeowners. From the gourmet kitchen to the private master suite, every aspect is crafted to perfection, offering a lavish lifestyle in Pitipana.",
            ),
            SizedBox(height: 24.0), // Increased space between description and price
            Text(
              "Price",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Rs 10,000/=",
            ),
            SizedBox(height: 24.0), // Increased space between price and location
            Text(
              "Location",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "32E, Rosewood Road, Pitipana",
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