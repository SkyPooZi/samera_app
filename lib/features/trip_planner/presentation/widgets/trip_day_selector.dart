import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class TripDaySelector extends StatefulWidget {
  const TripDaySelector({super.key});

  @override
  State<TripDaySelector> createState() => _TripDaySelectorState();
}

class _TripDaySelectorState extends State<TripDaySelector> {
  int _selectedDay = 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDayTab('Day 1', 1, width),
        SizedBox(width: width * 0.04),
        _buildDayTab('Day 2', 2, width),
      ],
    );
  }

  Widget _buildDayTab(String label, int dayIndex, double width) {
    bool isActive = _selectedDay == dayIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = dayIndex;
        });
      },
      child: Container(
        width: width * 0.35,
        padding: EdgeInsets.symmetric(vertical: width * 0.03),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFE813C) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? null
              : Border.all(color: Colors.grey.withOpacity(0.3)),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFFFE813C).withOpacity(0.3),
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
