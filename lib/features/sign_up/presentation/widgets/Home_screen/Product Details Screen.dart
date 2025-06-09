import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'Payment Screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/productDetails';

  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Map<String, dynamic> product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      product = args;
    } else {
      product = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    if (product.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Product not found!')),
      );
    }

    return Scaffold(
      backgroundColor: HomeScreen.backgroundColor,
      appBar: AppBar(
        backgroundColor: HomeScreen.backgroundColor,
        elevation: 0,
        title: Text(
          product['title'] ?? 'No Title',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: HomeScreen.accentColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                key: UniqueKey(),
                product['imageUrl'] ?? 'assets/pink_beaded_bag.jpeg',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Image.asset(
                      'assets/pink_beaded_bag.jpeg',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product['title'] ?? 'No Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: HomeScreen.accentColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product['discountedPrice'] != null
                      ? "\$${product['discountedPrice']}"
                      : "\$${product['originalPrice'] ?? 0}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HomeScreen.primaryColor,
                  ),
                ),
                if (product['discountedPrice'] != null)
                  Text(
                    "\$${product['originalPrice'] ?? 0}",
                    style: const TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Rating: ${product['ratingsAverage']?.toStringAsFixed(1) ?? 'N/A'}/5',
              style: TextStyle(fontSize: 16, color: HomeScreen.accentColor),
            ),
            const SizedBox(height: 20),
            Text(
              product['description'] ?? 'No description available',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PaymentScreen.routeName,
                  arguments: product,
                );
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
                'Buy Now',
                style: TextStyle(fontSize: 18, color: HomeScreen.accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
