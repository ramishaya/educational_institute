
import 'package:educational_institute/core/common/widgets/buttons/circular_back_button.dart';
import 'package:educational_institute/core/common/widgets/curved_edges/curved_edges_widget.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/device/device_utility.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CourseDetailsHeader extends StatelessWidget {
  const CourseDetailsHeader({
    super.key,
    required this.tag,
    required this.image,
  });

  final String tag;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        width: double.infinity,
        height: HelperFunctions.screenHeight(context) * 0.55,
        color: Colors.transparent,
        child: Stack(
          children: [
            Hero(
              tag: tag,
              child: Image.asset(
                image,
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
          ],
        ),
      ),
    );
  }
}
