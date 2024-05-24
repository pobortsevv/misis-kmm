import 'package:flutter/cupertino.dart';
import 'package:misis/figma/icons.dart';
import 'package:misis/figma/styles.dart';
import 'package:misis/mvvm/observer.dart';
import 'package:misis/screens/error/error_widget_screen.dart';
import 'package:misis/screens/settings/events/events.dart';
import 'package:misis/screens/settings/settings_view_model.dart';
import 'package:misis/screens/settings/widgets/profile_header_widget.dart';
import 'package:misis/widgets/misis_progress_indicator/cupertino_list_tile.dart';
import 'package:misis/widgets/misis_progress_indicator/misis_progress_indicator.dart';
    
class SettingsScreen extends StatefulWidget {
  final SettingsViewModel vm;

  const SettingsScreen({super.key, required this.vm});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> implements EventObserver {
  LoadingState _state = LoadingState.isLoading;
  SettingsDataSource _dataSource = SettingsDataSource.empty();

  @override
  void initState() {
    widget.vm.subscribe(this);
    widget.vm.loadProfile();
    super.initState();
  }

  @override
  void dispose() {
    widget.vm.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch(_state) {
      LoadingState.isLoading => const Center(child: MisisProgressIndicator()),

      LoadingState.dataLoaded => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(bottom: BorderSide(color: CupertinoTheme.of(context).barBackgroundColor))
        ),
        child: SafeArea(child:
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  ProfileHeaderWidget(
                    profileName: _dataSource.profileName,
                    profileStatus: _dataSource.profileStatus,
                    filialName: _dataSource.filialName,
                  ),
                  CupertinoListItemWidget(
                    leading: const Icon(FigmaIcons.paint, color: FigmaColors.texticonsPrimaruLight),
                    title: const Text("Тема"),
                    onTap: () => {}
                  ),
                  CupertinoListItemWidget(
                    leading: const Icon(FigmaIcons.star, color: FigmaColors.texticonsPrimaruLight),
                    title: const Text("Оцените нас"),
                    onTap: () => { widget.vm.openRateUsForm() }
                  ),
                  CupertinoListItemWidget(
                    leading: const Icon(FigmaIcons.link, color: FigmaColors.texticonsPrimaruLight),
                    title: const Text("Ссылки"),
                    onTap: () => {}
                  ),
                  CupertinoListItemWidget(
                    leading: const Icon(CupertinoIcons.square_arrow_left, color: CupertinoColors.systemRed),
                    trailing: null,
                    title: const Text("Выйти", style: TextStyle(color: CupertinoColors.systemRed)),
                    onTap: () => widget.vm.logout(context)
                  )
                ],
              ),
            ),
          )
        )
      ),

      LoadingState.loadingError => ErrorWidgetScreen(onRetryButtonTap: widget.vm.loadProfile)
    };
  }
  
  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _state = LoadingState.isLoading;
      });
    } else if (event is DataLoadedEvent) {
      setState(() {
        _state = LoadingState.dataLoaded;
        _dataSource = event.dataSource;
      });
    } else if (event is LoadingErrorEvent) {
      setState(() {
        _state = LoadingState.loadingError;
      });
    }
  }
}
