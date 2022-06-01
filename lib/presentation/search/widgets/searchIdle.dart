import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/apiObjects/apiKey.dart';
import 'package:netflix_clone/core/constsize.dart';
import 'package:netflix_clone/presentation/home/home.dart';
import 'package:netflix_clone/presentation/search/widgets/searchTitle.dart';
import 'package:shimmer/shimmer.dart';

const imageId = 'https://image.tmdb.org/t/p/original';

class SearchIdle extends StatelessWidget {
  const SearchIdle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SearchTextTitle(
            title: 'Top searches',
          ),
        ),
        cHeight,
        Expanded(
            child: FutureBuilder(
                future: HttpService().getTrending(TMDB.trendingPopular),
                builder: (context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) => TopSearchTile(
                                index: index,
                                snapshot: snapshot,
                              ),
                          separatorBuilder: (ctx, index) => cHeight,
                          itemCount: 20)
                      :  Shimmer.fromColors(child: Container( width: screenWidth * 0.38,color: Colors.grey,
          height: 80,),baseColor: Colors.grey[300]!,highlightColor:Colors.grey [500]!,);
                })),
      ],
    );
  }
}

const imageUrl =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1Rp9RlqmdU4iLc0vsM4C55-Imv9EC585pJA&usqp=CAU';

class TopSearchTile extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;
  final int index;
  TopSearchTile({Key? key, required this.index, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.38,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      imageId + snapshot.data[index].posterPath!))),
        ),
        cwidth,
        Expanded(
            child: Text(
          snapshot.data[index].title!,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        )),
        const Icon(
          CupertinoIcons.play_circle,
          size: 35,
        ),
        cwidth,
      ],
    );
  }
}
