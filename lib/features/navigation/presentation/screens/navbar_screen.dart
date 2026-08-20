import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/icons/icons.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

import '../bloc/navbar_cubit.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../explore/presentation/screens/explore/explore_screen.dart';

class NavbarScreen extends StatefulWidget {
  final int? index;

  const NavbarScreen({super.key, this.index});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final List<Widget> pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const Scaffold(body: Center(child: Text("Trip Planner"))),
    const Scaffold(body: Center(child: Text("Quest"))),
    const Scaffold(body: Center(child: Text("Account"))),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<NavbarCubit>().loadNavbar(widget.index!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double iconSize = 32.0; // Ukuran dasar (logical pixels) sudah responsive
    return BlocBuilder<NavbarCubit, NavbarState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true, // Biar scroll view home bisa sampai ke bawah navbar
          body: IndexedStack(index: state.tabIndex, children: pages),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              child: BottomNavigationBar(
                currentIndex: state.tabIndex,
                onTap: (index) {
                  context.read<NavbarCubit>().loadNavbar(index);
                },
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: ColorsResources.colorsBlack,
                unselectedItemColor: ColorsResources.colorsGrey,
                selectedLabelStyle: tsLabelLargeSemiBold(
                  ColorsResources.colorsBlack,
                ),
                unselectedLabelStyle: tsLabelLargeMedium(
                  ColorsResources.colorsGrey,
                ),
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Image.asset(
                        IconsThemes.iconHomeNavbar,
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Image.asset(
                        IconsThemes.iconCompassNavbar,
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Image.asset(
                        IconsThemes.iconTripPlannerNavbar,
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
                    label: 'Trip Planner',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Image.asset(
                        IconsThemes.iconTreasureNavbar,
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
                    label: 'Quest',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Image.asset(
                        IconsThemes.iconAccount,
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
                    label: 'Account',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
