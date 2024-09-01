import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomExpandableText extends StatefulWidget {
  final String content;

  const CustomExpandableText({
    super.key,
    required this.content,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomExpandableTextState createState() => _CustomExpandableTextState();
}

class _CustomExpandableTextState extends State<CustomExpandableText> {
  final ValueNotifier<bool> expanded = ValueNotifier(false);
  final int maxLinesToShow = 2;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: expanded,
      builder: (context, value, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final TextPainter textPainter = TextPainter(
              text: TextSpan(
                text: widget.content,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
              ),
              maxLines: maxLinesToShow,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(maxWidth: constraints.maxWidth);

            final bool isOverflowing = textPainter.didExceedMaxLines;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isOverflowing && !expanded.value
                    ? _buildCollapsedText(context, constraints.maxWidth)
                    : Text(
                        widget.content,
                        style:Theme.of(context).textTheme.bodyLarge!.copyWith(),
                      ),
                if (isOverflowing && expanded.value)
                  GestureDetector(
                    onTap: () {
                      expanded.value = !expanded.value;
                    },
                    child: const Text(
                      'less',
                      style: TextStyle(color: AppColors.darkGrey),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCollapsedText(BuildContext context, double maxWidth) {
    final TextSpan textSpan = TextSpan(
      text: widget.content,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.bold),
    );

    final TextPainter textPainter = TextPainter(
      text: textSpan,
      maxLines: maxLinesToShow,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth);

    final int endIndex = textPainter
        .getPositionForOffset(Offset(textPainter.width, textPainter.height))
        .offset;

    final String visibleText = '${widget.content.substring(0, endIndex)}...';

    return RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.normal),
        children: [
          TextSpan(text: visibleText),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () {
                expanded.value = true;
              },
              child: const Text(
                ' more',
                style: TextStyle(color: AppColors.darkerGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
