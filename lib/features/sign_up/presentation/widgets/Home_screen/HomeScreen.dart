import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../../product_model.dart';
import 'Taps/Home_tap.dart';
import 'Taps/Profile_tap.dart';
import 'Taps/Wishlist_tap.dart';
import 'Taps/cart_tap.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';
  static const Color primaryColor = Color(0xFFD2B48C);
  static const Color accentColor = Color(0xFF8B4513);
  static const Color backgroundColor = Color(0xFFF5F5F0);

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  late List<Product> discountedProducts = [];
  late List<Product> featuredProducts = [];
  late List<Product> allProducts = [];
  List<Map<String, dynamic>> wishlistItems = [];
  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  late List<Widget> taps;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      print('Starting to load db.json...');
      final String response = await rootBundle.loadString('assets/db.json');
      print('Loaded JSON: $response');
      final productsResponse = ProductsResponse.fromJson(jsonDecode(response));
      print('Parsed products: ${productsResponse.products.length}');
      setState(() {
        allProducts = productsResponse.products;
        print('All products set: ${allProducts.length}');
        discountedProducts =
            allProducts.length >= 3 ? allProducts.sublist(0, 3) : allProducts;
        featuredProducts =
            allProducts.length >= 9
                ? allProducts.sublist(3, 9)
                : allProducts.length > 3
                ? allProducts.sublist(3)
                : [];
        print(
          'Discounted: ${discountedProducts.length}, Featured: ${featuredProducts.length}',
        );
        isLoading = false;
        taps = [
          HomeTap(
            discountedProducts: discountedProducts,
            featuredProducts: featuredProducts,
            primaryColor: HomeScreen.primaryColor,
            accentColor: HomeScreen.accentColor,
            backgroundColor: HomeScreen.backgroundColor,
            wishlistItems: wishlistItems,
            addToWishlist: addToWishlist,
            removeFromWishlist: removeFromWishlist,
            cartItems: cartItems,
            addToCart: addToCart,
            removeFromCart: removeFromCart,
            updateQuantity: updateQuantity,
          ),
          WishlistTap(
            wishlistItems: wishlistItems,
            removeFromWishlist: removeFromWishlist,
            accentColor: HomeScreen.accentColor,
            backgroundColor: HomeScreen.backgroundColor,
          ),
          CartTap(
            cartItems: cartItems,
            removeFromCart: removeFromCart,
            updateQuantity: updateQuantity,
            accentColor: HomeScreen.accentColor,
            backgroundColor: HomeScreen.backgroundColor,
            primaryColor: HomeScreen.primaryColor,
          ),
          ProfileTap(
            primaryColor: HomeScreen.primaryColor,
            accentColor: HomeScreen.accentColor,
            backgroundColor: HomeScreen.backgroundColor,
          ),
        ];
      });
    } catch (e) {
      print('Error loading products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void addToWishlist(Map<String, dynamic> product) {
    setState(() {
      wishlistItems.add(product);
    });
  }

  void removeFromWishlist(Map<String, dynamic> product) {
    setState(() {
      wishlistItems.removeWhere((item) => item['title'] == product['title']);
    });
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      final existingProduct = cartItems.firstWhere(
        (item) => item['title'] == product['title'],
        orElse: () => {},
      );
      if (existingProduct.isNotEmpty) {
        existingProduct['quantity'] = (existingProduct['quantity'] ?? 1) + 1;
      } else {
        cartItems.add({...product, 'quantity': 1});
      }
    });
  }

  void removeFromCart(Map<String, dynamic> product) {
    setState(() {
      cartItems.removeWhere((item) => item['title'] == product['title']);
    });
  }

  void updateQuantity(Map<String, dynamic> product, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        cartItems.removeWhere((item) => item['title'] == product['title']);
      } else {
        final existingProduct = cartItems.firstWhere(
          (item) => item['title'] == product['title'],
        );
        existingProduct['quantity'] = newQuantity;
      }
    });
  }

  void addOrder(Map<String, dynamic> order) {
    setState(() {
      orders.add(order);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: HomeScreen.backgroundColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: HomeScreen.backgroundColor,
      appBar: AppBar(
        backgroundColor: HomeScreen.backgroundColor,
        elevation: 0,
        title: Text(
          selectedIndex == 0
              ? "La Rase Store"
              : selectedIndex == 1
              ? "Wishlist"
              : selectedIndex == 2
              ? "Cart"
              : "Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: HomeScreen.accentColor,
          ),
        ),
        centerTitle: true,
      ),
      body: taps[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: HomeScreen.accentColor.withOpacity(0.6),
        backgroundColor: HomeScreen.backgroundColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
