import 'package:go_router/go_router.dart';

import '../features/auth/presentation/screens/login/login_screen.dart';
import '../features/auth/presentation/screens/register/register_screen.dart';
import '../features/auth/presentation/screens/splash/splash_screen.dart';
import '../features/navigation/presentation/screens/navbar_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

class Routes {
  static const String splash = 'splash';
  static const String navbar = 'navbar';
  static const String login = 'login_screen';
  static const String register = 'register_screen';
  static const String home = 'home_screen';
  static const String list = 'list_screen';
  static const String detail = 'detail_screen';
  static const String maps = 'maps_screen';
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
          return NoTransitionPage(child: NavbarScreen(index: index));
        },
      ),
      GoRoute(
        name: Routes.login,
        path: '/login',
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: LoginScreen());
        },
      ),
      GoRoute(
        name: Routes.register,
        path: '/register',
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: RegisterScreen());
        },
      ),
      GoRoute(
        name: Routes.home,
        path: '/home',
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: HomeScreen());
        },
      ),
    ],
  );
}
