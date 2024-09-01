import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/features/home/presentation/views/full_video/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ReelItem extends StatefulWidget {
  final String videoUrl;

  const ReelItem({super.key, required this.videoUrl});

  @override
  _ReelItemState createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  late VideoPlayerController _videoPlayerController;
  bool _isMuted = true;
  bool _isPlaying = false;
  bool _showPlayButton = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.setLooping(true);
        _videoPlayerController.setVolume(0);
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _videoPlayerController.setVolume(_isMuted ? 0 : 1);
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _videoPlayerController.pause();
        _showPlayButton = true;
      } else {
        _videoPlayerController.play();
        _showPlayButton = false;
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.5 && !_isPlaying) {
      _videoPlayerController.play();
      setState(() {
        _isPlaying = true;
        _showPlayButton = false;
      });
    } else if (info.visibleFraction <= 0.5 && _isPlaying) {
      _videoPlayerController.pause();
      setState(() {
        _isPlaying = false;
        _showPlayButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: _handleVisibilityChanged,
      child: _videoPlayerController.value.isInitialized
          ? LayoutBuilder(
              builder: ( context , constraints ) {
                final width = constraints.maxWidth;
                final aspectRatio = _videoPlayerController.value.aspectRatio;
                final height = HelperFunctions.screenHeight(context) * 0.8;
                return GestureDetector(
                  onTap: ()=> _navigateToFullScreen(context),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: width,
                        height: height,
                        child: VideoPlayer(_videoPlayerController ),
                      ),
                      if (_showPlayButton)
                        IconButton(
                          icon: const Icon(
                            Icons.play_circle_filled,
                            color: AppColors.white,
                            size: 64.0,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: IconButton(
                          icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                            color: AppColors.white,
                          ),
                          onPressed: _toggleMute,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
    void _navigateToFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPlayerScreen(videoUrl: widget.videoUrl),
      ),
    );
  }
}
