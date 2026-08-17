import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class ExploreSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onFilterTap;

  const ExploreSearchBar({
    super.key,
    required this.hintText,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: width * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[500]!),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: tsBodySmallRegular(Colors.grey[600]!),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: tsBodySmallRegular(Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: width * 0.03),
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            padding: EdgeInsets.all(width * 0.035),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.tune, color: Colors.grey[600]!, size: 20),
          ),
        ),
      ],
    );
  }
}
