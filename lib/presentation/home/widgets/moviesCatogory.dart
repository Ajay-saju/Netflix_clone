import 'package:flutter/material.dart';

class MoviesCtagory extends StatelessWidget {
  final String title;
  const MoviesCtagory({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
