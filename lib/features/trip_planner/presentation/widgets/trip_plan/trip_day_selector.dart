import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class TripDaySelector extends StatelessWidget {
  final int totalDays;
  final int selectedDay;
  final ValueChanged<int> onDaySelected;

  const TripDaySelector({
    super.key,
    required this.totalDays,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: width * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(totalDays, (index) {
          int day = index + 1;
          return Padding(
            padding: EdgeInsets.only(right: index == totalDays - 1 ? 0 : width * 0.04),
            child: _buildDayTab('Day $day', day, width),
          );
        }),
      ),
    );
  }

  Widget _buildDayTab(String label, int dayIndex, double width) {
    bool isActive = selectedDay == dayIndex;
    return GestureDetector(
      onTap: () => onDaySelected(dayIndex),
      child: Container(
        width: width * 0.3,
        padding: EdgeInsets.symmetric(vertical: width * 0.03),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFE813C) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? null
              : Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFFFE813C).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: isActive
                ? tsBodyMediumSemiBold(Colors.white)
                : tsBodyMediumSemiBold(Colors.grey[700]!),
          ),
        ),
      ),
    );
  }
}
