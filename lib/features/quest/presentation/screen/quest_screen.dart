import 'package:flutter/material.dart';

import '../../../../core/styles/typography/text_styles.dart';
import '../widgets/active_quest_card.dart';
import '../widgets/quest_header_card.dart';

class QuestScreen extends StatelessWidget {
  const QuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.03,
                    bottom: screenHeight * 0.03,
                  ),
                  child: const QuestHeaderCard(
                    userName: 'Skypo',
                    levelText: 'Level 12 • Explorer',
                    xpProgress: 2450 / 3000,
                    currentXp: '2.450',
                    targetXp: '3.000',
                    destinationCount: '2.450',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: Text(
                    'Active Quest',
                    style: tsTitleSmallSemiBold(Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: const ActiveQuestCard(
                    title: 'Heritage Quest',
                    description:
                        'Jelajahi sejarah & warisan budaya di kraton Yogyakarta.',
                    progressText: '2 / 3 Task',
                    progressValue: 2 / 3,
                    icon: Icons.account_balance,
                    backgroundColor: Color(0xFFEBE7FA),
                    progressColor: Color(0xFF6B4EE6),
                    iconColor: Color(0xFF6C4BDD),
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSptTGAq8DVGsT3u5e6afP-b4g_LOAWP84vFfSXFog1MZUo5a-oXf_XjpY&s=10',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.12),
                  child: const ActiveQuestCard(
                    title: 'Batik Quest',
                    description:
                        'Kenali seni batik & coba membuat motif khas Yogyakarta.',
                    progressText: '2 / 4 Task',
                    progressValue: 2 / 4,
                    icon: Icons.color_lens,
                    backgroundColor: Color(0xFFFDF0DD),
                    progressColor: Color(0xFFF07C33),
                    iconColor: Color(0xFFF07C33),
                    imageUrl: 'https://images.unsplash.com/photo-1616125162686-770bf85622b9?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
