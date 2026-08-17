import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class CategoryItemData {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;

  CategoryItemData({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
  });
}

class ExploreCategoriesSection extends StatelessWidget {
  final String title;
  final List<CategoryItemData> categories;

  const ExploreCategoriesSection({
    super.key,
    required this.title,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: tsBodyLargeMedium(Colors.black87)),
        SizedBox(height: size.height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories.map((category) {
            return _buildCategoryItem(category, size.width);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(CategoryItemData category, double screenWidth) {
    final itemWidth = screenWidth * 0.14;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: itemWidth,
            height: itemWidth,
            decoration: BoxDecoration(
              color: category.bgColor,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              border: Border.all(
                color: category.iconColor.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Icon(
              category.icon,
              color: category.iconColor,
              size: itemWidth * 0.5,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            category.label,
            textAlign: TextAlign.center,
            style: tsLabelLargeMedium(Colors.black87).copyWith(height: 1.2),
          ),
        ],
      ),
    );
  }
}
