import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MaterialApp(
    home: Profile01(),
  ));
}

class Profile01 extends StatefulWidget {
  const Profile01({Key? key}) : super(key: key);

  @override
  State<Profile01> createState() => _ProfileState();
}

class _ProfileState extends State<Profile01> {
  String _name = '';
  String _email = '';
  String _phone = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }
  void fetchUserData() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;
      DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child('users').child(userId);

      userRef.onValue.listen((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic, dynamic>? userData = snapshot.value
        as Map<dynamic, dynamic>?;
        if (userData != null) {
          setState(() {
            _name = userData['name'] ?? '';
            _email = userData['email'] ?? '';
            _phone = userData['contact'] ?? '';
          });
        }
      }, onError: (error) {
        print("Error fetching user data: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("My Profile"),
        centerTitle: true,
      ),
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/profile.png"),
                  radius: 80.0,
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.black,
              ),
              SizedBox(height: 10),
              Text(
                "Name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                _name,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                "Email",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    _email,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Phone",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    _phone,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}