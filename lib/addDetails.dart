import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import 'package:flutter_new/PaymentPage.dart';

class addDetails extends StatefulWidget {
  final String postId;

  const addDetails({Key? key, required this.postId}) : super(key: key);

  @override
  State<addDetails> createState() => _addDetailsState();
}

class _addDetailsState extends State<addDetails> {
  late DatabaseReference _postRef;
  Map<String, dynamic>? _postDetails;

  @override
  void initState() {
    super.initState();
    _postRef = FirebaseDatabase.instance.ref().child('posts').child(widget.postId);
    _postRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      dynamic value = snapshot.value;

      if (value is Map<dynamic, dynamic>) {
        // Convert the map to Map<String, dynamic> if possible
        Map<String, dynamic>? postDetails = _convertMap(value);

        if (postDetails != null) {
          setState(() {
            _postDetails = postDetails;
          });
        } else {
          print("Error: Failed to convert map to Map<String, dynamic>");
        }
      } else {
        print("Invalid data format: $value");
      }
    }).onError((error) {
      print("Error fetching post details: $error");
    });
  }

  Map<String, dynamic>? _convertMap(Map<dynamic, dynamic> map) {
    try {
      return map.cast<String, dynamic>();
    } catch (e) {
      print("Error converting map: $e");
      return null;
    }
  }

  void _launchCaller(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    await launch(url);
  }

  // Define _launchMessage method here
  void _launchMessage(String phoneNumber) async {
    final url = 'sms:$phoneNumber';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _postDetails?['title'] ?? "Post Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: _postDetails == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        color: Colors.greenAccent,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              _postDetails?['images'][0] ?? "",
              fit: BoxFit.cover,
              height: 200.0,
            ),
            SizedBox(height: 24.0),
            Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              _postDetails?['description'] ?? "",
            ),
            SizedBox(height: 24.0),
            Text(
              "Price",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              _postDetails?['rent'] ?? "",
            ),
            SizedBox(height: 24.0),
            Text(
              "Location",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              _postDetails?['location'] ?? "",
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _launchCaller(_postDetails?['phoneNumber']);
                  },
                  icon: Icon(Icons.call),
                  label: Text("Call"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _launchMessage(_postDetails?['phoneNumber']);
                  },
                  icon: Icon(Icons.chat),
                  label: Text("Chat"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(postId: widget.postId),
                      ),
                    );
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