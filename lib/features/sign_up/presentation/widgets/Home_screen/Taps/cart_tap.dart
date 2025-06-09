import 'package:flutter/material.dart';
import '../Payment Screen.dart';

class CartTap extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) removeFromCart;
  final Function(Map<String, dynamic>, int) updateQuantity;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;

  const CartTap({
    Key? key,
    required this.cartItems,
    required this.removeFromCart,
    required this.updateQuantity,
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<CartTap> createState() => _CartTapState();
}

class _CartTapState extends State<CartTap> {
  double getTotalPrice() {
    return widget.cartItems.fold(0.0, (total, item) {
      final price =
          (item.containsKey('price') ? item['price'] : item['discountedPrice'])
              as double;
      final quantity = (item['quantity'] ?? 1) as int;
      return total + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body:
          widget.cartItems.isEmpty
              ? Center(
                child: Text(
                  "Your Cart is Empty",
                  style: TextStyle(fontSize: 18, color: widget.accentColor),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final product = widget.cartItems[index];
                        final quantity = product['quantity'] ?? 1;
                        final price =
                            (product.containsKey('price')
                                    ? product['price']
                                    : product['discountedPrice'])
                                as double;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  product['imageUrl'],
                                  width: 80,
                                  height: 80,
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
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['title'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: widget.accentColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "\$${price.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: widget.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            "Qty:",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: widget.accentColor,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              widget.updateQuantity(
                                                product,
                                                quantity - 1,
                                              );
                                              setState(() {});
                                            },
                                          ),
                                          Text(
                                            "$quantity",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: widget.accentColor,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              widget.updateQuantity(
                                                product,
                                                quantity + 1,
                                              );
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          widget.removeFromCart(product);
                                          setState(() {});
                                        },
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: widget.accentColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal (${widget.cartItems.length} items):",
                              style: TextStyle(
                                fontSize: 16,
                                color: widget.accentColor,
                              ),
                            ),
                            Text(
                              "\$${getTotalPrice().toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.accentColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              PaymentScreen.routeName,
                              arguments: {
                                'title': 'Cart Total',
                                'price': getTotalPrice(),
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.primaryColor,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Proceed to Checkout",
                            style: TextStyle(
                              fontSize: 16,
                              color: widget.accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
