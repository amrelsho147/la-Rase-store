import 'package:flutter/material.dart';

import 'Product Details Screen.dart';

class DiscountedSlider extends StatefulWidget {
  final List<Map<String, dynamic>> discountedProducts;
  final Color primaryColor;
  final Color accentColor;
  final List<Map<String, dynamic>> wishlistItems;
  final Function(Map<String, dynamic>) addToWishlist;
  final Function(Map<String, dynamic>) removeFromWishlist;
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) addToCart;
  final Function(Map<String, dynamic>) removeFromCart;
  final Function(Map<String, dynamic>, int) updateQuantity;

  const DiscountedSlider({
    Key? key,
    required this.discountedProducts,
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
  State<DiscountedSlider> createState() => _DiscountedSliderState();
}

class _DiscountedSliderState extends State<DiscountedSlider> {
  @override
  Widget build(BuildContext context) {
    // طباعة البيانات للتحقق من الـ imageUrl
    for (var product in widget.discountedProducts) {
      print("Product: ${product['title']}, Image: ${product['imageUrl']}");
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Special Offers",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.accentColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.8),
            itemCount: widget.discountedProducts.length,
            itemBuilder: (context, index) {
              final product = widget.discountedProducts[index];
              final isInWishlist = widget.wishlistItems.any(
                (item) => item['title'] == product['title'],
              );
              final isInCart = widget.cartItems.any(
                (item) => item['title'] == product['title'],
              );
              return Builder(
                builder: (BuildContext itemContext) {
                  return GestureDetector(
                    onTap: () {
                      print(
                        "Navigating to Product Details for ${product['title']}",
                      );
                      Navigator.push(
                        itemContext,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(),
                          settings: RouteSettings(arguments: product),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
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
                                    height: 130,
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "\$${product['discountedPrice']}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: widget.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "\$${product['originalPrice']}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
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
                                  isInCart ? "Added to Cart" : "Buy Now",
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
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
