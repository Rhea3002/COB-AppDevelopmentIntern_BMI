import 'dart:math';

class Calculator {
Calculator({
    required this.height,
    required this.weight,
  });
  final double height;
  final int weight;

  double _bmi = 0;

  String calucutateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String result() {
    if (_bmi < 18.5) {
      return 'Your BMI is below the healthy range. You may need to gain weight.';
    } else if (_bmi < 25) {
      return 'Your BMI is within the healthy range. Keep up the good work!';
    } else if (_bmi < 30) {
      return 'Your BMI is above the healthy range. You may need to lose weight.';
    } else {
      return 'Your BMI is in the obese range. You should talk to a healthcare professional about ways to improve your health.';
    }
  }
}