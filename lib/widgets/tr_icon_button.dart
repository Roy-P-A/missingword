import 'package:flutter/material.dart';
//import 'package:toffee_ride/controllers/audio_controller.dart';

class TRIconButton extends StatefulWidget {
  const TRIconButton(
      {Key? key,
      required this.padding,
      required this.icon,
      required this.iconSize,
      required this.isEnabled,
      required this.onPressed})
      : super(key: key);

  final EdgeInsetsGeometry padding;
  final Widget icon;
  final double iconSize;
  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  State<TRIconButton> createState() => _TRIconButtonState();
}

class _TRIconButtonState extends State<TRIconButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !widget.isEnabled,
      child: GestureDetector(
        child: Transform.scale(
          scale: isTapped ? 0.9 : 1.0,
          child: IconButton(
              padding: widget.padding,
              icon: MouseRegion(
                cursor: SystemMouseCursors.basic,
                child: widget.icon,
              ),
              iconSize: widget.iconSize,
              onPressed: null),
        ),
        onTapDown: (TapDownDetails event) {
          //AudioController.to.play(soundType: SoundType.buttonClick);
          setState(() {
            isTapped = true;
          });
        },
        onTapCancel: () {
          setState(() {
            isTapped = false;
          });
        },
        onTapUp: (TapUpDetails event) async {
          setState(() {
            isTapped = false;
          });
          widget.onPressed?.call();
        },
      ),
    );
  }
}