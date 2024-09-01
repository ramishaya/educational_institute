
import 'package:educational_institute/features/calender/presentation/views/calendar_view/widgets/event_card.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  final List<Map<String, String>> events;
  final Animation<double> slideAnimation;
  final Animation<double> fadeAnimation;

  const EventList({super.key, required this.events, required this.slideAnimation, required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's schedule",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: slideAnimation,
          builder: (context, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Transform.translate(
                  offset: Offset(0, slideAnimation.value),
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: EventCard(event: events[index]),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}