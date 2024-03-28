import 'package:flutter/cupertino.dart';
import 'package:misis/models/domain/schedule.dart';
import 'package:misis/mvvm/observer.dart';
import 'package:misis/screens/schedule/events/events.dart';
import 'package:misis/screens/schedule/schedule_view_model.dart';
import 'package:misis/widgets/misis_progress_indicator/misis_progress_indicator.dart';
    
class ScheduleScreen extends StatefulWidget {
  final ScheduleViewModel vm;

  const ScheduleScreen({required this.vm, super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> implements EventObserver {
  LoadingState _state = LoadingState.isLoading;
  Schedule? _schedule;
  String _error = "";

  @override
  void initState() {
    widget.vm.subscribe(this);
    widget.vm.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Сделать динамический title', style: CupertinoTheme.of(context).textTheme.textStyle),
        border: Border(bottom: BorderSide(color: CupertinoTheme.of(context).barBackgroundColor))
      ),
      child: SafeArea(child:
          switch (_state) {
            LoadingState.isLoading =>
              const Center(child: MisisProgressIndicator()),

            LoadingState.dataLoaded =>
              Text(_schedule.toString()),
              
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
        _schedule = event.data;
      });
    } else if (event is LoadingErrorEvent) {
      setState(() {
        _state = LoadingState.loadingError;
        _error = event.error;
      });
    }
  }
}