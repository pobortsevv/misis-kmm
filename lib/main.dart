import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:misis/figma/styles.dart';
import 'package:misis/profile_manager/profile_manager.dart';
import 'package:misis/profile_manager/profile_manager_imp.dart';
import 'package:misis/provider/provider.dart';
import 'package:misis/router/app_router.dart';

void main() async {
  final ProfileManager profileManager = ProfileManagerImp();
  final AppProvider provider = AppProviderImp();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await profileManager.removeProfile();

  runApp(MyApp(profileManager: profileManager, provider: provider));
}

class MyApp extends StatelessWidget {
  // TODO: Вынести ProfileManager, AppRouter и Provider в Dependecies
  late final AppRouter router;
  final ProfileManager profileManager;
  final AppProvider provider;

  MyApp({required this.profileManager, required this.provider, super.key,}) {
    router = AppRouter(provider: provider, profileManager: profileManager);
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return CupertinoApp.router(
      theme: ThemeClass.lightThemeData,
      routerConfig: router.getRouter(),
    );
  }
}