import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/core/utils/router/app_router.dart';

class HottestNewsCard extends StatefulWidget {
  const HottestNewsCard({
    super.key,
    required this.url,
    required this.index,
    required this.title,
  });

  final String url, title;
  final int index;

  @override
  State<HottestNewsCard> createState() => _HottestNewsCardState();
}

class _HottestNewsCardState extends State<HottestNewsCard> {
  VideoPlayerController? _videoController;
  bool get isVideo => widget.url.endsWith(".mp4");

  @override
  void initState() {
    super.initState();
    if (isVideo) {
      _videoController = VideoPlayerController.asset(widget.url)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardHeight = HelperFunctions.screenHeight(context) * 0.3;
    final cardWidth = cardHeight * 1.2;

    return GestureDetector(
      onTap: () => GoRouter.of(context).push(
        AppRouter.kHottestNewsView,
        extra: {
          'tag': "${widget.index}",
          'url': widget.url,
          'title': widget.title,
        },
      ),
      child: Container(
        margin: EdgeInsets.only(right: cardWidth * 0.05),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
          child: Stack(
            children: [
              isVideo
                  ? _videoController?.value.isInitialized ?? false
                      ? Stack(
                          children: [
                            Hero(
                              tag: "${widget.index}",
                              child: SizedBox(
                                height: cardHeight,
                                width: cardWidth,
                                child: VideoPlayer(_videoController!),
                              ),
                            ),
                            const Positioned.fill(
                              child: Center(
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: Colors.white,
                                  size: 40.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: cardHeight,
                          width: cardWidth,
                          color: Colors.black,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                  : Hero(
                      tag: "${widget.index}",
                      child: Image.asset(
                        widget.url,
                        height: cardHeight,
                        width: cardWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
              Container(
                height: cardHeight,
                width: cardWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.black.withOpacity(0.6),
                      Colors.transparent
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: cardHeight * 0.09,
                left: cardWidth * 0.05,
                right: cardWidth * 0.05,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: cardHeight * 0.35,
                    child: Text(
                      widget.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: AppColors.white),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
