import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class RoundedThinContainer extends StatelessWidget {
  const RoundedThinContainer({
    super.key,
    required this.children,
    required this.backGroundColor,
  });
  final List<Widget> children;
  final Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HelperFunctions.screenHeight(context) * 0.05,
      padding: EdgeInsets.all(HelperFunctions.screenHeight(context) * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardRadiusSm),
        color: backGroundColor,
      ),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}
