import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class OnlinePayPage extends StatefulWidget {
  final String postId;

  const OnlinePayPage({Key? key, required this.postId}) : super(key: key);

  @override
  _OnlinePayPageState createState() => _OnlinePayPageState();
}

class _OnlinePayPageState extends State<OnlinePayPage> {
  String _selectedCardType = 'Visa';
  String _selectedMonth = 'January';
  int _selectedYear = 2022;
  String _cardholderName = '';
  String _cvv = '';

  DatabaseReference _postRef = FirebaseDatabase.instance.ref().child('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Online Pay',
          textAlign: TextAlign.center, // Align title to the center
        ),
        backgroundColor: Colors.blue,
        centerTitle: true, // Center align the title
      ),
      backgroundColor: Colors.greenAccent, // Set background color
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card Type',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: 'Visa',
                      groupValue: _selectedCardType,
                      onChanged: (value) {
                        setState(() {
                          _selectedCardType = value.toString();
                        });
                      },
                    ),
                    Text('Visa'),
                    SizedBox(width: 10.0),
                    Radio(
                      value: 'Master',
                      groupValue: _selectedCardType,
                      onChanged: (value) {
                        setState(() {
                          _selectedCardType = value.toString();
                        });
                      },
                    ),
                    Text('Master'),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  'Cardholder Name',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter cardholder name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Card Number',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter card number',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      // Convert digits to dots for hiding
                      _cvv = '.' * value.length;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                Text(
                  'Expiry Date',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: _selectedMonth,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedMonth = newValue!;
                        });
                      },
                      items: <String>[
                        'January',
                        'February',
                        'March',
                        'April',
                        'May',
                        'June',
                        'July',
                        'August',
                        'September',
                        'October',
                        'November',
                        'December'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 10.0),
                    DropdownButton<int>(
                      value: _selectedYear,
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedYear = newValue!;
                        });
                      },
                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(
                          value: 2022 + index,
                          child: Text((2022 + index).toString()),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  'CVV',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter CVV',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _cvv = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Cancel');
                      },
                      style: ElevatedButton.styleFrom(),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _savePaymentDetails();
                      },
                      style: ElevatedButton.styleFrom(),
                      child: Text('Pay Now'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _savePaymentDetails() {

    DateTime now = DateTime.now();

    Map<String, dynamic> paymentDetails = {
      'cardType': _selectedCardType,
      'cardholderName': _cardholderName,
      'expiryMonth': _selectedMonth,
      'expiryYear': _selectedYear,
      'timestamp': now.toIso8601String(),
    };

    _postRef
        .child(widget.postId)
        .child('paymentdetails')
        .set(paymentDetails)
        .then((_) {
      print('Payment details saved successfully');

      _postRef.child(widget.postId).update({'isBooked': true}).then((_) {
        print('isBooked updated successfully');

        Navigator.pop(context);
      }).catchError((error) {
        print('Error updating isBooked: $error');
      });
    }).catchError((error) {
      print('Error saving payment details: $error');
    });
  }
}
