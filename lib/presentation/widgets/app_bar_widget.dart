import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constsize.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key, required this.title}) : super(key: key);
  final title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
                textStyle:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
          ),
          const Spacer(),
          const Icon(
            Icons.cast,
            color: Colors.white,
          ),
          cwidth,
          Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('asset/images/ironman.jpeg'))),
          ),
        ],
      ),
    );
  }
}
