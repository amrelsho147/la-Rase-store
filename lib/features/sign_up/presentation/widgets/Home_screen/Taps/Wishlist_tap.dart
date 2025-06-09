import 'package:flutter/material.dart';

class WishlistTap extends StatefulWidget {
  final List<Map<String, dynamic>> wishlistItems;
  final Function(Map<String, dynamic>) removeFromWishlist;
  final Color accentColor;
  final Color backgroundColor;

  const WishlistTap({
    Key? key,
    required this.wishlistItems,
    required this.removeFromWishlist,
    required this.accentColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<WishlistTap> createState() => _WishlistTapState();
}

class _WishlistTapState extends State<WishlistTap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body:
          widget.wishlistItems.isEmpty
              ? Center(
                child: Text(
                  "Your Wishlist is Empty",
                  style: TextStyle(fontSize: 18, color: widget.accentColor),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: widget.wishlistItems.length,
                itemBuilder: (context, index) {
                  final product = widget.wishlistItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.asset(
                        product['imageUrl'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            child: const Center(child: Text('Image Error')),
                          );
                        },
                      ),
                      title: Text(
                        product['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: widget.accentColor,
                        ),
                      ),
                      subtitle: Text(
                        product.containsKey('price')
                            ? "\$${product['price']}"
                            : "\$${product['discountedPrice']}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          widget.removeFromWishlist(product);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
