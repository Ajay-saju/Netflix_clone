import 'package:flutter/material.dart';

ValueNotifier<int> indexChingeNotifier = ValueNotifier(0);

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChingeNotifier,
        builder: (context, int newIndex, _) {
          return BottomNavigationBar(
            selectedFontSize: 12,
            unselectedFontSize: 10,
            currentIndex: newIndex,
            onTap: (index) {
              indexChingeNotifier.value = index;
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'New & Hot', icon: Icon(Icons.video_collection_rounded)),
              BottomNavigationBarItem(
                  label: "Fast Laughs",
                  icon: Icon(Icons.emoji_emotions_outlined)),
              BottomNavigationBarItem(
                  label: 'Search', icon: Icon(Icons.search_rounded)),
              BottomNavigationBarItem(
                  label: 'Downloads',
                  icon: Icon(Icons.arrow_circle_down_rounded))
            ],
          );
        });
  }
}
