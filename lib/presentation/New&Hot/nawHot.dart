import 'package:flutter/material.dart';
import 'package:netflix_clone/apiObjects/apiKey.dart';


import 'package:netflix_clone/presentation/search/widgets/searchIdle.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widget.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';

class NewAndHotScreen extends StatefulWidget {
  const NewAndHotScreen({Key? key}) : super(key: key);

  @override
  State<NewAndHotScreen> createState() => _NewAndHotScreenState();
}

class _NewAndHotScreenState extends State<NewAndHotScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(
            title: 'New & Hot',
          )),
      body: ScrollableListTabView(
        tabs: [
          ScrollableListTab(
            tab: ListTab(
              label: '🍿 Coming Soon',
              activeBackgroundColor: Colors.white,
              inactiveBackgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            body: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                    child: FutureBuilder(
                        future: HttpService().getTrending(TMDB.getUpcoming),
                        builder:
                            (context, AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            List<dynamic> list = snapshot.data!;

                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return ComingSoonWidgets(
                                    width: width,
                                    date: DateFormat('MMM')
                                        .format(
                                          DateTime.parse(
                                            '${list[index].releaseDate}',
                                          ),
                                        )
                                        .toUpperCase(),
                                    day: DateFormat('dd').format(
                                      DateTime.parse(
                                          '${list[index].releaseDate}'),
                                    ),
                                    imageURL: '${list[index].posterPath}',
                                    movieDescription: '${list[index].overview}',
                                    movieName: '${list[index].title}',
                                    comingSoonDate:
                                        'Coming On ${DateFormat('MMMM dd').format(
                                      DateTime.parse(
                                          '${list[index].releaseDate}'),
                                    )}',
                                    index: index,
                                    snapshot: snapshot,
                                  );
                                });
                          } else {
                            return  Shimmer.fromColors(child: Container(width: width,
                            height: 300,
                            color: Colors.grey,),baseColor: Colors.grey[300]!, highlightColor: Colors.grey[500]!,);
                          }
                        }))
              ],
            ),
          ),
          ScrollableListTab(
              tab: ListTab(
                borderRadius: BorderRadius.circular(30),
                label: '🔥 Everyone\'s watching',
                activeBackgroundColor: Colors.white,
                inactiveBackgroundColor: Colors.black,
              ),
              body: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                      child: FutureBuilder(
                          future:
                              HttpService().getTrending(TMDB.trendingPopular),
                          builder:
                              (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            if (snapshot.hasData) {
                              List<dynamic> list = snapshot.data!;

                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: list.length - 8,
                                  itemBuilder: (context, index) {
                                    return EveryOneWatch(
                                      width: width,
                                      date: DateFormat('MMM')
                                          .format(
                                            DateTime.parse(
                                              '${list[index + 5].releaseDate}',
                                            ),
                                          )
                                          .toUpperCase(),
                                      day: DateFormat('dd').format(
                                        DateTime.parse(
                                            '${list[index + 5].releaseDate}'),
                                      ),
                                      imageURL: '${list[index + 5].posterPath}',
                                      comingSoonDate:
                                          'Coming On ${DateFormat('MMMM dd').format(
                                        DateTime.parse(
                                            '${list[index + 5].releaseDate}'),
                                      )}',
                                      movieName: '${list[index + 5].title}',
                                      movieDescription:
                                          '${list[index + 5].overview}',
                                      index: index,
                                      snapshot: snapshot,
                                    );
                                  });
                            } else {
                              return Shimmer.fromColors(baseColor: Colors.grey[300]!, highlightColor:Colors.grey[500]!, child:Container(width: width,height: 600, color: Colors.grey,),);
                            }
                          }))
                ],
              )),
          ScrollableListTab(
              tab: ListTab(
                borderRadius: BorderRadius.circular(30),
                label: '🔟 Top 10',
                activeBackgroundColor: Colors.white,
                inactiveBackgroundColor: Colors.black,
              ),
              body: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                      child: FutureBuilder(
                          future:
                              HttpService().getTrending(TMDB.trendingPopular),
                          builder: (context, AsyncSnapshot snapshot) {
                            return snapshot.hasData
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return TopTen(
                                        width: width,
                                        date: snapshot.data[index].releaseDate,
                                        index: index,
                                        day: snapshot.data[index].releaseDate,
                                        imageURL: imageId +
                                            snapshot.data[index].posterPath,
                                        comingSoonDate: 'vjhkj',
                                        movieName: snapshot.data[index].title,
                                        movieDescription:
                                            snapshot.data[index].overview,
                                        snapshot: snapshot,
                                      );
                                    })
                                : Shimmer.fromColors(child: Container(width: width,color: Colors.grey,), baseColor: Colors.grey[300]!, highlightColor: Colors.grey[500]!);
                          }))
                ],
              )),
        ],
      ),
    );
  }
}

