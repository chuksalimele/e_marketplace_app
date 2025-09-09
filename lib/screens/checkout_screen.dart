// lib/screens/checkout_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CheckoutScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator:
                    (value) => value!.isEmpty ? 'Enter your address' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payment Details'),
                validator:
                    (value) => value!.isEmpty ? 'Enter payment details' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await _apiService.checkout({
                        'name': 'Customer Name', // Replace with form data
                        'address': 'Customer Address',
                        'paymentDetails': 'Card Info',
                      });
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Order placed!')));
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  }
                },
                child: Text('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
