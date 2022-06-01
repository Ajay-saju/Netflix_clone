import 'package:flutter/material.dart';
import 'package:netflix_clone/apiObjects/apiKey.dart';
import 'package:netflix_clone/core/constsize.dart';
import 'package:netflix_clone/presentation/home/home.dart';
import 'package:netflix_clone/presentation/home/widgets/homeMovieCard2.dart';
import 'package:shimmer/shimmer.dart';

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
              :Shimmer.fromColors(child:Container( height: 190,color: Colors.grey,
      width: 110,) , baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[800]!,);
        });
  }
}
