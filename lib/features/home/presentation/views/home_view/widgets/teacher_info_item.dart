import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/core/utils/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeacherInfoItem extends StatelessWidget {
  const TeacherInfoItem(
      {super.key,
      required this.name,
      required this.image,
      required this.index});
  final String name;
  final String image;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: HelperFunctions.screenWidth(context) * 0.23,
      margin:
          EdgeInsets.only(right: HelperFunctions.screenWidth(context) * 0.05),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.push(AppRouter.kTeacherDetails,
                  extra: Tranobj(tag: "$name$index", image: image , ""));
            },
            child: Hero(
              tag: "$name$index",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 3.0,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    image,
                    width: 75.0,
                    height: 75.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: HelperFunctions.screenHeight(context) * 0.01),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class Tranobj {
  final String tag, image , text;

  Tranobj(this.text, {required this.tag, required this.image} );
}
