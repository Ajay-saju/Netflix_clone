import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatagoriesPage extends StatelessWidget {
  final bool isCategory;
  CatagoriesPage({Key? key, required this.isCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: isCategory
            ? const EdgeInsets.only(bottom: 15)
            : const EdgeInsets.only(top: 300, bottom: 20),
        insetAnimationDuration: const Duration(seconds: 1),
        insetAnimationCurve: Curves.easeIn,
        elevation: 0,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        isCategory ? categoryList.length : homeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          isCategory ? categoryList[index] : homeList[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: (isCategory == false && index == 2)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Icon(
                    CupertinoIcons.xmark,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> categoryList = [
    'Home',
    'My List',
    'Available for Download',
    'Hindi',
    'Tamil',
    'Punjabi',
    'Telugu',
    'Malayalam',
    'Marathi',
    'Bengali',
    'English',
    'Action',
    'Anime',
    'Award Winners',
    'Biographical',
    'Bollywood',
    'Blockbusters',
    'Children & Family',
    'Comedies',
    'Documentaries',
    'Dramas',
    'Fantasy',
    'Hollywood',
    'Horror',
    'International',
    'Indian',
    'Music & Musicals',
    'Reality & Talk',
    'Romance',
    'Sci-Fi',
    'Stand-up',
    'Thrillers',
  ];

  final List<String> homeList = ['Home', 'TV Shows', 'Movies'];
}
