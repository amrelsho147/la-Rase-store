import 'package:flutter/cupertino.dart';

import '../../../../../../product_model.dart';
import '../discounted_slider.dart';
import '../featured_products_horizontal_scroll.dart';
import '../home_footer.dart';
import '../search_bar.dart';

class HomeTap extends StatefulWidget {
  final List<Product> discountedProducts;
  final List<Product> featuredProducts;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final List<Map<String, dynamic>> wishlistItems;
  final Function(Map<String, dynamic>) addToWishlist;
  final Function(Map<String, dynamic>) removeFromWishlist;
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) addToCart;
  final Function(Map<String, dynamic>) removeFromCart;
  final Function(Map<String, dynamic>, int) updateQuantity;

  const HomeTap({
    Key? key,
    required this.discountedProducts,
    required this.featuredProducts,
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.wishlistItems,
    required this.addToWishlist,
    required this.removeFromWishlist,
    required this.cartItems,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateQuantity,
  }) : super(key: key);

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  List<Product> filteredDiscountedProducts = [];
  List<Product> filteredFeaturedProducts = [];

  @override
  void initState() {
    super.initState();
    filteredDiscountedProducts = widget.discountedProducts;
    filteredFeaturedProducts = widget.featuredProducts;
  }

  void _filterProducts(String query) {
    setState(() {
      filteredDiscountedProducts =
          widget.discountedProducts
              .where(
                (product) =>
                    product.title.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
      filteredFeaturedProducts =
          widget.featuredProducts
              .where(
                (product) =>
                    product.title.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('homeScrollView'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBarWidget(
            accentColor: widget.accentColor,
            primaryColor: widget.primaryColor,
            onSearch: _filterProducts,
          ),
          DiscountedSlider(
            discountedProducts:
                filteredDiscountedProducts
                    .map(
                      (p) => {
                        'title': p.title,
                        'imageUrl': p.imageCover,
                        'originalPrice': p.price,
                        'discountedPrice': p.priceAfterDiscount ?? p.price,
                        'description': p.description,
                      },
                    )
                    .toList(),
            primaryColor: widget.primaryColor,
            accentColor: widget.accentColor,
            wishlistItems: widget.wishlistItems,
            addToWishlist: widget.addToWishlist,
            removeFromWishlist: widget.removeFromWishlist,
            cartItems: widget.cartItems,
            addToCart: widget.addToCart,
            removeFromCart: widget.removeFromCart,
            updateQuantity: widget.updateQuantity,
          ),
          FeaturedProductsHorizontalScroll(
            featuredProducts:
                filteredFeaturedProducts
                    .map(
                      (p) => {
                        'title': p.title,
                        'imageUrl': p.imageCover,
                        'price': p.price,
                        'description': p.description,
                      },
                    )
                    .toList(),
            primaryColor: widget.primaryColor,
            accentColor: widget.accentColor,
            wishlistItems: widget.wishlistItems,
            addToWishlist: widget.addToWishlist,
            removeFromWishlist: widget.removeFromWishlist,
            cartItems: widget.cartItems,
            addToCart: widget.addToCart,
            removeFromCart: widget.removeFromCart,
            updateQuantity: widget.updateQuantity,
          ),
          HomeFooter(
            accentColor: widget.accentColor,
            backgroundColor: widget.backgroundColor,
          ),
        ],
      ),
    );
  }
}
