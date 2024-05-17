import 'package:flutter/cupertino.dart';
import 'package:misis/figma/styles.dart';
    
class ErrorWidgetScreen extends StatelessWidget {
  final Function onRetryButtonTap;

  const ErrorWidgetScreen({super.key, required this.onRetryButtonTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(child: Container()),
            Center(
              child: Column(
                children: [
                  const Image(image: AssetImage('assets/images/heart.png')),
                  const SizedBox(height: 46),
                  Text("Что-то пошло не так!", style: const FigmaTextStyles().title),
                  Text("Пожалуйста повторите позже", style: const FigmaTextStyles().secondaryBody)
                ],
              ),
            ),
            Expanded(child: Container()),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async => onRetryButtonTap(),
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: FigmaColors.primary
                  ),
                  child: Center(child: Text("Повторить", style: const FigmaTextStyles().darkTitle)),
                ),
              )
            ),
          ]
        )
      ),
    );
  }
}