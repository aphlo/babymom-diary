import 'package:flutter/material.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';

import 'calendar_event_tile.dart';
import 'empty_events_view.dart';

class SelectedDayEventList extends StatelessWidget {
  const SelectedDayEventList({required this.events, super.key});

  final List<CalendarEvent> events;

  static const _scrollPhysics = BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return ListView(
        physics: _scrollPhysics,
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
        children: const [
          EmptyEventsView(),
        ],
      );
    }

    return ListView.separated(
      physics: _scrollPhysics,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      itemBuilder: (context, index) {
        final event = events[index];
        return CalendarEventTile(event: event);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: events.length,
    );
  }
}
