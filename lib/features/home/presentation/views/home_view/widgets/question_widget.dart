import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? selectedAnswerIndex;
  bool answeredCorrectly = false;
  bool hasAnswered = false;

  void _onOptionSelected(int index) {
    if (!hasAnswered) {
      setState(() {
        selectedAnswerIndex = index;
        answeredCorrectly = (index == widget.correctAnswerIndex);
        hasAnswered = true; // Disable further selections
      });
    }
  }

  Color _getOptionColor(int index) {
    if (selectedAnswerIndex == null) {
      return AppColors.white;
    } else if (index == selectedAnswerIndex) {
      return answeredCorrectly ? AppColors.sucsses : AppColors.error;
    } else if (index == widget.correctAnswerIndex) {
      return AppColors.sucsses;
    } else {
      return AppColors.white;
    }
  }

  Border _getOptionBorder(int index) {
    if (selectedAnswerIndex == index) {
      return Border.all(color: AppColors.primaryColor, width: 3);
    } else {
      return Border.all(color: AppColors.primaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: HelperFunctions.screenWidth(context) *
            AppSizes.horizintalMarginPercent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: AppColors.black,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(
                HelperFunctions.screenWidth(context) *
                    AppSizes.horizintalMarginPercent,
              ),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15.0),
                ),
              ),
              child: Text(
                widget.question,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: AppColors.white),
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.025),
            for (int i = 0; i < widget.options.length; i++)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent,
                ),
                child: GestureDetector(
                  onTap: () => _onOptionSelected(i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: _getOptionColor(i),
                      borderRadius: BorderRadius.circular(20),
                      border: _getOptionBorder(i), // Add border conditionally
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: AppColors.primaryColor, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            String.fromCharCode(
                                65 + i), // Convert index to A, B, C, etc.
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        ),
                        SizedBox(
                            width: HelperFunctions.screenWidth(context) * 0.04),
                        Expanded(
                          child: Text(
                            widget.options[i],
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.025),
          ],
        ),
      ),
    );
  }
}
