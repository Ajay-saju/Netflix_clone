import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constsize.dart';
import 'package:video_player/video_player.dart';

class VedioListItem extends StatefulWidget {
  final int index;
  final String uri;
  const VedioListItem({Key? key, required this.index, required this.uri})
      : super(key: key);

  @override
  State<VedioListItem> createState() => _VedioListItemState();
}

class _VedioListItemState extends State<VedioListItem> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.uri);
    _controller.initialize().then((_) {
      _controller.play().then((value) => _controller.setLooping(true));
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),

        //leftSide
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.volume_off_outlined),
                ),
              ),
            ],
          ),
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://www3.pictures.zimbio.com/mp/Od8cL1OXfz_x.jpg'),
                ),
                cheight40,
                VedioActionWidget(
                  icon: Icons.emoji_emotions_rounded,
                  title: 'LOL',
                ),
                cheight40,
                VedioActionWidget(
                  icon: Icons.add,
                  title: 'My List',
                ),
                cheight40,
                VedioActionWidget(
                  title: 'Share',
                  icon: Icons.telegram,
                ),
                cheight40,
                VedioActionWidget(title: 'Play', icon: Icons.play_arrow_rounded)
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class VedioActionWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const VedioActionWidget({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 35,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey[800]),
        ),
      ],
    );
  }
}
