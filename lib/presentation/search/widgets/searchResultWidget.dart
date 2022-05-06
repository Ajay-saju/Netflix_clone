import 'package:flutter/material.dart';
import 'package:netflix_clone/apiObjects/apiKey.dart';
import 'package:netflix_clone/core/constsize.dart';
import 'package:netflix_clone/presentation/search/widgets/searchIdle.dart';
import 'package:netflix_clone/presentation/search/widgets/searchTitle.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SearchTextTitle(
            title: 'Movies & Tv',
          ),
        ),
        cHeight,
        Expanded(
            child: FutureBuilder(
                future: HttpService().getTrending(TMDB.topRated),
                builder: (context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? GridView.count(
                          shrinkWrap: true,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: .8 / 1.3,
                          children: List.generate(40, (index) {
                            return MovieCard(
                              index: index,
                              snapshot: snapshot,
                            );
                          }),
                          crossAxisCount: 3)
                      : loadingText;
                }))
      ],
    );
  }
}

const gridImage =
    'http://www.boxofficemovies.in/now/wp-content/uploads/new-poster-of-Nawazuddins-most-awaited-Manjhi.jpg';

class MovieCard extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;
  final int index;
  const MovieCard({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageId + snapshot.data[index].posterPath!))),
    );
  }
}
