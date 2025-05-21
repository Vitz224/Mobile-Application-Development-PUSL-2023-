import 'package:flutter/material.dart';

class House5 extends StatefulWidget {
  const House5({Key? key}) : super(key: key);

  @override
  State<House5> createState() => _House5State();
}

class _House5State extends State<House5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "House for rent homagama", // Set the title
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
              "images/h5.jpg", // Replace with your image path
              fit: BoxFit.cover,
              height: 200.0, // Adjust the height as needed
            ),
            SizedBox(height: 24.0), // Increased space between image and description
            Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Nestled in a serene neighborhood, this charming house on Mahawatta Road offers tranquility and convenience. With spacious interiors and a well-maintained exterior, this property provides a comfortable living space for families. Close proximity to schools, shops, and public transport adds to the appeal of this address.",
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
              "12A, Mahawatta Road, Homagama",
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