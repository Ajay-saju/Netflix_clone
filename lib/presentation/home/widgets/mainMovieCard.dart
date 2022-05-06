import 'package:flutter/material.dart';
import 'package:netflix_clone/apiObjects/apiKey.dart';
import 'package:netflix_clone/core/constsize.dart';
import 'package:netflix_clone/presentation/home/widgets/homeMovieCard2.dart';

class NetflixMovieCardView extends StatelessWidget {
  final String api;
  const NetflixMovieCardView({
    Key? key,
    required this.api,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HttpService().getTrending(api),
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? LimitedBox(
                  maxHeight: 190,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return HomeMovieCard2(
                        index: index,
                        snapshot: snapshot,
                      );
                    },
                    separatorBuilder: (context, index) => cwidth,
                    itemCount: 20,
                  ),
                )
              : loadingText;
        });
  }
}
