import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../missing_word_template.dart';
import 'english_keyboard.dart';

class MissingWordView extends StatelessWidget {
  MissingWordView({
    Key? key,
  }) : super(key: key);
  final MissingWordTemplateController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final smallmobile = MediaQuery.of(context).size.width < 550;
      final tab = (MediaQuery.of(context).size.width < 1400 &&
          MediaQuery.of(context).size.width >= 800);
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(controller.question,
                style: tab
                    ? Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.blue)
                    : Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Colors.blue)),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < controller.wordInList.length; i++)
                  displayWordInList(i, smallmobile, tab, context),
              ],
            ),
          ),
          SizedBox(
            height: GetPlatform.isDesktop
                ? constraints.maxHeight / 7.5
                : smallmobile
                    ? constraints.maxHeight / 7
                    : constraints.maxHeight / 6,
            child: EnglishKeyboard(
              controller: controller,
            ),
          ),
        ],
      );
    });
  }

  Widget displayWordInList(
      int i, bool smallmobile, bool tab, BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent.shade400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Text(
              i < controller.wordInList.length ? controller.wordInList[i] : '',
              style: tab
                  ? Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white)
                  : Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
