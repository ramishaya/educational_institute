import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/assets_data.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const FullScreenVideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<FullScreenVideoPlayerScreen> createState() =>
      _FullScreenVideoPlayerScreenState();
}

class _FullScreenVideoPlayerScreenState
    extends State<FullScreenVideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  bool _isMuted = true;
  bool _isPlaying = true;
  bool _showPlayPauseButton = false;
  bool _showSeekNotification = false;
  String _seekDirection = '';

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.setLooping(true);
        _videoPlayerController.play();
        _videoPlayerController.setVolume(_isMuted ? 0 : 1);
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
        _showPlayPauseButton = true;
      } else {
        _videoPlayerController.play();
        _showPlayPauseButton = true;
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _showPlayPauseButton = false;
          });
        });
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _seekForward() {
    final newPosition =
        _videoPlayerController.value.position + const Duration(seconds: 2);
    _videoPlayerController.seekTo(newPosition);
    _showSeekNotificationMessage('Forward');
  }

  void _seekBackward() {
    final newPosition =
        _videoPlayerController.value.position - const Duration(seconds: 2);
    _videoPlayerController.seekTo(newPosition);
    _showSeekNotificationMessage('Backward');
  }

  void _showSeekNotificationMessage(String direction) {
    setState(() {
      _seekDirection = direction;
      _showSeekNotification = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showSeekNotification = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //final bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _togglePlayPause,
        onDoubleTapDown: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx > screenWidth / 2) {
            _seekForward();
          } else {
            _seekBackward();
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_videoPlayerController.value.isInitialized)
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: HelperFunctions.screenHeight(context) * 0.17),
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoPlayerController.value.size.width,
                    height: _videoPlayerController.value.size.height,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                ),
              )
            else
              const Center(child: CircularProgressIndicator()),
            if (_showPlayPauseButton)
              Icon(
                _isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                color: Colors.white,
                size: 64.0,
              ),
            if (_showSeekNotification)
              Positioned(
                top: HelperFunctions.screenHeight(context) * 0.2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black54,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _seekDirection == 'Forward' ? '>> 2s' : '<< 2s',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: HelperFunctions.screenHeight(context) * 0.02,
              right: HelperFunctions.screenWidth(context) *
                  AppSizes.horizintalMarginPercent,
              child: IconButton(
                icon: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),
                onPressed: _toggleMute,
              ),
            ),
            Positioned(
              bottom: HelperFunctions.screenHeight(context) * 0.02,
              left: HelperFunctions.screenWidth(context) *
                  AppSizes.horizintalMarginPercent,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: HelperFunctions.screenWidth(context) *
                        AppSizes.horizintalMarginPercent),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AssetsData.roundedLogo,
                          width: HelperFunctions.screenHeight(context) * 0.05,
                          height: HelperFunctions.screenHeight(context) * 0.05,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: HelperFunctions.screenWidth(context) * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Institute Name',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white),
                        ),
                        Text(
                          '1 hour ago',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.softGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: HelperFunctions.screenHeight(context) * 0.09,
                left: HelperFunctions.screenWidth(context) *
                    AppSizes.horizintalMarginPercent,
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.white,
                    child: IconButton(
                      icon: const Icon(
                        Iconsax.arrow_left_24,
                        size: 25,
                        color: AppColors.black,
                      ),
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                    ))),
          ],
        ),
      ),
    );
  }
}
