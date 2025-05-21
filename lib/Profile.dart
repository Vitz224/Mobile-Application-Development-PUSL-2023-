import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Profile01.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

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
        Map<dynamic, dynamic>? userData =
        snapshot.value as Map<dynamic, dynamic>?;
        if (userData != null) {
          setState(() {
            _nameController.text = userData['name'];
            _emailController.text = userData['email'];
            _contactController.text = userData['contact'];
          });
        }
      }, onError: (error) {
        print("Error fetching user data: $error");
      });
    }
  }

  void updateUserData() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child('users').child(userId);

      userRef.update({
        'name': _nameController.text,
        'email': _emailController.text,
        'contact': _contactController.text,
      }).then((_) {
        print('User data updated successfully');
      }).catchError((error) {
        print('Failed to update user data: $error');
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            color: Colors.greenAccent,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _contactController,
                  decoration: InputDecoration(labelText: 'Contact Number'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    updateUserData();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile01()),
                    );
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}