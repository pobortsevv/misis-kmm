import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:misis/models/domain/filial.dart';
import 'package:misis/models/domain/group.dart';
import 'package:misis/models/domain/profile.dart';
import 'package:misis/models/domain/user.dart';
import 'package:misis/profile_manager/profile_manager.dart';
import 'package:misis/provider/provider.dart';
import 'package:misis/screens/login/list_screen/view_models/list_view_model.dart';

final class GroupsViewModel extends ListViewModel<Group> {
  @override
  final String title = 'Выберите группу';
  @override
  String? get loadingDisclaimer => """Список групп, может долго загружаться. 
  Иногда это занимает до 2-х минут.""";

  late List<Group> _allGroups;

  final AppProvider _provider;
  final ProfileManager _profileManager;
  final Filial _selectedFilial;

  GroupsViewModel({
    required Filial selectedFilial,
    required AppProvider provider,
    required ProfileManager profileManager
  }) : _selectedFilial = selectedFilial, _provider = provider, _profileManager = profileManager;

  @override
  void loadData() {
    notify(LoadingEvent(isLoading: true));
    _provider.fetchGroups(_selectedFilial.id).then((value) {
      _allGroups = value;
      notify(ListDataLoadedEvent(data: value));
    }).catchError((onError) {
      notify(LoadingErrorEvent(error: onError.toString()));
    });
  }

  @override
  void onTap(int id, BuildContext context) async {
    final groups = _allGroups;
    final selectedGroup = groups.firstWhere((element) => element.id == id);
    final selectedProfile = _makeProfile(selectedGroup);

    await _profileManager.addProfile(selectedProfile);

    if (context.mounted) context.goNamed(StudentsRoute.schedule.name);
  }

  Profile _makeProfile(Group selectedGroup) {
    final selectedUser = User(Status.student, selectedGroup);
    final selectedProfile = Profile(filial: _selectedFilial, user: selectedUser);

    return selectedProfile;
  }
  
  @override
  void searchListener(String text) {
    final foundGroups = _allGroups
        .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
    notify(SearchEvent(foundData: foundGroups));
  }
}

enum StudentsRoute {
  schedule
}