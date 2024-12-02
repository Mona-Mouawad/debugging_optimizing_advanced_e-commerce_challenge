

import 'package:flutter/material.dart';

class CustomAnimatedContainer extends StatefulWidget {
  const CustomAnimatedContainer({super.key});

  @override
  State<CustomAnimatedContainer> createState() =>
      _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // late Timer _timer;
  // int _counter = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    //   _startTimer();
  }
  // void _startTimer() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       _counter++;
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    // return  AnimatedContainer(
    //   duration: const Duration(seconds: 1),
    //   height: _counter % 2 == 0 ? 100 : 200,
    //   width: _counter % 2 == 0 ? 100 : 200,
    //   color: Colors.blue,
    // );
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double size = 100 + (_controller.value * 100); // expected _controller value from 0  to 1
        return Container(
          height: size,
          width: size,
          color: Colors.blue,
        );
      },
    );
  }

  @override
  void dispose() {
    // _timer.cancel();
    _controller.dispose();
    super.dispose();
  }
}
