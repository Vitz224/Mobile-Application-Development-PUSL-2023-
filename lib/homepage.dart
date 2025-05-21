import 'package:flutter/material.dart';
import 'Postad.dart';
import 'Viewad.dart';
import 'Profile.dart';
import 'PaymentPage.dart';
import 'FeedbackPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome to Green Lodge",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.menu),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Container(
        color: Colors.greenAccent,
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/home.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20.0),
              Text(
                "Welcome to Green Lodge",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostAdd()),
                  );
                },
                child: Text(
                  "Post Ads",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAdd()),
                  );
                },
                child: Text(
                  "View Ads",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 20.0),
              Divider(
                color: Colors.white,
              ),
              ElevatedButton(
                onPressed: () {
                  // Pass postId parameter here
                  String postId = 'your_post_id'; // Replace 'your_post_id' with actual postId
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage(postId: postId)),
                  );
                },
                child: Text(
                  "Make Payments",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeedbackPage()),
                  );
                },
                child: Text(
                  "Feedback",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}