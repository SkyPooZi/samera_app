import 'package:flutter/material.dart';

class DetailHeaderImage extends StatelessWidget {
  final String imageUrl;
  final double height;

  const DetailHeaderImage({
    super.key,
    required this.imageUrl,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
            ),
          ),
        ],
      ),
    );
  }
}
