import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:zeppe_learn/components/common/appButton.dart';
import 'package:zeppe_learn/widgets/home/quizz_appbar.dart';
import 'package:zeppe_learn/widgets/player/VideoDemo.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({super.key});

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  late VideoPlayerController _controller;
  bool fullScreenMode = false;
  bool expandedVideo = false;
  bool active = false;
  int timeLeft = 5;
  Timer? activeTimer;
  double videoSpeed = 1.0; // ✅ Default Speed
  bool showSpeedMenu = false;
  

  /// ✅ Close the speed selection after timeout
  void closeActive() {
    activeTimer?.cancel();
    setState(() {
      active = false;
      timeLeft = 0;
    });
  }

  void toggleShowSpeedMenu(){
    setState((){
      showSpeedMenu = !showSpeedMenu;
    });
  }

  /// ✅ Show speed selection & start countdown
  void openActive() {
    setState(() {
      active = true;
      timeLeft = 3;
    });

    // Cancel previous timer if any
    activeTimer?.cancel();

    activeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        closeActive();
      }
    });
  }

  /// ✅ Change the video speed
  void changeSpeed(double speed) {
    setState(() {
      videoSpeed = speed;
    });
    _controller.setPlaybackSpeed(speed);
  }

  /// ✅ Toggle expanded video mode
  void toggleExpanded() {
    setState(() {
      expandedVideo = !expandedVideo;
    });
  }

  /// ✅ Toggle FullScreen Mode
  void toggleFullScreen() async {
    setState(() {
      fullScreenMode = !fullScreenMode;
    });

    if (fullScreenMode) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      setState(() {
        expandedVideo = true;
      });
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      setState(() {
        expandedVideo = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // ✅ Initialize Video Player
    _controller = VideoPlayerController.asset('assets/videos/test.mp4')
      ..setLooping(true)
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });

    setLandScape();
  }

  Future setLandScape() async {
    if (fullScreenMode) {
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    activeTimer?.cancel(); // ✅ Cancel timer when leaving
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          (!expandedVideo && !fullScreenMode) ? Colors.white : Colors.black,
      appBar: expandedVideo ? null : quizzAppBar(context, 3, 3),
      body: Stack(
        children: [
          if (_controller.value.isInitialized)
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200), // ✅ Smooth Transition
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: expandedVideo
                  ? Positioned(
                      key: ValueKey<bool>(expandedVideo),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.black,
                        child: Videodemo(
                          fullScreenMode: fullScreenMode,
                          expandedVideo: expandedVideo,
                          controller: _controller,
                          onToggleLandscape: toggleFullScreen,
                          onToggleExpanded: toggleExpanded,
                          onOpenActive: openActive,
                          onToggleShowSpeedMenu: toggleShowSpeedMenu,
                          onCloseActive: closeActive,
                          active: active,
                        ),
                      ),
                    )
                  : Padding(
                      key: ValueKey<bool>(!expandedVideo),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24),
                          Text(
                            "The consumer paid 7200 Rs in tax.\n Who gets this tax?",
                            style: const TextStyle(
                              fontSize: 19,
                              fontFamily: 'Circular Std',
                              fontWeight: FontWeight.w700,
                              color: Color(0xff061720),
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: [
                              Center(
                                child: Videodemo(
                                  fullScreenMode: fullScreenMode,
                                  expandedVideo: expandedVideo,
                                  controller: _controller,
                                  onToggleLandscape: toggleFullScreen,
                                  onToggleExpanded: toggleExpanded,
                                  onOpenActive: openActive,
                                  onToggleShowSpeedMenu: toggleShowSpeedMenu,
                                  onCloseActive: closeActive,
                                  active: active,
                                ),
                              ),
                              if (!expandedVideo && !fullScreenMode)
                                Visibility(
                                  visible: showSpeedMenu,
                                  child: buildSpeedSelector(),
                                ),

                            ],
                          ),
                        ],
                      ),
                    ),
            ),
        ],
      ),
      bottomNavigationBar: fullScreenMode ? null : quizzBottomBar(context, false),
    );
  }

  /// ✅ Speed Selector Widget
  Widget buildSpeedSelector() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(77),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      speedCard(0.5, "0.5x"),
                      SizedBox(width: 10),
                      speedCard(1.0, "1.0x"),
                      SizedBox(width: 10),
                      speedCard(1.25, "1.25x"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      speedCard(1.5, "1.5x"),
                      SizedBox(width: 10),
                      speedCard(1.75, "1.75x"),
                      SizedBox(width: 10),
                      speedCard(2.0, "2.0x"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  /// ✅ Speed Card Widget
  Widget speedCard(double speed, String label) => GestureDetector(
        onTap: () {
          changeSpeed(speed);
        },
        child: Container(
          height: 37,
          decoration: BoxDecoration(
            color: videoSpeed == speed
                ? Colors.blue // ✅ Highlight Selected Speed
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: 8.78, vertical: 2.78),
          child: Row(
            children: [
              Icon(Icons.fast_forward, size: 18, color: Colors.black),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: videoSpeed == speed ? Colors.white : Colors.black,
                  fontFamily: "Inter Display",
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      );
}


Widget  quizzBottomBar(
      BuildContext context, bool isLastQuestion) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16 + MediaQuery.of(context).padding.bottom,
        top: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D676514),
            offset: Offset(0, -4),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          AppButton(
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            textContent: "?",
            buttonWidth: 57,
            textColor: Color(0xFF061720),
            buttonColor: Color(0xffEBF1F5),
            borderColor: Color(0xffD6E0E7),
            borderWidth: 6,
            onPressed: () => {},
          ),
          SizedBox(width: 10),
          Expanded(
            child: AppButton(
              // isDisabled: (selectedOption == null),
              fontWeight: FontWeight.w500,
              letterSpacing: -2,
              textContent:"Submit",
                  // : (selectedOption == null) ? "Continue" : "Check",
              textColor: Colors.white,
              buttonColor:  Color(0xff0088FF),
                  // : (selectedOption != null ? Color(0xff0088FF) : Color.fromARGB(255, 196, 220, 241)),
              borderColor: Color(0xff0061B5),
                  // : (selectedOption != null ? Color(0xff0061B5) : Color.fromARGB(255, 196, 220, 241)),
              borderWidth: 6,
              onPressed: () async {
                
              },
            ),
          ),
        ],
      ),
    );
  }