// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

/// Only for internal use of flutter_fb_news
class FbNewsAttachmentsVideo extends StatefulWidget {
  /// Only for internal use of flutter_fb_news
  final String videourl;

  const FbNewsAttachmentsVideo({
    @required this.videourl,
  });

  @override
  _FbNewsAttachmentsVideoState createState() => _FbNewsAttachmentsVideoState();
}

class _FbNewsAttachmentsVideoState extends State<FbNewsAttachmentsVideo> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  Future<void> initPlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
      widget.videourl,
    );
    await _videoPlayerController1.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: true,
      allowFullScreen: false,
      showControls: true,
      customControls: MaterialControls(),
      autoInitialize: false,
    );

    await _chewieController.videoPlayerController.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _chewieController != null
          ? _chewieController.videoPlayerController.value.size.height
          : null,
      child: _chewieController != null &&
              _chewieController.videoPlayerController.value.isInitialized
          ? Chewie(
              controller: _chewieController,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
    );
  }
}
