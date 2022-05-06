import 'package:flutter/material.dart';

import 'package:netflix_clone/presentation/New&Hot/nawHot.dart';
import 'package:netflix_clone/presentation/downloads/downloads.dart';

import 'package:netflix_clone/presentation/fastLaugh/fastLaugh.dart';
import 'package:netflix_clone/presentation/home/home.dart';
import 'package:netflix_clone/presentation/mainpage/widgets/bottom_navbar.dart';
import 'package:netflix_clone/presentation/search/search.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({Key? key}) : super(key: key);

  final _pages = [
    HomeScreen(),
    const NewAndHotScreen(),
    const FastLaughScreen(),
    const SearchScreen(),
    DownloadScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChingeNotifier,
          builder: (context, int value, child) {
            return _pages[value];
          },
        ),
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}
