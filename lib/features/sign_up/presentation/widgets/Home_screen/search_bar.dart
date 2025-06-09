import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Color accentColor;
  final Color primaryColor;
  final Function(String)? onSearch;

  const SearchBarWidget({
    Key? key,
    required this.accentColor,
    required this.primaryColor,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: "Search for bags...",
          prefixIcon: Icon(Icons.search, color: accentColor),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
      ),
    );
  }
}
