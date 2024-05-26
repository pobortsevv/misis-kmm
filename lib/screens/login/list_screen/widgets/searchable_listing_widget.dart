import 'package:flutter/cupertino.dart';
import 'package:misis/figma/styles.dart';
import 'package:misis/screens/login/list_screen/view_models/list_view_model.dart';

import 'list_item_widget.dart';
    
class SearchableListingWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final List<IdentifiableModel> models;
  final Function onTap;

  const SearchableListingWidget({
    required this.title,
    required this.controller,
    required this.models,
    required this.onTap,
    super.key
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: CupertinoTextField(
            controller: controller,
            placeholder: 'Поиск',
            decoration: BoxDecoration(
              border: Border.all(color: FigmaColors.primary, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(8))
            )
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: models.isNotEmpty ? ListView.builder(
              itemCount: models.length,
              itemBuilder: (BuildContext context, int index) {
                final model = models[index];
                return ListItemWidget(
                  title: model.name,
                  onTap: () async { onTap(model.id, context); }
                );
              },
            ) : const Text("К сожалению, список пуст :(")
          )
        )
      ],
    );
  }  
}