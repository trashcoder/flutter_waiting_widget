import 'package:flutter/material.dart';

class Waiting extends StatelessWidget {
  final bool disable;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final double textSize;
  final Color circleColor;
  const Waiting(
      {required this.disable,
      required this.width,
      required this.height,
      required this.backgroundColor,
      required this.text,
      required this.textColor,
      required this.textSize,
      required this.circleColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (disable) {
      return SizedBox(width: width, height: height);
    }
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            direction: Axis.vertical,
            children: [
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: textSize),
              ),
              _ConnectingAnimation(
                circleColor: circleColor,
              )
            ]),
      ),
    );
  }
}

class _ConnectingAnimation extends StatelessWidget {
  final Color circleColor;
  const _ConnectingAnimation({required this.circleColor});

  @override
  Widget build(BuildContext context) {
    const double size = 20;
    return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AnimatedCircle(
            size: size,
            circleColor: circleColor,
            delay: const Duration(milliseconds: 0),
          ),
          AnimatedCircle(
            size: size,
            circleColor: circleColor,
            delay: const Duration(milliseconds: 150),
          ),
          AnimatedCircle(
            size: size,
            circleColor: circleColor,
            delay: const Duration(milliseconds: 300),
          ),
          AnimatedCircle(
            size: size,
            circleColor: circleColor,
            delay: const Duration(milliseconds: 450),
          ),
          AnimatedCircle(
            size: size,
            circleColor: circleColor,
            delay: const Duration(milliseconds: 600),
          ),
        ]);
  }
}

class AnimatedCircle extends StatefulWidget {
  final double size;
  final Duration delay;
  final Color circleColor;
  const AnimatedCircle(
      {required this.size,
      required this.delay,
      required this.circleColor,
      super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    Future.delayed(widget.delay, () {
      _animationController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Center(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                  width: (widget.size + (10 * _animationController.value)),
                  height: (widget.size + (10 * _animationController.value)),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: widget.circleColor));
            }),
      ),
    );
  }
}
