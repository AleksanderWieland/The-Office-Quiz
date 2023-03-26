import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../const.dart';

class BadAnswerPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    late AnimationController _controller = useAnimationController(
        duration: const Duration(milliseconds: 700), initialValue: 0.75);
    final Tween<double> _tween = Tween(begin: 0.75, end: 0.9);
    ConfettiController _confettiController =
        ConfettiController(duration: Duration(seconds: answerPageTimer));
    _confettiController.play();
    Random random = Random();
    _controller.repeat(reverse: true);
    useMemoized(() async {
      Timer(Duration(seconds: answerPageTimer), () {
        _controller.stop();
        Navigator.pop(context, 'Cancel');
      });
    });

    int randomNumber = random.nextInt(9) + 1;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _tween.animate(CurvedAnimation(
                  parent: _controller, curve: Curves.fastLinearToSlowEaseIn)),
              child: Text(
                'BAD',
                style: answerPageTextStyle,
              ),
            ),
            ScaleTransition(
              scale: _tween.animate(CurvedAnimation(
                  parent: _controller, curve: Curves.easeInOut)),
              child: Image(
                image: AssetImage(
                  'assets/bad/bad$randomNumber.gif',
                ),
              ),
            ),
            ScaleTransition(
              scale: _tween.animate(CurvedAnimation(
                  parent: _controller, curve: Curves.fastLinearToSlowEaseIn)),
              child: Text(
                'ANSWER',
                style: answerPageTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
