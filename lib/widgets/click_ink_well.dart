import 'package:flutter/material.dart';
//import 'package:toffee_ride/controllers/audio_controller.dart';

class ClickInkWell extends StatelessWidget {
  const ClickInkWell({Key? key, required this.child, this.onTap})
      : super(key: key);

  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //AudioController.to.play(soundType: SoundType.buttonClick);
        onTap?.call();
      },
      child: child,
    );
  }
}
