import 'package:flutter/material.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/hottest_news_card.dart';

class HottestNewsList extends StatelessWidget {
  final List<Map<String, String>> newsList;

  const HottestNewsList({required this.newsList, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: HelperFunctions.screenWidth(context) *
              AppSizes.horizintalMarginPercent),
      child: SizedBox(
        height: HelperFunctions.screenHeight(context) * 0.3,
        child: ListView.builder(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final news = newsList[index];
            return HottestNewsCard(
              index: index,
              title: news["title"]!,
              url: news["url"]!,
            );
          },
        ),
      ),
    );
  }
}
