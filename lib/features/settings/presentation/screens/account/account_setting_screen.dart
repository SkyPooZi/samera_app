import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import '../../widgets/setting_header/setting_header.dart';
import '../../widgets/setting_item_card/setting_item_card.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  String username = 'SkyPoo';
  String email = 'skypoozli@gmail.com';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('registered_username') ?? 'SkyPoo';
      email = prefs.getString('registered_email') ?? 'skypoozli@gmail.com';
    });
  }

  Future<void> _showEditDialog(String title, String key, String currentValue) async {
    final TextEditingController controller = TextEditingController(text: currentValue);
    final isPassword = key == 'registered_password';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Ubah $title'),
          content: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: 'Masukkan $title baru',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal', style: tsBodyMediumMedium(Colors.black87)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsResources.colorsPrimary,
              ),
              onPressed: () async {
                final newValue = controller.text.trim();
                if (newValue.isNotEmpty) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(key, newValue);
                  setState(() {
                    if (key == 'registered_username') username = newValue;
                    if (key == 'registered_email') email = newValue;
                  });
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$title berhasil diubah!')),
                    );
                  }
                }
              },
              child: Text('Simpan', style: tsBodyMediumMedium(Colors.white)),
            ),
          ],
        );
      },
    );
  }

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
                title: 'Akun',
                subtitle: 'Kelola informasi akun anda',
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
                      title: 'Username',
                      subtitle: username,
                      showArrow: false,
                      onTap: () => _showEditDialog('Username', 'registered_username', username),
                    ),
                    SettingItemCard(
                      icon: Icons.email,
                      title: 'Email',
                      subtitle: email,
                      showArrow: false,
                      onTap: () => _showEditDialog('Email', 'registered_email', email),
                    ),
                    SettingItemCard(
                      icon: Icons.lock,
                      title: 'Password',
                      subtitle: '**********',
                      showArrow: false,
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final currentPass = prefs.getString('registered_password') ?? '';
                        if (context.mounted) {
                          _showEditDialog('Password', 'registered_password', currentPass);
                        }
                      },
                    ),
                    SettingItemCard(
                      icon: Icons.key,
                      title: 'Change Password',
                      subtitle: 'Ubah kata sandi anda',
                      showDivider: false,
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final currentPass = prefs.getString('registered_password') ?? '';
                        if (context.mounted) {
                          _showEditDialog('Password', 'registered_password', currentPass);
                        }
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
