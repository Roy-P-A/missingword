import 'package:flutter/material.dart';
import '../../../../mixins/base64_mixin.dart';
import '../../../../widgets/click_ink_well.dart';
import '../missing_word_template_controller.dart';

class EnglishKeyboard extends StatelessWidget with Base64Mixin {
  final MissingWordTemplateController controller;

  EnglishKeyboard({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          Expanded(
            child: Center(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: controller.displayList
                    .map((e) => randomButton(e, constraints, context))
                    .toList(),
              ),
            ),
          ),
        ],
      );
    });
  }

  ClickInkWell randomButton(
      String e, BoxConstraints constraints, BuildContext context) {
    return ClickInkWell(
      onTap: () => controller.onTappedKeyboardButton(e),
      child: Container(
        width: constraints.maxWidth / controller.englishKeyList.length,
        decoration: BoxDecoration(
          color: const Color(0xFF004AAD),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.yellow, width: 2),
        ),
        child: Center(
          child: Text(
            e,
            textScaleFactor: 1,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
