// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    super.key,
    required this.text,
    required this.onPressed, // Add onPressed as a required parameter
  });

  final String text;
  final VoidCallback onPressed; // Define the onPressed type correctly
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        TextButton(
          onPressed: onPressed, // Pass the function reference
          child: const Text('View All'),
        ),
      ],
    );
  }
}
