import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ActivityConfettiWidget extends StatelessWidget {
  const ActivityConfettiWidget({
    Key? key,
    required this.confettiController
  }) : super(key: key);

  final ConfettiController confettiController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConfettiWidget(
        confettiController: confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        particleDrag: 0.05,
        emissionFrequency: 0.05,
        numberOfParticles: 50,
        gravity: 0.05,
        shouldLoop: false,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ], // manually specify the colors to be used
      ),
    );
  }
}
