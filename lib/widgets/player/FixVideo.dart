import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FixVideo extends StatefulWidget {
  const FixVideo({super.key});

  @override
  State<FixVideo> createState() => _FixVideoState();
}

class _FixVideoState extends State<FixVideo> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/videos/test2.mp4')
      ..setLooping(true) // ✅ Ensures the video loops
      ..initialize().then((_) {
        controller.play(); // ✅ Start playing after initialization
        setState(() {}); // ✅ Ensure UI updates after video loads
      });
  }

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? Container(
          height: 700,
          width: 300,
          child: AspectRatio(
              aspectRatio: 9/16,
              child: VideoPlayer(controller),
            ),
        )
        : CircularProgressIndicator();
  }
}
