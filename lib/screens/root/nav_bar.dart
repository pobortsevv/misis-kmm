import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:misis/figma/icons.dart';

class ScaffoldNavBar extends StatelessWidget {
  const ScaffoldNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      key:  UniqueKey(),
      tabBuilder: (context, index) => navigationShell,
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(FigmaIcons.calendar), label: 'Расписание'),
          BottomNavigationBarItem(icon: Icon(FigmaIcons.settings), label: 'Настройки'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}