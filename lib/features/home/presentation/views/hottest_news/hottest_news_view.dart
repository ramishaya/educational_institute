import 'package:educational_institute/features/home/presentation/views/hottest_news/widgets/hottets_news_info.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/core/common/widgets/curved_edges/curved_edges_widget.dart';
import 'package:educational_institute/core/common/widgets/buttons/circular_back_button.dart';
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/device/device_utility.dart';
import 'package:go_router/go_router.dart';

class HottestNewsView extends StatefulWidget {
  const HottestNewsView({
    super.key,
    required this.url,
    required this.tag,
    required this.title,
  });

  final String url;
  final String tag;
  final String title;

  @override
  State<HottestNewsView> createState() => _HottestNewsViewState();
}

class _HottestNewsViewState extends State<HottestNewsView>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation1;
  late Animation<Offset> _offsetAnimation2;
  bool get isVideo => widget.url.endsWith(".mp4");

  @override
  void initState() {
    super.initState();
    if (isVideo) {
      _videoController = VideoPlayerController.asset(widget.url)
        ..initialize().then((_) {
          setState(() {
            _videoController.setVolume(0);
            _videoController.play();
          });
        });
    }
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation1 = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start off-screen at the bottom
      end: const Offset(0.0, 0.0), // End at original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start off-screen at the bottom
      end: const Offset(0.0, 0.0), // End at original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    if (isVideo) {
      _videoController.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurvedEdgesWidget(
              child: HottestNewsContent(
                url: widget.url,
                tag: widget.tag,
                title: widget.title,
                isVideo: isVideo,
                videoController: isVideo ? _videoController : null,
              ),
            ),
            SizedBox(
              height: HelperFunctions.screenHeight(context) * 0.006,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HottestNewsInfo(),
                  SizedBox(
                    height: HelperFunctions.screenHeight(context) * 0.03,
                  ),
                  SlideTransition(
                    position: _offsetAnimation1,
                    child: Text(
                      "Discover the Latest Innovations and Updates in Language Education ",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(
                    height: HelperFunctions.screenHeight(context) * 0.02,
                  ),
                  SlideTransition(
                    position: _offsetAnimation2,
                    child: Text(
                      "Stay on the cutting edge of language learning with our latest developments and breakthroughs at the institute. From introducing state-of-the-art technology in our classrooms to launching new courses in less commonly taught languages, we are dedicated to enhancing your learning experience. This post explores our most recent initiatives, including partnerships with global language experts, updates to our curriculum to include immersive cultural experiences, and the introduction of hybrid learning models that blend online and in-person instruction. Learn how these advancements are set to redefine language education, making it more interactive, inclusive, and effective for learners of all ages , Stay on the cutting edge of language learning with our latest developments and breakthroughs at the institute. From introducing state-of-the-art technology in our classrooms to launching new courses in less commonly taught languages, we are dedicated to enhancing your learning experience. This post explores our most recent initiatives, including partnerships with global language experts, updates to our curriculum to include immersive cultural experiences, and the introduction of hybrid learning models that blend online and in-person instruction. Learn how these advancements are set to redefine language education, making it more interactive, inclusive, and effective for learners of all ages",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    height: HelperFunctions.screenHeight(context) * 0.04,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HottestNewsContent extends StatefulWidget {
  const HottestNewsContent({
    super.key,
    required this.url,
    required this.tag,
    required this.title,
    required this.isVideo,
    this.videoController,
  });

  final String url;
  final String tag;
  final String title;
  final bool isVideo;
  final VideoPlayerController? videoController;

  @override
  State<HottestNewsContent> createState() => _HottestNewsContentState();
}

class _HottestNewsContentState extends State<HottestNewsContent> {
  bool _isMuted = true;

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      widget.videoController!.setVolume(_isMuted ? 0 : 1);
    });
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (widget.isVideo && widget.videoController != null) {
      if (info.visibleFraction > 0.5 &&
          !widget.videoController!.value.isPlaying) {
        widget.videoController!.play();
      } else if (info.visibleFraction <= 0.5 &&
          widget.videoController!.value.isPlaying) {
        widget.videoController!.pause();
      }
    }
  }

  void _navigateToFullScreen() {
    if (widget.isVideo && widget.videoController != null) {
      GoRouter.of(context).push(
        '/fullScreenVideo',
        extra: widget.url,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.url),
      onVisibilityChanged: _handleVisibilityChanged,
      child: GestureDetector(
        onTap: _navigateToFullScreen,
        child: Container(
          width: double.infinity,
          height: HelperFunctions.screenHeight(context) * 0.55,
          color: Colors.transparent,
          child: Stack(
            children: [
              Hero(
                tag: widget.tag,
                child: widget.isVideo && widget.videoController != null
                    ? SizedBox(
                        width: double.infinity,
                        height: HelperFunctions.screenHeight(context) * 0.55,
                        child: AspectRatio(
                          aspectRatio:
                              widget.videoController!.value.aspectRatio,
                          child: VideoPlayer(widget.videoController!),
                        ),
                      )
                    : Image.asset(
                        widget.url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: HelperFunctions.screenHeight(context) * 0.55,
                      ),
              ),
              Positioned(
                  top: DeviceUtils.getAppBarBarHeight(),
                  left: HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent,
                  child: const CircularBackButton()),
              Positioned(
                left: HelperFunctions.screenWidth(context) *
                    AppSizes.horizintalMarginPercent,
                bottom: DeviceUtils.getAppBarBarHeight(),
                right: HelperFunctions.screenWidth(context) *
                    AppSizes.horizintalMarginPercent *
                    2,
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w500),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  textAlign: TextAlign.start,
                ),
              ),
              if (widget.isVideo && widget.videoController != null)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: IconButton(
                    icon: Icon(
                      _isMuted ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white,
                    ),
                    onPressed: _toggleMute,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
