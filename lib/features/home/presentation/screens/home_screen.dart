import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/images/images.dart';
import 'package:samera_app/core/styles/icons/icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/router.dart';
import '../../../navigation/presentation/bloc/navbar_cubit.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

import '../../../account/presentation/bloc/account/account_bloc.dart';
import '../../../account/presentation/bloc/account/account_state.dart';

import '../../../../common/common_section_title.dart';
import '../../../../common/common_destination_card.dart';
import '../widgets/home_profile_header.dart';
import '../widgets/home_hero_banner.dart';
import '../widgets/home_adventure_menu.dart';
import '../widgets/home_daily_quest_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Variabel responsif berbasis ukuran layar pengguna
    final size = MediaQuery.of(context).size;
    final double sectionSpacing = size.height * 0.035;
    final double elementSpacing = size.height * 0.02;
    final double horizontalSpacing = size.width * 0.03;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesThemes.imgBgHome),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagesThemes.imgBgHeaderHome),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.05),
                        child: BlocBuilder<AccountBloc, AccountState>(
                          builder: (context, state) {
                            String username = 'SkyPoo';
                            if (state is AccountLoaded) {
                              username = state.username ?? 'SkyPoo';
                            }
                            return HomeProfileHeader(
                              name: username,
                              subtitle: 'Siap untuk petualangan selanjutnya?',
                              profileImageUrl: 'https://i.pravatar.cc/150?img=11',
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: sectionSpacing),
                        child: HomeHeroBanner(
                          location: 'KARIMUN JAWA',
                          title1: 'Liburan',
                          title2: 'Menantimu',
                          description: 'Kepulauan tropis dengan laut jernih,\npantai putih, dan pulau kecil yang\nmenawan.',
                          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7gy4lhEHfJ_5L0hmn0RdLkyNWuCUUKS8nyMRuuHs6Xw&s=10',
                          onExploreTap: () {
                            context.push('/explore/category/destination', extra: {'title': 'Destinasi'});
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: sectionSpacing),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: elementSpacing),
                              child: const CommonSectionTitle(
                                title: "Mulai petualanganmu",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: horizontalSpacing,
                                        ),
                                        child: HomeAdventureMenuCard(
                                          title: 'Jelajah',
                                          subtitle: 'Temukan destinasi\nmenarik lainnya',
                                          gradientColors: const [
                                            ColorsResources.colorsPrimaryLight,
                                            ColorsResources.colorsPrimaryLight,
                                          ],
                                          borderColor: ColorsResources
                                              .colorsPrimary
                                              .withValues(alpha: 0.3),
                                          imagePath: IconsThemes.iconCompass,
                                          onTap: () {
                                            context.read<NavbarCubit>().loadNavbar(1);
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: HomeAdventureMenuCard(
                                        title: 'Trip Planner',
                                        subtitle: 'Rencanakan perjalanan\nimpianmu dengan mudah',
                                        gradientColors: const [
                                          ColorsResources.colorsPrimaryLight,
                                          ColorsResources.colorsPrimaryLight,
                                        ],
                                        borderColor: ColorsResources
                                            .colorsPrimary
                                            .withValues(alpha: 0.3),
                                        imagePath: IconsThemes.iconMap,
                                        onTap: () {
                                          context.read<NavbarCubit>().loadNavbar(2);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: sectionSpacing),
                        child: HomeDailyQuestBanner(
                          title: 'Quest harian',
                          description: 'Kenali motif batik asli\nyogyakarta',
                          currentProgress: 2,
                          totalProgress: 3,
                          progressLabel: 'Foto Batik',
                          imagePath: IconsThemes.iconBatik,
                          onTap: () {},
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: elementSpacing),
                            child: const CommonSectionTitle(
                              title: "Rekomendasi untukmu",
                            ),
                          ),
                          SizedBox(
                            // Catatan: SizedBox ini bukan untuk jarak, tapi untuk memberikan batas tinggi pada ListView horizontal
                            height: size.height * 0.24,
                            child: BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is HomeLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorsResources.colorsPrimary,
                                    ),
                                  );
                                } else if (state is HomeError) {
                                  return Center(child: Text(state.message));
                                } else if (state is HomeLoaded) {
                                  if (state.recommendations.isEmpty) {
                                    return const Center(
                                      child: Text('Tidak ada rekomendasi'),
                                    );
                                  }
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.recommendations.length,
                                    padding: const EdgeInsets.only(right: 24.0),
                                    itemBuilder: (context, index) {
                                      final destination =
                                          state.recommendations[index];
                                      return CommonDestinationCard(
                                        title: destination.name,
                                        location: destination.category,
                                        rating: destination.rating,
                                        id: destination.id,
                                        imageUrl: destination.image,
                                        onTap: () {
                                          context.pushNamed(
                                            Routes.detailDestination,
                                            extra: destination,
                                          );
                                        },
                                      );
                                    },
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
