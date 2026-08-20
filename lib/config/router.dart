import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/login/login_screen.dart';
import '../features/auth/presentation/screens/register/register_screen.dart';
import '../features/auth/presentation/screens/splash/splash_screen.dart';
import '../features/auth/presentation/screens/forgot_password/forgot_password_screen.dart';
import '../features/auth/presentation/screens/inbox_verification_code/inbox_verification_screen.dart';
import '../features/auth/presentation/screens/create_new_password/create_new_password_screen.dart';
import '../features/navigation/presentation/screens/navbar_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/domain/entities/destination_entity.dart';
import '../features/detail_destination/presentation/screens/detail_destination_screen.dart';
import '../features/detail_destination/presentation/screens/panorama_360_screen.dart';
import '../features/detail_destination/presentation/screens/gallery_screen.dart';

class Routes {
  static const String splash = 'splash';
  static const String navbar = 'navbar';
  static const String login = 'login_screen';
  static const String register = 'register_screen';
  static const String forgotPassword = 'forgot_password_screen';
  static const String inboxVerification = 'inbox_verification_screen';
  static const String createNewPassword = 'create_new_password_screen';
  static const String home = 'home_screen';
  static const String list = 'list_screen';
  static const String detail = 'detail_screen';
  static const String maps = 'maps_screen';
  static const String detailDestination = 'detail_destination_screen';
  static const String panorama360 = 'panorama_360_screen';
  static const String gallery = 'gallery_screen';
}

CustomTransitionPage _buildSmoothTransitionPage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.05),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: child,
        ),
      );
    },
  );
}

class AppRouter {
  get router => GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        name: Routes.splash,
        path: '/splash',
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: Routes.navbar,
        path: '/navbar',
        pageBuilder: (context, state) {
          final index = state.extra as int? ?? 0;
          return _buildSmoothTransitionPage(
            context: context,
            state: state,
            child: NavbarScreen(index: index),
          );
        },
      ),
      GoRoute(
        name: Routes.login,
        path: '/login',
        pageBuilder: (context, state) {
          return _buildSmoothTransitionPage(
            context: context,
            state: state,
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
        name: Routes.register,
        path: '/register',
        pageBuilder: (context, state) {
          return _buildSmoothTransitionPage(
            context: context,
            state: state,
            child: const RegisterScreen(),
          );
        },
      ),
      GoRoute(
        name: Routes.forgotPassword,
        path: '/forgot-password',
        pageBuilder: (context, state) {
          return _buildSmoothTransitionPage(
            context: context,
            state: state,
            child: const ForgotPasswordScreen(),
          );
        },
      ),
      GoRoute(
        name: Routes.inboxVerification,
        path: '/inbox-verification',
        pageBuilder: (context, state) {
          final email = state.extra as String? ?? '';
          return _buildSmoothTransitionPage(
            context: context,
            state: state,
            child: InboxVerificationScreen(email: email),
          );
        },
      ),
      GoRoute(
        name: Routes.createNewPassword,
        path: '/create-new-password',
        pageBuilder: (context, state) {
          return _buildSmoothTransitionPage(
            context: context,
            state: state,
            child: const CreateNewPasswordScreen(),
          );
        },
      ),
      GoRoute(
        name: Routes.home,
        path: '/home',
        pageBuilder: (context, state) {
          return _buildSmoothTransitionPage(
            context: context,
            state: state,
            child: const HomeScreen(),
          );
        },
      ),
      GoRoute(
        name: Routes.detailDestination,
        path: '/detail-destination',
        pageBuilder: (context, state) {
          final destination = state.extra as DestinationEntity;
          return _buildSmoothTransitionPage(
            context: context,
            state: state,
            child: DetailDestinationScreen(destination: destination),
          );
        },
      ),
      GoRoute(
        name: Routes.panorama360,
        path: '/panorama-360',
        pageBuilder: (context, state) {
          final destination = state.extra as DestinationEntity;
          return _buildSmoothTransitionPage(
            context: context,
            state: state,
            child: Panorama360Screen(destination: destination),
          );
        },
      ),
      GoRoute(
        name: Routes.gallery,
        path: '/gallery',
        pageBuilder: (context, state) {
          final destination = state.extra as DestinationEntity;
          return _buildSmoothTransitionPage(
            context: context,
            state: state,
            child: GalleryScreen(destination: destination),
          );
        },
      ),
    ],
  );
}
