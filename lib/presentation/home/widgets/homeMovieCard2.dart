import 'package:flutter/material.dart';
import 'package:netflix_clone/presentation/search/widgets/searchIdle.dart';

const gridImages =
    'https://5.imimg.com/data5/CO/IP/MQ/SELLER-30220222/bollywood-wall-poster-500x500.jpg';

class HomeMovieCard2 extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;
  final int index;
  const HomeMovieCard2({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 110,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageId + snapshot.data[index].posterPath!))),
    );
  }
}
