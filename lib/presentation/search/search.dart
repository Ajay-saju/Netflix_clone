import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constsize.dart';
import 'package:netflix_clone/presentation/search/widgets/searchIdle.dart';
import 'package:netflix_clone/presentation/search/widgets/searchResultWidget.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool valueOf = true;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSearchTextField(
                  onSuffixTap: () {
                    setState(() {
                      valueOf =true; 
                    });
                    
                  },
                  onSubmitted: (value) {
                    setState(() {
                      valueOf = false;
                    });
                  },
                  style: const TextStyle(color: cwhite),
                  backgroundColor: Colors.grey[900],
                  prefixIcon: const Icon(CupertinoIcons.search),
                  suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill),
                ),
              ),
              valueOf
                  ? const Expanded(child: SearchIdle())
                  : const Expanded(child: SearchResultWidget())
            ],
          ),
        ),
      ),
    );
  }
}
