import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Postad02.dart';

class PostAdd extends StatefulWidget {
  const PostAdd({Key? key}) : super(key: key);

  @override
  State<PostAdd> createState() => _PostAddState();
}

class _PostAddState extends State<PostAdd> {
  String _selectedOption = 'House Rentals';
  String _location = '';
  int _numberOfBeds = 0;
  int _numberOfBathrooms = 0;
  bool _privateEntrance = false;
  bool _lower = false;
  bool _upper = false;

  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('posts');

  void savePostToDatabase() {
    DatabaseReference newPostRef = _database.push();
    newPostRef.set({
      'category': _selectedOption,
      'location': _location,
      'numberOfBeds': _numberOfBeds,
      'numberOfBathrooms': _numberOfBathrooms,
      'privateEntrance': _privateEntrance,
      'lower': _lower,
      'upper': _upper,
      'isBooked': false
    }).then((_) {
      print('Post added to database successfully');
      String postId = newPostRef.key ?? '';
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Postad02(postId: postId)),
      );
    }).catchError((error) {
      print('Failed to add post to database: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
                    'Select the Category:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  DropdownButton<String>(
                    value: _selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue!;
                      });
                    },
                    items: <String>[
                      'House Rentals',
                      'Apartments Rentals',
                      'Room & Annex Rentals',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Location',
                      hintText: 'Enter location',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _location = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Number of Beds:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _numberOfBeds = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Number of Bathrooms:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _numberOfBathrooms = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Select Features (Optional):',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text('Private Entrance'),
                      Checkbox(
                        value: _privateEntrance,
                        onChanged: (bool? value) {
                          setState(() {
                            _privateEntrance = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Lower'),
                      Checkbox(
                        value: _lower,
                        onChanged: (bool? value) {
                          setState(() {
                            _lower = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Upper'),
                      Checkbox(
                        value: _upper,
                        onChanged: (bool? value) {
                          setState(() {
                            _upper = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            savePostToDatabase();
          },
          child: Icon(Icons.arrow_forward),
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}