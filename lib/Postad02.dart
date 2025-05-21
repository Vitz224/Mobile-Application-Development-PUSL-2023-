import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Postad03.dart';

class Postad02 extends StatefulWidget {
  final String postId;

  const Postad02({Key? key, required this.postId}) : super(key: key);

  @override
  State<Postad02> createState() => _Postad02State();
}

class _Postad02State extends State<Postad02> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _opAddressController = TextEditingController();

  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  void savePostToDatabase() {
    _database.child('posts').child(widget.postId).update({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'optionalAddress': _opAddressController.text,
    }).then((_) {
      print('Post updated in database successfully');
    }).catchError((error) {
      print('Failed to update post in database: $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Ad',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address (Optional):',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Enter Your Street or House Number or Post Code:',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _opAddressController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Title:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Your Title Must Have At Least 5 Characters:',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Enter your Post Description:',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          savePostToDatabase();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Postad03(postId: widget.postId)),
          );
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}