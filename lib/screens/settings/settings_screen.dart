import 'package:flutter/cupertino.dart';
import 'package:misis/models/domain/profile.dart';
import 'package:misis/mvvm/observer.dart';
import 'package:misis/screens/settings/events/events.dart';
import 'package:misis/screens/settings/settings_view_model.dart';
import 'package:misis/widgets/misis_progress_indicator/misis_progress_indicator.dart';
    
class SettingsScreen extends StatefulWidget {
  final SettingsViewModel vm;

  const SettingsScreen({super.key, required this.vm});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> implements EventObserver {
  LoadingState _state = LoadingState.isLoading;
  Profile? _profile;
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
              Text(_profile!.user.value.name),

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
        _profile = event.profile;
      });
    } else if (event is LoadingErrorEvent) {
      setState(() {
        _state = LoadingState.loadingError;
        _error = event.error;
      });
    }
  }
}
