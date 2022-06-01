import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/apiObjects/apiKey.dart';
import 'package:netflix_clone/apiObjects/get_tmdb_data/get_tmdb_data.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constsize.dart';
import 'package:netflix_clone/presentation/home/home.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widget.dart';
import 'package:shimmer/shimmer.dart';

class DownloadScreen extends StatelessWidget {
  DownloadScreen({Key? key}) : super(key: key);

  // List posters = [
  //   'https://www3.pictures.zimbio.com/mp/Od8cL1OXfz_x.jpg',
  //   'https://amc-theatres-res.cloudinary.com/v1648210088/amc-cdn/production/2/movies/45900/45869/Poster/Primary_BoxCover_800_1200.jpg',
  //   'https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:oi-discovery-catalog@@icons@@like_202006280402.png,ox-24,oy-617,ow-29:q-80/et00310791-hhthysswnv-portrait.jpg'
  // ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBarWidget(
              title: 'Downloads',
            )),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Row(
                children: const [
                  Icon(
                    Icons.settings,
                  ),
                  cwidth,
                  Text(
                    'Smart downloads',
                    style: TextStyle(
                      letterSpacing: .8,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Introdusing Downloads for You',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: .7),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                'We"ll download all personalized selection of movies and shows for you, so theres always something to whatch on your divice.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: .7,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
            ),
            FutureBuilder(
              future: HttpService().getTrending(TMDB.trendingPopular),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                return snapshot.hasData
                    ? SizedBox(
                        height: 280,
                        width: 300,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: cGrey.withOpacity(0.7),
                                radius: size.width * .33,
                              ),
                            ),
                            DownloadsPoster(
                              size: Size(size.width * 0.3, size.width * 0.4),
                              posters: snapshot.data![2].posterPath!,
                              angle: 20,
                              margin:
                                  const EdgeInsets.only(left: 180, bottom: 10),
                            ),
                            DownloadsPoster(
                              size: Size(size.width * 0.3, size.width * 0.4),
                              posters: snapshot.data![1].posterPath!,
                              angle: -20,
                              margin:
                                  const EdgeInsets.only(right: 180, bottom: 10),
                            ),
                            DownloadsPoster(
                              size: Size(size.width * 0.35, size.width * 0.5),
                              posters: snapshot.data![3].posterPath!,
                              angle: 0,
                              margin: const EdgeInsets.only(top: 14),
                            ),
                          ],
                        ),
                      )
                    :  Shimmer.fromColors(child: Container(
                       height: 280,
                        width: 300,
                        color: Colors.grey,

                    ), baseColor: Colors.grey[300]!, highlightColor: Colors.grey[500]! );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: cBlue,
                onPressed: () {},
                child: const Text(
                  'Set up',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55, right: 55),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: cwhite,
                onPressed: () {},
                child: const Text(
                  'See what you can download',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: cBlack, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ));
  }
}

class DownloadsPoster extends StatelessWidget {
  const DownloadsPoster(
      {Key? key,
      required this.size,
      required this.posters,
      required this.margin,
      required this.angle})
      : super(key: key);

  final Size size;
  final String posters;
  final double angle;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        height: size.height,

        ///  * .58,
        width: size.width, // * .4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage('https://image.tmdb.org/t/p/original$posters'))),
      ),
    );
  }
}
