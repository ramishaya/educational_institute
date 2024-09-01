import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/teacher_info_item.dart';
import 'package:flutter/material.dart';

class TeachersInfoList extends StatelessWidget {
  const TeachersInfoList({
    super.key,
    required this.teachersInfo,
  });

  final List<Map<String, String>> teachersInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: HelperFunctions.screenWidth(context) * AppSizes.horizintalMarginPercent,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: HelperFunctions.screenWidth(context) * 0.015,
        ),
        height: HelperFunctions.screenHeight(context) * 0.17,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: teachersInfo.length,
          itemBuilder: (context, index) {
            final teacherInfo = teachersInfo[index];
            return TeacherInfoItem(name: teacherInfo['name']!, image: teacherInfo["image"]! , index : index);
          },
        ),
      ),
    );
  }
}
