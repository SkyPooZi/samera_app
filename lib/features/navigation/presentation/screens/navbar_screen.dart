import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/navbar_cubit.dart';

class NavbarScreen extends StatefulWidget {
  final int? index;

  const NavbarScreen({super.key, this.index});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final List<Widget> pages = [

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
    return BlocBuilder<NavbarCubit, NavbarState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.tabIndex],
          bottomNavigationBar: CircleNavBar(
            activeIcons: [
              Icon(
                Icons.home_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              Icon(
                Icons.add_box_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              Icon(
                Icons.list_alt_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
            inactiveIcons: [
              Icon(
                Icons.home_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Icon(
                Icons.add_box_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Icon(
                Icons.list_alt_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
            levels: [

            ],
            activeLevelsStyle: Theme.of(context).textTheme.bodySmall,
            inactiveLevelsStyle:
                Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
            color: Theme.of(context).cardColor,
            circleColor: Theme.of(context).cardColor,
            tabCurve: Curves.decelerate,
            iconCurve: Easing.linear,
            tabDurationMillSec: 500,
            iconDurationMillSec: 100,
            activeIndex: state.tabIndex,
            onTap: (index) {
              context.read<NavbarCubit>().loadNavbar(index);
            },
            cornerRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            shadowColor: Theme.of(context).shadowColor,
            circleShadowColor: Theme.of(context).shadowColor,
            elevation: 10,
          ),
        );
      },
    );
  }
}
