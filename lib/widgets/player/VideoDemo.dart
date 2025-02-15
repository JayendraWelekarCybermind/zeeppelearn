import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class Videodemo extends StatefulWidget {
  final bool fullScreenMode;
  final bool expandedVideo;
  final VoidCallback onToggleExpanded;
  final VoidCallback onToggleLandscape;
  // final VoidCallback onToggleActive;
  final VoidCallback onOpenActive;
  final VoidCallback onCloseActive;
  final VideoPlayerController controller;
  final onToggleShowSpeedMenu;
  final bool active;

  const Videodemo(
      {Key? key,
      required this.fullScreenMode,
      required this.expandedVideo,
      required this.onToggleExpanded,
      required this.onOpenActive,
      required this.onCloseActive,
      required this.controller,
      required this.onToggleLandscape,
      required this.onToggleShowSpeedMenu,
      required this.active
    });

  @override
  State<Videodemo> createState() => _VideodemoState();
}

class _VideodemoState extends State<Videodemo> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        !this.widget.expandedVideo
            ? buildVideoPlayer()
            : buildVideoFullScreenPlayer(),
      ],
    );
  }

  Widget buildBlackShadow() => Positioned.fill(
          child: GestureDetector(
            onTap: (()=>{
              
              widget.onCloseActive()
            }),
            child: Stack(
                    children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: Colors.black
                    .withAlpha(100), // ✅ Adjust opacity for shadow effect
              ),
            ),
            buildPlayPauseButton(),
            buildBottomVideoBar(),
            buildLandscapeButton(),
                    ],
                  ),
          ));


   Widget buildLandscapeButton() => Positioned.fill(
        child: Align(
          alignment: Alignment.topRight, // ✅ Centered inside the stack
          child: GestureDetector(
            onTap: () {
              widget.onToggleLandscape();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                          'assets/images/landscape.png',
                          height: 40,
                          width: 40,
                        ),
            ),
          
          ),
        ),
      );


  Widget buildPlayPauseButton() => Positioned.fill(
        child: Align(
          alignment: Alignment.center, // ✅ Centered inside the stack
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (this.widget.controller.value.isPlaying) {
                  this.widget.controller.pause();
                } else {
                  this.widget.controller.play();
                }
              });
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xff000000).withAlpha(300)),
              child: Center(
                child: this.widget.controller.value.isPlaying
                    ? Image.asset(
                        'assets/images/pause.png',
                        height: 18,
                        width: 15,
                      )
                    : Image.asset(
                        'assets/images/play.png',
                        color: Colors.white,
                        height: 18,
                        width: 15,
                      ),
                // child: Padding(
                //   padding: EdgeInsets.all(14),
                // ),
              ),
            ),
            // child:!this.widget.controller.value.isPlaying
            //     ? SizedBox() // Hide button when playing
            //     : Image.asset(
            //         'assets/images/play.png',
            //         scale: 1.5,
            //       ),
          ),
        ),
      );

  Widget buildBottomVideoBar() => this.widget.controller.value.isInitialized
      ? Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * (0.9),
              child: Row(
                children: [
                  Expanded(child: buildProgressBar()),
                  if (!widget.fullScreenMode)
                    GestureDetector(
                      onTap: (){
                        widget.onToggleShowSpeedMenu();
                      },
                      child: Image.asset(
                        'assets/images/speed.png',
                        scale: 1.5,
                      ),
                    ),
                  if (!widget.fullScreenMode)
                    GestureDetector(
                      onTap: () {
                        widget.onToggleExpanded();
                      },
                      child: Image.asset(
                        'assets/images/fullScreen.png',
                        scale: 1.5,
                      ),
                    )
                ],
              ),
            ),
          ),
        )
      : const SizedBox(); // Hide if not initialized

  /// ✅ Video Progress Bar
  Widget buildProgressBar() => this.widget.controller.value.isInitialized
      ? ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 10.0,
            width: 225,
            child: VideoProgressIndicator(
              this.widget.controller,
              padding: EdgeInsets.all(0),
              allowScrubbing: true, // ✅ Allow user to seek
              colors: VideoProgressColors(
                playedColor: Colors.blue, // Change color of progress
                // bufferedColor: Colors.grey, // Change color of buffered progress
                backgroundColor: Colors.grey, // Change background color
              ),
            ),
          ),
        )
      : const SizedBox(); // Hide if not initialized

  Widget buildVideoPlayer() => Center(
          child: Stack(
        children: [
          this.widget.controller.value.isInitialized
              ? GestureDetector(
                  onTap: ((){
                    widget.onOpenActive();
                  }),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(11), // ✅ Rounded Corners
                    child: Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // ✅ Full screen width
                      height: 215, // ✅ Fixed height
                      decoration: BoxDecoration(
                        color: Colors.black, // Optional: Background color
                      ),
                      child: FittedBox(
                        fit: BoxFit
                            .cover, // ✅ Maintain aspect ratio & clip extra parts
                        child: SizedBox(
                          width: this.widget.controller.value.size.width,
                          height: this.widget.controller.value.size.height,
                          child: AspectRatio(
                            aspectRatio: this.widget.controller.value.aspectRatio,
                            child: VideoPlayer(this.widget.controller),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : CircularProgressIndicator(),
              if(widget.active) buildBlackShadow(),
        ],
      ) // ✅ Show loader until video initializes
          );

  Widget buildVideoFullScreenPlayer() => Positioned(
        child: Stack(
        children: [
          this.widget.controller.value.isInitialized
              ? GestureDetector(
                  onTap: () {
                    widget.onOpenActive();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Container(
                      child: AspectRatio(
                        aspectRatio: this.widget.controller.value.aspectRatio,
                        child: VideoPlayer(this.widget.controller),
                      ),
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
          if(widget.active) buildBlackShadow(),
        ],
      ));
}
