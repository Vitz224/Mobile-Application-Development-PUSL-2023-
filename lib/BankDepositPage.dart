import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_new/homepage.dart';
import 'package:image_picker/image_picker.dart';

class BankDepositPage extends StatefulWidget {
  final String postId;

  const BankDepositPage({Key? key, required this.postId}) : super(key: key);

  @override
  _BankDepositPageState createState() => _BankDepositPageState();
}

class _BankDepositPageState extends State<BankDepositPage> {
  String _landlordBankDetails = "";
  File? _bankDepositImage;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _bankDepositImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_bankDepositImage != null) {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('bankdetails')
          .child(widget.postId)
          .child('deposit_slip.jpg');

      final UploadTask uploadTask = storageRef.putFile(_bankDepositImage!);

      await uploadTask.whenComplete(() async {
        String imageUrl = await storageRef.getDownloadURL();
        await _dbRef
            .child('posts')
            .child(widget.postId)
            .child('bankdetails')
            .set({'bank_details': _landlordBankDetails, 'image_url': imageUrl});
      });

      await _dbRef.child('posts').child(widget.postId).update({'isBooked': true});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bank Deposit',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.greenAccent,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Landlord Bank Details:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _landlordBankDetails = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Bank Details',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Bank Deposit Slip Image:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: _selectImage,
              child: Container(
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                ),
                child: _bankDepositImage != null
                    ? Image.file(_bankDepositImage!, fit: BoxFit.cover)
                    : Icon(Icons.add_photo_alternate, size: 50.0),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _uploadImage();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        label: Text('Save'),
        icon: Icon(Icons.save),
      ),
    );
  }
}
