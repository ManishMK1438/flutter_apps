import 'dart:math';

class CalculatorBrain {
  final int height;
  final int weight;
  double _bmi = 0;

  CalculatorBrain({this.height, this.weight});

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(2);
  }

  String getResult() {
   if(_bmi >= 25.0){
     return 'Overweight!';
   }else if(_bmi > 18.5){
     return 'Normal!';
   }else{
     return 'Underweight!';
   }
  }

  String getSuggestion() {
    if (_bmi >= 25.0) {
      return 'Your weight is too much! You need to eat healthy exercise more.';
    } else if (_bmi > 18.5) {
      return 'Your weight is normal. Congratulations!! You take good care of your body.';
    } else {
      return 'Your weight is too low! You need to eat more!';
    }
  }
}
