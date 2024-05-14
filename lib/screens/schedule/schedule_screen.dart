import 'package:flutter/cupertino.dart';
import 'package:misis/figma/styles.dart';
import 'package:misis/mvvm/observer.dart';
import 'package:misis/screens/schedule/events/events.dart';
import 'package:misis/screens/schedule/schedule_view_model.dart';
import 'package:misis/screens/schedule/widgets/lesson/lesson_widget.dart';
import 'package:misis/screens/schedule/widgets/lesson/time_range_widget.dart';
import 'package:misis/screens/schedule/widgets/header/weeks_widget.dart';
import 'package:misis/screens/schedule/widgets/loaded_schedule_widget.dart';
import 'package:misis/widgets/misis_progress_indicator/misis_progress_indicator.dart';
    
class ScheduleScreen extends StatefulWidget {
  final ScheduleViewModel vm;

  const ScheduleScreen({required this.vm, super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> implements EventObserver {
  LoadingState _state = LoadingState.isLoading;

  ScheduleDataSource _dataSource = ScheduleDataSource.empty();
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
        backgroundColor: FigmaColors.backgroundAccentLight,
        middle: Text(widget.vm.currentWeekType, style: CupertinoTheme.of(context).textTheme.textStyle),
        border: const Border(bottom: BorderSide(color: FigmaColors.backgroundAccentLight))
      ),
      child: SafeArea(child:
          switch (_state) {
            LoadingState.isLoading =>
              const Center(child: MisisProgressIndicator()),

            LoadingState.dataLoaded =>
              LoadedScheduleWidget(
                upperWeekViewModels: _dataSource.upperWeekViewModels, 
                bottomWeekViewModels: _dataSource.bottomWeekViewModels,
                lessons: _dataSource.lessons
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
    } else if (event is DataSourceUpdatingEvent) {
      setState((){
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