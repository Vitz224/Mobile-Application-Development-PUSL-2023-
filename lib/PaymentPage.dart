import 'package:flutter/material.dart';
import 'package:flutter_new/BankDepositPage.dart';
import 'package:flutter_new/OnlinePayPage.dart';
import 'BankDepositPage.dart'; // Import your BankDeposit.dart file

class PaymentPage extends StatefulWidget {
  final String postId;

  const PaymentPage({Key? key, required this.postId}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'Bank Deposit';
  double _paymentFee = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.greenAccent,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Fee',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter payment fee',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _paymentFee = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Payment Method',
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
                  value: 'Bank Deposit',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                Text('Bank Deposit'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: 'Online Pay',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                Text('Online Pay'),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_selectedPaymentMethod == 'Bank Deposit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BankDepositPage(postId: widget.postId)),
                      );
                    } else if (_selectedPaymentMethod == 'Online Pay') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OnlinePayPage(postId: widget.postId)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text('Make Payment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
