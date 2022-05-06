import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/presentation/search/widgets/searchIdle.dart';

const gridImages =
    'https://www.filmjabber.com/movie-poster-thumbs/i-want-you-back-movie-poster-6859.jpg';

class HomeMovieCard extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;
  final int index;
  const HomeMovieCard({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: Colors.transparent.withOpacity(0.5),
              child: const Icon(
                Icons.play_arrow,
                color: cwhite,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 33,
          child: SizedBox(
              width: 110,
              child: LinearProgressIndicator(
                value: 0.35,
                color: Colors.red,
              )),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(5),
            width: 110,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 50, 50, 50),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(
                  Icons.info_outline,
                  color: Color.fromARGB(255, 131, 131, 131),
                ),
                Icon(
                  Icons.more_vert_rounded,
                  color: Color.fromARGB(255, 131, 131, 131),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
