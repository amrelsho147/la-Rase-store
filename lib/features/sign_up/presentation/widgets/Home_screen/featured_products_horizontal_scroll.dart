import 'package:flutter/material.dart';

import 'Product Details Screen.dart';

class FeaturedProductsHorizontalScroll extends StatefulWidget {
  final List<Map<String, dynamic>> featuredProducts;
  final Color primaryColor;
  final Color accentColor;
  final List<Map<String, dynamic>> wishlistItems;
  final Function(Map<String, dynamic>) addToWishlist;
  final Function(Map<String, dynamic>) removeFromWishlist;
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) addToCart;
  final Function(Map<String, dynamic>) removeFromCart;
  final Function(Map<String, dynamic>, int) updateQuantity;

  const FeaturedProductsHorizontalScroll({
    Key? key,
    required this.featuredProducts,
    required this.primaryColor,
    required this.accentColor,
    required this.wishlistItems,
    required this.addToWishlist,
    required this.removeFromWishlist,
    required this.cartItems,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateQuantity,
  }) : super(key: key);

  @override
  State<FeaturedProductsHorizontalScroll> createState() =>
      _FeaturedProductsHorizontalScrollState();
}

class _FeaturedProductsHorizontalScrollState
    extends State<FeaturedProductsHorizontalScroll> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Featured Products",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.accentColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: widget.featuredProducts.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final product = widget.featuredProducts[index];
              final isInWishlist = widget.wishlistItems.any(
                (item) => item['title'] == product['title'],
              );
              final isInCart = widget.cartItems.any(
                (item) => item['title'] == product['title'],
              );
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductDetailsScreen.routeName,
                    arguments: product,
                  );
                },
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: widget.accentColor.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.asset(
                              product['imageUrl'],
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                  child: const Center(
                                    child: Text('Image Error'),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                isInWishlist
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    isInWishlist
                                        ? Colors.red
                                        : widget.accentColor,
                              ),
                              onPressed: () {
                                if (isInWishlist) {
                                  widget.removeFromWishlist(product);
                                } else {
                                  widget.addToWishlist(product);
                                }
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product['title'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: widget.accentColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "\$${product['price']}",
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isInCart) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${product['title']} is already in your cart!",
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } else {
                              widget.addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${product['title']} added to cart!",
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              setState(() {});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(double.infinity, 30),
                          ),
                          child: Text(
                            isInCart ? "Added to Cart" : "Add to Cart",
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.accentColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
