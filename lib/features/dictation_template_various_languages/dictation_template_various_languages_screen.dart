import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../widgets/tr_icon_button.dart';
import 'dictation_template_various_languages_controller.dart';
import 'sections/hindi_keyboard.dart';

class DictationTemplateVariousLanguagesScreen extends StatelessWidget {
  const DictationTemplateVariousLanguagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return GetBuilder<DictationTemplateVariousLanguagesController>(
        init: DictationTemplateVariousLanguagesController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.fitWidth,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
                SafeArea(
                  //bottom: false,
                  left: false,
                  right: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            flex: 7,
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: MediaQuery(
                                        data: const MediaQueryData(
                                            textScaleFactor: 0.8),
                                        child: HtmlWidget(
                                          controller.question,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              ?.copyWith(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        controller
                                                            .wordInList.length;
                                                    i++)
                                                  Container(
                                                    color: Colors
                                                        .lightBlueAccent
                                                        .shade400,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                              i <
                                                                      controller
                                                                          .wordInList
                                                                          .length
                                                                  ? controller
                                                                          .wordInList[
                                                                      i]
                                                                  : '',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline4
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .white)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: DictationHindiView(
                                      controller: controller,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        _sideMenu()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _sideMenu() {
    final DictationTemplateVariousLanguagesController controller = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: 1,
          duration: const Duration(microseconds: 300),
          child: TRIconButton(
            isEnabled: true,
            padding: EdgeInsets.zero,
            icon: Image.asset(
              "assets/images/buttons/go_back.png",
            ),
            iconSize: 60,
            onPressed: () {},
          ),
        ),
        const Spacer(),
        AnimatedOpacity(
          opacity: 1,
          duration: const Duration(microseconds: 300),
          child: TRIconButton(
            isEnabled: true,
            padding: EdgeInsets.zero,
            icon: Image.asset(
              "assets/images/buttons/repeat.png",
            ),
            iconSize: 60,
            onPressed: () {},
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        AnimatedOpacity(
          opacity: 1,
          duration: const Duration(microseconds: 300),
          child: TRIconButton(
              isEnabled: true,
              padding: EdgeInsets.zero,
              icon: Image.asset(
                "assets/images/buttons/toffee_shot.png",
              ),
              iconSize: 60,
              onPressed: () {}),
        ),
        const SizedBox(
          height: 5,
        ),
        AnimatedOpacity(
          opacity: 1,
          duration: const Duration(microseconds: 300),
          child: TRIconButton(
              isEnabled: true,
              padding: EdgeInsets.zero,
              icon: Image.asset(
                "assets/images/buttons/done.png",
              ),
              iconSize: 60,
              onPressed: () {
                controller.onTappedDoneButton();
              }),
        ),
        Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            AnimatedOpacity(
              opacity: 1,
              duration: const Duration(microseconds: 300),
              child: TRIconButton(
                  isEnabled: true,
                  padding: EdgeInsets.zero,
                  icon: Image.asset(
                    "assets/images/buttons/skip.png",
                  ),
                  iconSize: 60,
                  onPressed: () {}),
            ),
          ],
        )
      ],
    );
  }
}
