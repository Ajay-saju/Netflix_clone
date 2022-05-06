import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/apiObjects/apiKey.dart';
import 'package:netflix_clone/core/colors/colors.dart';

import 'package:netflix_clone/core/constsize.dart';
import 'package:netflix_clone/presentation/search/widgets/searchIdle.dart';

const gridImages2 =
    'https://igimages.gumlet.io/tamil/gallery/movies/thalapathy64/poster1.jpg?w=160&dpr=2.6';

class NetflixMovieNumberCardView extends StatelessWidget {
  const NetflixMovieNumberCardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HttpService().getTrending(TMDB.trendingPopular),
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? LimitedBox(
                  maxHeight: 190,
                  child: Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return HomeMovieNumberCard(
                          index: index,
                          snapshot: snapshot,
                        );
                      },
                      separatorBuilder: (context, index) => cwidth,
                      itemCount: 10,
                    ),
                  ),
                )
              : loadingText;
        });
  }
}

class HomeMovieNumberCard extends StatelessWidget {
  final int index;
  final AsyncSnapshot<dynamic> snapshot;

  const HomeMovieNumberCard({
    Key? key,
    required this.index,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 35,
            ),
            Container(
              height: 190,
              width: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          imageId + snapshot.data[index].posterPath!))),
            ),
          ],
        ),
        Positioned(
          top: 75,
          bottom: 0,
          child: BorderedText(
            strokeColor: cwhite,
            strokeWidth: 3.0,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
