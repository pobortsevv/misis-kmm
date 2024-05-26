import 'package:flutter/cupertino.dart';
import 'package:misis/mvvm/observer.dart';
import 'package:misis/screens/error/error_widget_screen.dart';
import 'package:misis/screens/login/list_screen/view_models/list_view_model.dart';
import 'package:misis/widgets/misis_progress_indicator/misis_progress_indicator.dart';
import 'widgets/searchable_listing_widget.dart';

final class ListScreen extends StatefulWidget {
  final ListViewModel vm;

  const ListScreen({required this.vm, super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

final class _ListScreenState extends State<ListScreen> implements EventObserver {
  TextEditingController textEditingController = TextEditingController();

  ListLoadingState _state = ListLoadingState.isLoading;
  List<IdentifiableModel> _models = [];

  @override
  void initState() {
    widget.vm.subscribe(this);
    widget.vm.loadData();

    super.initState();
    textEditingController.addListener(() { widget.vm.searchListener(textEditingController.text); });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    widget.vm.unsubscribe(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: Border(bottom: BorderSide(color: CupertinoTheme.of(context).barBackgroundColor))
      ),
      child: SafeArea(child:
        switch (_state) {
          ListLoadingState.isLoading =>
            Center(child: MisisProgressIndicator(
              disclaimer: widget.vm.loadingDisclaimer != null 
                ? Text(widget.vm.loadingDisclaimer!, textAlign: TextAlign.center)
                : null
            )),

          ListLoadingState.dataLoaded =>
            SearchableListingWidget(
              title: widget.vm.title,
              controller: textEditingController,
              models:  _models,
              onTap: (int id, BuildContext context) => widget.vm.onTap(id, context),
            ),
              
          ListLoadingState.loadingError => ErrorWidgetScreen(onRetryButtonTap: widget.vm.loadData),
        }
      )
    );
  }
  
  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _state = ListLoadingState.isLoading;
      });
    } else if (event is ListDataLoadedEvent) {
      setState(() {
        _state = ListLoadingState.dataLoaded;
        _models = event.data;
      });
    } else if (event is LoadingErrorEvent) {
      setState(() {
        _state = ListLoadingState.loadingError;
      });
    } else if (event is SearchEvent) {
      setState(() {
        _models = event.foundData;
      });
    }
  }
}