class ComingSoonWidgets extends StatelessWidget {
  const ComingSoonWidgets({
    Key? key,
    required this.width,
    required this.date,
    required this.day,
    required this.imageURL,
    required this.comingSoonDate,
    required this.movieName,
    required this.movieDescription,
    required this.snapshot,
    required this.index,
  }) : super(key: key);
  final AsyncSnapshot snapshot;
  final int index;
  final double width;
  final String date;
  final String day;
  final String imageURL;
  final String comingSoonDate;
  final String movieName;
  final String movieDescription;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                day,
                style: const TextStyle(
                  fontSize: 30,
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: width - 55,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          imageId + snapshot.data[index].posterPath!,
                        ),
                      ),
                    ),
                    width: double.infinity,
                    height: 180,
                  ),
                  const Positioned(
                    right: 20,
                    top: 150,
                    child: Icon(
                      Icons.volume_off_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(),
                  VideoListAvatarButton(
                    icon: Icons.add_alert_outlined,
                    title: 'Remind Me',
                    onPressed: () {},
                  ),
                  VideoListAvatarButton(
                    icon: Icons.info_outline,
                    title: 'Info',
                    onPressed: () {},
                  ),
                ],
              ),
              // kVerticalSpace,
              Text(
                comingSoonDate,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                movieName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        movieDescription,
                        style: const TextStyle(
                            overflow: TextOverflow.fade, color: Colors.grey),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class EveryOneWatch extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;
  const EveryOneWatch({
    Key? key,
    required this.width,
    required this.date,
    required this.day,
    required this.imageURL,
    required this.comingSoonDate,
    required this.movieName,
    required this.movieDescription,
    required this.snapshot,
    required this.index,
  }) : super(key: key);

  final double width;
  final String date;
  final String day;
  final String imageURL;
  final String comingSoonDate;
  final String movieName;
  final String movieDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: width - 20,
            height: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            imageId + snapshot.data[index].posterPath!,
                          ),
                        ),
                      ),
                      width: double.infinity,
                      height: 180,
                    ),
                    const Positioned(
                      right: 20,
                      top: 150,
                      child: Icon(
                        Icons.volume_off_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    VideoListAvatarButton(
                      icon: Icons.send,
                      title: 'Share',
                      onPressed: () {},
                    ),
                    VideoListAvatarButton(
                      icon: Icons.add,
                      title: 'My List',
                      onPressed: () {},
                    ),
                    VideoListAvatarButton(
                      icon: Icons.play_arrow,
                      title: 'Play',
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  movieName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          movieDescription,
                          style: const TextStyle(
                              overflow: TextOverflow.fade,
                              color: Colors.white70),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopTen extends StatelessWidget {
  const TopTen({
    Key? key,
    required this.width,
    required this.date,
    required this.index,
    required this.day,
    required this.imageURL,
    required this.comingSoonDate,
    required this.movieName,
    required this.movieDescription,
    required this.snapshot,
  }) : super(key: key);
  final AsyncSnapshot snapshot;
  final int index;
  final double width;
  final String date;
  final String day;
  final String imageURL;
  final String comingSoonDate;
  final String movieName;
  final String movieDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  (index + 1).toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width - 75,
            height: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            imageId + snapshot.data[index].posterPath!,
                          ),
                        ),
                      ),
                      width: double.infinity,
                      height: 180,
                    ),
                    const Positioned(
                      right: 20,
                      top: 150,
                      child: Icon(
                        Icons.volume_off_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    VideoListAvatarButton(
                      icon: Icons.send,
                      title: 'Share',
                      onPressed: () {},
                    ),
                    VideoListAvatarButton(
                      icon: Icons.add,
                      title: 'My List',
                      onPressed: () {},
                    ),
                    VideoListAvatarButton(
                      icon: Icons.play_arrow,
                      title: 'Play',
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  movieName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          movieDescription,
                          style: const TextStyle(
                              overflow: TextOverflow.fade,
                              color: Colors.white70),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoListAvatarButton extends StatelessWidget {
  const VideoListAvatarButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        children: [
          IconButton(
            icon: Icon(icon),
            color: Colors.white,
            onPressed: onPressed,
            iconSize: 30,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

const imageForHotAndNew =
    'https://i.ytimg.com/vi/B_kz4Ty9JUg/maxresdefault.jpg';
