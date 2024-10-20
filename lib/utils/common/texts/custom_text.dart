// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
 

  const CustomText({
    super.key,
    required this.text,
    required this.size,
    this.color = Colors.black,
 
  });


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize:  16, fontWeight:  FontWeight.normal),
    );
  }
}
