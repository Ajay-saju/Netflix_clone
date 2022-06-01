import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/apiObjects/apiKey.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constsize.dart';
import 'package:netflix_clone/presentation/home/widgets/catagoriesPage.dart';
import 'package:netflix_clone/presentation/home/widgets/homeMovieCard.dart';

import 'package:netflix_clone/presentation/home/widgets/mainMovieCard.dart';
import 'package:netflix_clone/presentation/home/widgets/movieNumberCard.dart';

import 'package:netflix_clone/presentation/home/widgets/moviesCatogory.dart';
import 'package:netflix_clone/presentation/home/widgets/moviespage.dart';
import 'package:netflix_clone/presentation/search/widgets/searchIdle.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {

  bool change = true;
  ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: scrollNotifier,
      builder: (context, index, _) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            if (direction == ScrollDirection.reverse) {
              scrollNotifier.value = false;
            } else if (direction == ScrollDirection.forward) {
              scrollNotifier.value = true;
            }

            return true;
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          FutureBuilder(
                              future: HttpService()
                                  .getTrending(TMDB.trendingPopular),
                              builder: (context,
                                  AsyncSnapshot<List<dynamic>> snapshot) {
                                return snapshot.hasData
                                    ? Container(
                                        height: 500,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(imageId +
                                                    snapshot.data![0]
                                                        .posterPath!))),
                                      )
                                    :  Shimmer.fromColors(child:Container(
                                      color: Colors.grey,
                                      height: 500,
                                        width: double.infinity,
                                    ) ,   baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[800]!,);
                              }),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.transparent,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0,
                                          2.0), // shadow direction: bottom right
                                    )
                                  ],
                                  gradient: LinearGradient(
                                      end: Alignment.topCenter,
                                      begin: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.transparent
                                      ])
                                  // color: Colors.black.withOpacity(0.5),
                                  ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const MainCardIcon(
                                    icon: Icons.add,
                                    string: 'My List',
                                  ),
                                  Container(
                                    height: 33,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: cwhite,
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Icon(
                                            Icons.play_arrow_rounded,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            'Play',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const MainCardIcon(
                                    icon: Icons.info_outline_rounded,
                                    string: 'Info',
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      cHeight20,
                      const MoviesCtagory(
                        title: 'Continueenig whaching for Ajay S U',
                      ),
                      cHeight,
                      const MovieCardWithPlayButton(),
                      cHeight20,
                      const MoviesCtagory(title: 'Popular on Netflix'),
                      cHeight,
                      const NetflixMovieCardView(
                        api: TMDB.topRated,
                      ),
                      cHeight20,
                      const MoviesCtagory(title: 'Trending Now'),
                      cHeight,
                      const NetflixMovieCardView(
                        api: TMDB.getUpcoming,
                      ),
                      cHeight20,
                      const MoviesCtagory(title: 'Tv Show Based on Show'),
                      cHeight,
                      const NetflixMovieCardView(
                        api: TMDB.nowPlaying,
                      ),
                      cHeight20,
                      const MoviesCtagory(title: 'TOp 10 in India today'),
                      const NetflixMovieNumberCardView(),
                      cHeight20,
                      const MoviesCtagory(title: 'Up Coming'),
                      const NetflixMovieCardView(
                        api: TMDB.getUpcoming,
                      ),
                    ],
                  ),
                )),
              ),
              scrollNotifier.value == true
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent])
                          // color: Colors.black.withOpacity(0.5),
                          ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.network(
                                  'https://cdn.vox-cdn.com/thumbor/AwKSiDyDnwy_qoVdLPyoRPUPo00=/39x0:3111x2048/1400x1400/filters:focal(39x0:3111x2048):format(png)/cdn.vox-cdn.com/uploads/chorus_image/image/49901753/netflixlogo.0.0.png',
                                  height: 60,
                                  width: 48,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  color: Colors.white,
                                ),
                                cwidth,
                                Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'asset/images/ironman.jpeg'))),
                                  height: 30,
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                          change
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Tv Shows',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: cwhite),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            change = false;
                                          });
                                        },
                                        child: const Text(
                                          'Movies',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: cwhite),
                                        )),
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) =>
                                                    CatagoriesPage(
                                                        isCategory: true));
                                          },
                                          child: const Text(
                                            'Catagories',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: cwhite),
                                          ),
                                        ),
                                        const Icon(
                                            Icons.arrow_drop_down_rounded),
                                      ],
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (ctx) =>
                                                      const MoviesPage());
                                            },
                                            child: const Text(
                                              'Movies',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: cwhite),
                                            )),
                                        const Icon(
                                            Icons.arrow_drop_down_rounded),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) =>
                                                    CatagoriesPage(
                                                        isCategory: true));
                                          },
                                          child: const Text(
                                            'Catagories',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: cwhite),
                                          ),
                                        ),
                                        const Icon(
                                            Icons.arrow_drop_down_rounded),
                                      ],
                                    )
                                  ],
                                )
                        ],
                      ),
                      height: 125,
                      width: double.infinity,
                    )
                  : cHeight
            ],
          ),
        );
      },
    ));
  }
}

// class ShimmerWidget extends StatelessWidget {
//   const ShimmerWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 200.0,
//       height: 100.0,
//       child: Shimmer.fromColors(
//         baseColor: Colors.red,
//         highlightColor: Colors.yellow,
//         child: const Text(
//           '',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 40.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

class MainCardIcon extends StatelessWidget {
  final IconData icon;
  final String string;
  const MainCardIcon({
    Key? key,
    required this.icon,
    required this.string,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          icon,
          size: 28,
        ),
        Text(
          string,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class MovieCardWithPlayButton extends StatelessWidget {
  const MovieCardWithPlayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 190,
      child: FutureBuilder(
          future: HttpService().getTrending(TMDB.nowPlaying),
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return HomeMovieCard(
                        index: index,
                        snapshot: snapshot,
                      );
                    },
                    separatorBuilder: (context, index) => cwidth,
                    itemCount: 20,
                  )
                : 
                CustomShimmer();
          }),
    );
  }
}

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: 190,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
              );
            },
            separatorBuilder: (context, index) => cwidth,
            itemCount: 20),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[500]!,
      );
  }
}
