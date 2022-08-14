import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AmimationFeature extends StatelessWidget {
  const AmimationFeature({
    Key? key,
    required bool animationA,
    required bool animationB,
    required bool animationC,
    required bool animationD,
    required bool animationE,
    required this.height,
    required this.width,
  })  : _animationA = animationA,
        _animationB = animationB,
        _animationC = animationC,
        _animationD = animationD,
        _animationE = animationE,
        super(key: key);

  final bool _animationA;
  final bool _animationB;
  final bool _animationC;
  final bool _animationD;
  final bool _animationE;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: _animationD ? 900 : 2500),
          curve:
              _animationD ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
          height: _animationD
              ? 0
              : _animationA
                  ? height / 2
                  : 20,
          width: 20,
          // color: Colors.deepPurpleAccent,
        ),
        AnimatedContainer(
          duration: Duration(
              seconds: _animationD
                  ? 1
                  : _animationC
                      ? 2
                      : 0),
          curve: Curves.fastLinearToSlowEaseIn,
          height: _animationD
              ? height
              : _animationC
                  ? 80
                  : 20,
          width: _animationD
              ? width
              : _animationC
                  ? 250
                  : 20,
          decoration: BoxDecoration(
              color: _animationB ? Colors.white : Colors.transparent,
              //shape: _c ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: _animationD
                  ? const BorderRadius.only()
                  : BorderRadius.circular(30)),
          child: Center(
            child: _animationE
                ? AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [
                      FadeAnimatedText(
                        'SkyWatchers',
                        duration: const Duration(milliseconds: 1700),
                        textStyle: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ),
      ],
    );
  }
}
