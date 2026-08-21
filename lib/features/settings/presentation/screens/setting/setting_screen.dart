import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import '../../widgets/setting_header/setting_header.dart';
import '../../widgets/setting_item_card/setting_item_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF5EB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SettingHeader(
                title: 'Setting',
                subtitle: 'Kelola akun dan preferensi akun anda',
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SettingItemCard(
                      icon: Icons.person,
                      title: 'Akun',
                      subtitle: 'Kelola informasi akun anda',
                      onTap: () {
                        context.push('/setting/account');
                      },
                    ),
                    SettingItemCard(
                      icon: Icons.info_outline,
                      title: 'About Us',
                      subtitle: 'Tentang aplikasi dan tim kami',
                      onTap: () {
                        context.push('/setting/about');
                      },
                    ),
                    SettingItemCard(
                      icon: Icons.verified_user_outlined,
                      title: 'Privacy and Policy',
                      subtitle: 'Kebijakan privasi dan syarat layanan',
                      onTap: () {
                        context.push('/setting/privacy');
                      },
                    ),
                    SettingItemCard(
                      icon: Icons.logout,
                      title: 'Keluar Akun',
                      subtitle: 'Logout dari akun anda',
                      iconColor: Colors.red,
                      showDivider: false,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text('Keluar Akun'),
                              content: const Text(
                                'Apakah anda yakin ingin keluar akun?\n\n'
                                'Data yang anda simpan akan hilang karena aplikasi masih menggunakan penyimpanan lokal (local storage).',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(dialogContext).pop(),
                                  child: Text('Batal', style: tsBodyMediumMedium(Colors.black87)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                  onPressed: () async {
                                    Navigator.of(dialogContext).pop();
                                    final prefs = await SharedPreferences.getInstance();
                                    await prefs.clear();
                                    if (context.mounted) {
                                      context.go('/login');
                                    }
                                  },
                                  child: Text(
                                    'Keluar',
                                    style: tsBodyMediumMedium(Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
