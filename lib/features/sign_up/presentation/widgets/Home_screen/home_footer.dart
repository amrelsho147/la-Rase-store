import 'package:flutter/material.dart';

class HomeFooter extends StatelessWidget {
  final Color accentColor;
  final Color backgroundColor;

  const HomeFooter({required this.accentColor, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.facebook, color: accentColor),
                onPressed: () {},
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "©️ 2025 La Rase Store",
            style: TextStyle(fontSize: 12, color: accentColor),
          ),
        ],
      ),
    );
  }
}
