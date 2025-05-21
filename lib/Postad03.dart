import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'LandlordBankDetailsPage.dart';
import 'package:image_picker/image_picker.dart';

class Postad03 extends StatefulWidget {
  final String postId;

  const Postad03({Key? key, required this.postId}) : super(key: key);

  @override
  State<Postad03> createState() => _Postad03State();
}

class _Postad03State extends State<Postad03> {
  String rent = '';
  List<File> images = [];

  Future<void> pickImages() async {
    final List<XFile>? pickedImages =
    await ImagePicker().pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        images = pickedImages.map((XFile file) => File(file.path)).toList();
      });
    }
  }

  Future<void> uploadImages() async {
    List<String> imageUrls = [];

    for (var imageFile in images) {
      Reference ref = FirebaseStorage.instance.ref().child(
          'images/${widget.postId}/${Path.basename(imageFile.path)}');
      UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask.whenComplete(() async {
        String url = await ref.getDownloadURL();
        imageUrls.add(url);
      });
    }

    // Get a reference to the existing post in the database
    DatabaseReference postRef =
    FirebaseDatabase.instance.reference().child('posts').child(widget.postId);

    // Update the existing post with new values
    await postRef.update({
      'rent': rent,
      'images': imageUrls,
    }).then((_) {
      print('Post updated successfully');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LandlordBankDetailsPage(postId: widget.postId)),
      );
    }).catchError((error) {
      print('Failed to update post: $error');
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
      body: Center(
        child: Container(
          width: 600,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/RE.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                'Rent',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'What is the Rent of the Property?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Rent (per month)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    rent = value;
                  });
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  pickImages();
                },
                child: Text('Upload Images'),
              ),
              SizedBox(height: 20),
              Text(
                'Add Photos (Up to 3)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Upload Pictures of your Rooms Annex and Rentals',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: images.map((File image) {
                  return Image.file(
                    image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  uploadImages();
                },
                child: Text('Add your Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}