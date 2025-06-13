import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class PaymentScreen extends StatelessWidget {
  static const String routeName = '/payment';

  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final product = args ?? {'title': 'Unknown Product', 'price': 0.0};

    return Scaffold(
      backgroundColor: HomeScreen.backgroundColor,
      appBar: AppBar(
        backgroundColor: HomeScreen.backgroundColor,
        elevation: 0,
        title: Text(
          'Payment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: HomeScreen.accentColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 20),
          Icon(Icons.payment, size: 80, color: HomeScreen.primaryColor),
          const SizedBox(height: 20),
          Text(
            'Product: ${product['title']}',
            style: TextStyle(
              fontSize: 20,
              color: HomeScreen.accentColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Price: \$${product['price'] ?? product['discountedPrice']}',
            style: TextStyle(fontSize: 18, color: HomeScreen.primaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: HomeScreen.accentColor,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: "Card Number",
              hintText: "1234 5678 9012 3456",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: HomeScreen.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: HomeScreen.accentColor),
              ),
              contentPadding: const EdgeInsets.all(16.0),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Expiry Date",
                    hintText: "MM/YY",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: HomeScreen.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: HomeScreen.accentColor),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "CVV",
                    hintText: "123",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: HomeScreen.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: HomeScreen.accentColor),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment Successful!')),
              );
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: HomeScreen.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              'Confirm Payment',
              style: TextStyle(fontSize: 18, color: HomeScreen.accentColor),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
