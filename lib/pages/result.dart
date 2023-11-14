import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../const.dart';

class Result extends StatefulWidget {
  final String result;
  final String bmi;

  const Result({required this.result, required this.bmi, super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1)
    ]).animate(_controller);

    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1)
    ]).animate(_controller);

    _controller.repeat();
  }

  Color getProgressColor() {
    double bmiValue = double.tryParse(widget.bmi) ?? 0.0;
    if (bmiValue <= 18.5) {
      return Colors.orange;
    } else if (bmiValue <= 25 && bmiValue > 18.5) {
      return Colors.green;
    } else if (bmiValue <= 30 && bmiValue > 25) {
      return Colors.amber;
    } else {
      return Colors.pink;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparent,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios,color: white,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Result",
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: const [darkblue, lightblue],
                    begin: _topAlignmentAnimation.value,
                    end: _bottomAlignmentAnimation.value)),
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Neumorphic(
                  padding: const EdgeInsets.all(15),
                  style: const NeumorphicStyle(
                      intensity: 8,
                      depth: 20,
                      color: Color(0xffededed),
                      boxShape: NeumorphicBoxShape.circle()),
                  child: CircularPercentIndicator(
                    animation: true,
                    animationDuration: 1200,
                    rotateLinearGradient: true,
                    radius: 100,
                    lineWidth: 20,
                    percent: 0.8,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: const Color(0xffd8dfe5),
                    progressColor: getProgressColor(),
                    center: Text(
                      widget.bmi,
                      style: const TextStyle(fontSize: 45, color: grey2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.result,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
