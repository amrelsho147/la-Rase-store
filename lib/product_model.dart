class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name']?.toString() ?? 'Unknown');
  }
}

class Product {
  final String id;
  final String title;
  final String imageCover;
  final double price;
  final double? priceAfterDiscount;
  final Category category;
  final double ratingsAverage;
  final String? description;

  Product({
    required this.id,
    required this.title,
    required this.imageCover,
    required this.price,
    this.priceAfterDiscount,
    required this.category,
    required this.ratingsAverage,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      imageCover: json['imageCover']?.toString() ?? '',
      price:
          (json['price'] as num?)?.toDouble() ??
          (json['priceAfterDiscount'] as num?)?.toDouble() ??
          0.0,
      priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toDouble(),
      category: Category.fromJson(json['category'] ?? {'name': 'Unknown'}),
      ratingsAverage: (json['ratingsAverage'] as num?)?.toDouble() ?? 0.0,
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageCover': imageCover,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'category': {'name': category.name},
      'ratingsAverage': ratingsAverage,
      'description': description,
    };
  }
}

class ProductsResponse {
  final List<Product> products;

  ProductsResponse({required this.products});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<Product> products =
        productList.map((i) => Product.fromJson(i)).toList();
    return ProductsResponse(products: products);
  }
}