import 'package:flutter/cupertino.dart';
import 'package:misis/mvvm/observer.dart';
import 'package:misis/screens/settings/events/events.dart';
import 'package:misis/screens/settings/settings_view_model.dart';
import 'package:misis/screens/settings/widgets/profile_header_widget.dart';
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
  String _error = "";

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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: Border(bottom: BorderSide(color: CupertinoTheme.of(context).barBackgroundColor))
      ),
      child: SafeArea(
        child: switch(_state) {
          LoadingState.isLoading =>
              const Center(child: MisisProgressIndicator()),

            LoadingState.dataLoaded =>
            Center(
              child: Column(
                children: [
                  ProfileHeaderWidget(
                    profileName: _dataSource.profileName,
                    profileStatus: _dataSource.profileStatus,
                    filialName: _dataSource.filialName,
                  ),

                  CupertinoButton(child: const Text("Выйти"), onPressed: () => widget.vm.logout(context))
                ],
              ),
            ),

            LoadingState.loadingError =>
              Text(_error),
        }
      )
    );
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
        _error = event.error;
      });
    }
  }
}
