import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';

class FbNewsAttachmentsVideo extends StatefulWidget {
  final String videourl;

  @internal
  const FbNewsAttachmentsVideo({
    @required this.videourl,
  });

  @override
  _FbNewsAttachmentsVideoState createState() => _FbNewsAttachmentsVideoState();
}

class _FbNewsAttachmentsVideoState extends State<FbNewsAttachmentsVideo> {
  VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.videourl,
    )..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _controller.value.initialized
          ? _controller.value.size.height + 10
          : 50,
      width: 460,
      child: InkWell(
        child: Stack(
          children: [
            VideoPlayer(
              _controller,
            ),
            !_controller.value.isPlaying
                ? Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 100,
                      color: Theme.of(context).accentColor,
                    ),
                  )
                : Container()
          ],
        ),
        onTap: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
      ),
    );
  }
}
