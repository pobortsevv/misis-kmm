import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:misis/profile_manager/profile_manager.dart';
import 'package:misis/provider/provider.dart';
import 'package:misis/router/login_router.dart';
import 'package:misis/screens/error/error_widget_screen.dart';
import 'package:misis/screens/root/nav_bar.dart';
import 'package:misis/screens/schedule/schedule_screen.dart';
import 'package:misis/screens/schedule/schedule_view_model.dart';
import 'package:misis/screens/settings/links_screen/links_screen.dart';
import 'package:misis/screens/settings/settings_screen.dart';
import 'package:misis/screens/settings/settings_view_model.dart';

final class AppRouter {
  final ProfileManager _profileManager;
  final LoginRouter _loginRouter;
  final AppProvider _provider;
  late final ScheduleViewModel scheduleViewModel;

  AppRouter({
    required AppProvider provider,
    required ProfileManager profileManager
  }) : _profileManager = profileManager,
   _provider = provider,
   _loginRouter = LoginRouter(provider: provider, profileManager: profileManager);

  GoRouter getRouter() {
    return GoRouter(
      initialLocation: '/schedule',
      routes: _loginRouter.getRoutes() +
        [
          StatefulShellRoute.indexedStack(
            builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
              return ScaffoldNavBar(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    name: 'schedule',
                    path: '/schedule',
                    builder: (BuildContext context, GoRouterState state) {
                      _clearContextIfNeeded(context);
                      final scheduleViewModel = ScheduleViewModel(provider:_provider, profileManager: _profileManager);

                      return ScheduleScreen(vm: scheduleViewModel);
                    },
                    redirect: (context, state) async {
                      return await _profileManager.isLoggedIn() ? '/schedule' : '/login';
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    name: 'settings',
                    path: '/settings',
                    builder: (BuildContext context, GoRouterState state) {
                      // _clearContextIfNeeded(context);
                      final settingsViewModel = SettingsViewModel(profileManager: _profileManager);
                      
                      return SettingsScreen(vm: settingsViewModel);
                    },
                    routes: [
                      GoRoute(
                        name: 'theme',
                        path: 'theme',
                        builder: (BuildContext context, GoRouterState state) {
                          return Container();
                        }
                      ),
                      GoRoute(
                        name: 'links',
                        path: 'links',
                        builder: (BuildContext context, GoRouterState state) {
                          return const LinksScreen();
                        }
                      )
                    ],
                    redirect: (context, state) async {
                      final isLoggedIn = await _profileManager.isLoggedIn();
                      final isGoingToLogin = state.uri.toString() == '/login';

                      if (!isLoggedIn && !isGoingToLogin) {
                        return '/login';
                      }

                      return null;
                    }
                  ),
                ],
              ),
            ]
          ),
        ],
      errorBuilder: (context, state) {
        return ErrorWidgetScreen(onRetryButtonTap: () => context.goNamed('schedule'));
      },
    );
  }

  void _clearContextIfNeeded(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      while (context.canPop() == true) {
        context.pop();
      }
    });
  }
}
