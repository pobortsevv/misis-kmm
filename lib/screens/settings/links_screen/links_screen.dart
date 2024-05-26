import 'package:flutter/cupertino.dart';
import 'package:misis/figma/styles.dart';
import 'package:misis/provider/app_url.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:misis/widgets/misis_progress_indicator/cupertino_list_tile.dart';
    
class LinksScreen extends StatelessWidget {

  const LinksScreen({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Ссылки'),
        border: Border(bottom: BorderSide(color: CupertinoTheme.of(context).barBackgroundColor))
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            children: [
              CupertinoListItemWidget(
                title: const Text("Google Forms"),
                subtitle: Text(
                  "Форма обращения пользователя по поводу багов и предложений",
                  style: const FigmaTextStyles().caption,
                ),
                onTap: () => _launchURL(AppUrl.bugsAndSuggestionsForm)
              ),
              CupertinoListItemWidget(
                title: const Text("Личный кабинет МИСИС"),
                onTap: () => _launchURL(AppUrl.lkMisis)
              ),
              CupertinoListItemWidget(
                title: const Text("Канвас"),
                onTap: () => _launchURL(AppUrl.canvas)
              )
            ]
          )
        )
      ),
    );
  }
}

extension URLLaunchHelper on LinksScreen {
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}