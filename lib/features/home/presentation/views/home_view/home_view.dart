import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/course_card.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/home_title.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/post_widget.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/videos_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:educational_institute/core/utils/constants/assets_data.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/constants/texts.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/hottest_news_list.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/question_widget.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/teachers_info_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final teachersInfo = [
      {'image': AssetsData.roundedLogo, 'name': 'bernice_jdf'},
      {'image': AssetsData.roundedLogo, 'name': '@bernice_jdf'},
      {'image': AssetsData.roundedLogo, 'name': '@santiago18'},
      {'image': AssetsData.roundedLogo, 'name': '@alic3ray'},
      {'image': AssetsData.roundedLogo, 'name': '@alic3ray'},
    ];

  final newsList = [
      {
        'url': AssetsData.card1,
        'title': 'Language Learning Reimagined: What’s New at Our Institute'
      },
      {
        'url': AssetsData.card2,
        'title':
            'Discover the Latest Innovations and Updates in Language Education'
      },
      {
        'url': AssetsData.card3,
        'title': 'Language Learning Reimagined: What’s New at Our Institute'
      },
      {
        'url': AssetsData.card4,
        'title': 'Language Learning Reimagined: What’s New at Our Institute'
      },
      {
        'url': AssetsData.card5,
        'title':
            'Discover the Latest Innovations and Updates in Language Education'
      },
      {
        'url': "assets/images/reel2.mp4",
        'title': 'Discover the Latest hottest news in our Institute'
      },
    ];

    final videoUrls = [
      'assets/images/reel2.mp4',
      'assets/images/reel3.mp4',
      'assets/images/reel3.mp4',
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppTexts.instituteName,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: HelperFunctions.screenHeight(context) * 0.01,
            ),
            TeachersInfoList(teachersInfo: teachersInfo),
            const SizedBox(height: AppSizes.spaceBtwSections / 3),
            const HomeTitle(),
            SizedBox(
              height: HelperFunctions.screenHeight(context) * 0.02,
            ),
            HottestNewsList(
              newsList: newsList,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            const CourseCard(
              image: AssetsData.coursecover2,
              logo: AssetsData.nameLogo,
              title: 'Advance Your German: Beyond the Basics',
              description: 'Deepen Your Mastery with Our B2.1 German Course',
              buttonText: 'See Details',
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            const CourseCard(
              image: AssetsData.coursecover4,
              logo: AssetsData.nameLogo,
              title: 'Embarking on English: Your First Steps',
              description: 'Master the Basics with Our A1.1 English Course',
              buttonText: 'See Details',
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            // Example usage of VideoPostWidget with list of videos
            VideoPostWidget(
              videoUrls: videoUrls,
              publisher: 'Publisher Name',
              content: 'This is a sample post content with multiple videos.',
            ),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            const PostWidget(
                images: [AssetsData.card1, AssetsData.card3, AssetsData.card5],
                publisher: "rami  shaya",
                content:
                    "this is a post in our app i am jsut testing our app to get the perfect result "),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            const QuestionWidget(
              question:
                  'Which sentence uses the correct form of the verb "to be"?',
              options: [
                'She are going to the store tomorrow',
                'They is playing soccer this afternoon',
                'You was at the party last night.',
                'He is reading a book.'
              ],
              correctAnswerIndex: 4,
            ),
            const SizedBox(
              height: AppSizes.spaceBtwSections * 3.2,
            ),
          ],
        ),
      ),
    );
  }
}
