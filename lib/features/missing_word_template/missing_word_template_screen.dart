import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:missingword/features/missing_word_template/sections/english_keyboard.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/tr_icon_button.dart';

import 'missing_word_template_controller.dart';

class MissingWordTemplateScreen extends StatelessWidget {
  const MissingWordTemplateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return GetBuilder<MissingWordTemplateController>(
        init: MissingWordTemplateController(),
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
                  right: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [MissingWordView(), _sideMenu()],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _sideMenu() {
    final MissingWordTemplateController controller = Get.find();

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
            iconSize: iconSize,
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
            iconSize: iconSize,
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
              iconSize: iconSize,
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
              iconSize: iconSize,
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
                  iconSize: iconSize,
                  onPressed: () {}),
            ),
          ],
        )
      ],
    );
  }
}

class MissingWordView extends StatelessWidget {
  MissingWordView({
    Key? key,
  }) : super(key: key);
  final MissingWordTemplateController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final smallmobile = MediaQuery.of(context).size.height < 500;
    final tab = (MediaQuery.of(context).size.height < 1000 &&
        MediaQuery.of(context).size.height >= 650);
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
                    textStyle: smallmobile
                        ? Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: Colors.blue)
                        : Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: (GetPlatform.isDesktop || tab) ? 6 : 7,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (int i = 0; i < controller.wordInList.length; i++)
                        Container(
                          color: Colors.lightBlueAccent.shade400,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
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
                        ),
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
}
