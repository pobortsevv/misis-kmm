import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:misis/provider/app_url.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:misis/mvvm/viewmodel.dart';
import 'package:misis/profile_manager/profile_manager.dart';
import 'package:misis/screens/settings/events/events.dart';

class SettingsViewModel extends EventViewModel {
  final ProfileManager _profileManager;

  SettingsViewModel({
    required ProfileManager profileManager
  }) : _profileManager = profileManager;

  void loadProfile() {
    notify(LoadingEvent());

    _profileManager.getProfile().then((value) {
      final dataSource = value != null ? SettingsDataSource(profile: value) : SettingsDataSource.empty();
      notify(DataLoadedEvent(dataSource: dataSource));
    }).catchError((onError) {
      notify(LoadingErrorEvent(error: onError.toString()));
    });
  }

  void openRateUsForm() async {
    await _launchURL(AppUrl.rateUsForm);
  }

  void routeToTheme(BuildContext context) {
    context.goNamed(SettingsRoute.theme.name);
  }

  void routeToLinks(BuildContext context) {
    context.pushNamed(SettingsRoute.links.name);
  }

  void logout(BuildContext context) async {
    await _profileManager.removeProfile();

    if (context.mounted) context.goNamed(SettingsRoute.schedule.name);
  }
}

extension URLLaunchHelper on SettingsViewModel {
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

enum SettingsRoute {
  theme,
  links,
  schedule
}