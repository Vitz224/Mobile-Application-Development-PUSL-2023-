import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_new/addDetails.dart';

class ViewAdd extends StatefulWidget {
  const ViewAdd({Key? key}) : super(key: key);

  @override
  State<ViewAdd> createState() => _ViewAddState();
}

class _ViewAddState extends State<ViewAdd> {
  late Query dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('posts').orderByChild('isBooked').equalTo(false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Ad Page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Scrollbar(
        child: Container(
          color: Colors.greenAccent,
          child: FirebaseAnimatedList(
            query: dbRef,
            defaultChild: Text(
              'Loading... Please wait..!!',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map post = snapshot.value as Map;
              post['key'] = snapshot.key;
              return buildCard(post['title'], post['images'][0], ()
              { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addDetails(postId: post['key'])),
              );});
            },
          ),
        ),
      ),
    );
  }

  Widget buildCard(String topic, String imagePath, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 9.0, right: 9.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          side: BorderSide(color: Colors.black, width: 2.0),
        ),
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                imagePath,
                fit: BoxFit.cover,
                height: 150.0,
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  topic,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}