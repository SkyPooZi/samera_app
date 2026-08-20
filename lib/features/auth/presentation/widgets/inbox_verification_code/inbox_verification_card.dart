import 'package:flutter/material.dart';

class InboxVerificationCardContainer extends StatelessWidget {
  final Widget child;

  const InboxVerificationCardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }
}
