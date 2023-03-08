import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
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
    final smallmobile = MediaQuery.of(context).size.width < 550;
    final tab = (MediaQuery.of(context).size.width < 1400 &&
        MediaQuery.of(context).size.width >= 650);
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: MediaQuery(
                  data: const MediaQueryData(textScaleFactor: 1),
                  child: HtmlWidget(
                    controller.question,
                    textStyle: (GetPlatform.isDesktop || tab)
                        ? Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: Colors.blue)
                        : Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: (GetPlatform.isDesktop || tab) ? 5 : 7,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (int i = 0; i < controller.wordInList.length; i++)
                        displayWordInList(i, smallmobile, context),
                    ]),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: (GetPlatform.isDesktop || tab) ? 2 : 3,
              child: EnglishKeyboard(
                controller: controller,
              ),
            ),
            const Expanded(flex: 3, child: SizedBox())
          ],
        ),
      ),
    );
  }

  Container displayWordInList(int i, bool smallmobile, BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent.shade400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Text(
                i < controller.wordInList.length
                    ? controller.wordInList[i]
                    : '',
                style: smallmobile
                    ? Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Colors.white)
                    : Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
