import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/setting_header/setting_header.dart';
import '../../widgets/setting_item_card/setting_item_card.dart';
import 'policy_detail_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                title: 'Privacy and Policy',
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
                      icon: Icons.verified_user,
                      title: 'Kebijakan Privasi',
                      subtitle: 'Pelajari bagaimana kami mengumpulkan, menggunakan dan melindungi data anda',
                      onTap: () {
                        context.push(
                          '/setting/privacy/detail',
                          extra: {
                            'title': 'Kebijakan Privasi',
                            'subtitle': 'Privasi Anda penting bagi kami. Kebijakan ini menjelaskan informasi apa yang kami kumpulkan, bagaimana kami menggunakannya, dan bagaimana kami melindunginya saat Anda menggunakan Samera.',
                            'lastUpdated': '21 Agustus 2026',
                            'sections': [
                              PolicySection(
                                title: 'Informasi yang kami kumpulkan',
                                content: 'Kami mengumpulkan informasi yang Anda berikan secara langsung seperti nama, email, dan informasi lainnya saat Anda menggunakan aplikasi kami.',
                              ),
                              PolicySection(
                                title: 'Penggunaan Informasi',
                                content: 'Informasi yang kami kumpulkan digunakan untuk memberikan layanan terbaik, meningkatkan pengalaman Anda, dan mengomunikasikan informasi penting terkait layanan kami.',
                              ),
                              PolicySection(
                                title: 'Perlindungan Data',
                                content: 'Kami menerapkan langkah-langkah keamanan untuk melindungi data Anda dari akses yang tidak sah, perubahan, pengungkapan, atau penyalahgunaan.',
                              ),
                              PolicySection(
                                title: 'Berbagi Informasi',
                                content: 'Kami tidak menjual atau menyewakan informasi pribadi Anda kepada pihak ketiga. Informasi hanya dibagikan kepada pihak terpercaya jika diperlukan untuk menyediakan layanan kami.',
                              ),
                              PolicySection(
                                title: 'Hak Anda',
                                content: 'Anda memiliki hak untuk mengakses, memperbarui, atau menghapus informasi pribadi Anda melalui pengaturan akun atau dengan menghubungi kami.',
                              ),
                              PolicySection(
                                title: 'Perubahan Kebijakan',
                                content: 'Kami dapat memperbarui kebijakan privasi ini sewaktu-waktu. Perubahan akan diberitahukan melalui aplikasi jika dianggap penting.',
                              ),
                              PolicySection(
                                title: 'Kontak Kami',
                                content: 'Jika Anda memiliki pertanyaan atau keluhan terkait kebijakan privasi ini, silakan hubungi kami melalui email yang tersedia pada aplikasi.',
                              ),
                            ],
                          },
                        );
                      },
                    ),
                    SettingItemCard(
                      icon: Icons.description,
                      title: 'Syarat Layanan',
                      subtitle: 'Baca syarat dan ketentuan penggunaan aplikasi kami',
                      showDivider: false,
                      onTap: () {
                        context.push(
                          '/setting/privacy/detail',
                          extra: {
                            'title': 'Syarat Layanan',
                            'subtitle': 'Baca syarat dan ketentuan penggunaan aplikasi Samera.',
                            'lastUpdated': '21 Agustus 2026',
                            'sections': [
                              PolicySection(
                                title: 'Penggunaan Aplikasi',
                                content: 'Jelajah Indonesia digunakan untuk membantu pengguna menemukan informasi destinasi wisata, tempat menarik, kuliner, serta rekomendasi perjalanan di berbagai wilayah Indonesia.',
                              ),
                              PolicySection(
                                title: 'Akun Pengguna',
                                content: 'Pengguna bertanggung jawab atas informasi yang diberikan saat membuat akun dan wajib menjaga keamanan akun serta kata sandi.',
                              ),
                              PolicySection(
                                title: 'Informasi Perjalanan',
                                content: 'Informasi mengenai destinasi, tempat wisata, rute, harga, dan layanan dapat berubah sewaktu-waktu. Pengguna disarankan untuk memastikan kembali informasi sebelum melakukan perjalanan.',
                              ),
                              PolicySection(
                                title: 'Konten Pengguna',
                                content: 'Pengguna bertanggung jawab atas konten atau informasi yang dibagikan melalui aplikasi. Konten tidak boleh mengandung informasi yang melanggar hukum, merugikan pihak lain, atau mengganggu pengguna lainnya.',
                              ),
                              PolicySection(
                                title: 'Hak Anda',
                                content: 'Anda memiliki hak untuk mengakses, memperbarui, atau menghapus informasi pribadi Anda melalui pengaturan akun atau dengan menghubungi kami.',
                              ),
                              PolicySection(
                                title: 'Perubahan Kebijakan',
                                content: 'Kami dapat memperbarui kebijakan privasi ini sewaktu-waktu. Perubahan akan diberitahukan melalui aplikasi jika dianggap penting.',
                              ),
                              PolicySection(
                                title: 'Kontak Kami',
                                content: 'Jika Anda memiliki pertanyaan atau keluhan terkait kebijakan privasi ini, silakan hubungi kami melalui email yang tersedia pada aplikasi.',
                              ),
                            ],
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
