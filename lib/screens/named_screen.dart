import 'package:flutter/cupertino.dart';

class EmptyScreen extends StatelessWidget {
  final String title;
  // final Profile profile;

  const EmptyScreen({required this.title, /*required this.profile, */super.key});
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(title),
          border: Border(bottom: BorderSide(color: CupertinoTheme.of(context).barBackgroundColor))
        ),
        child: Container()
    );
  }
}