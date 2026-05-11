import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({Key? key, required this.currentStep, this.totalSteps = 6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: currentStep / totalSteps,
      backgroundColor: Colors.grey[800],
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    );
  }
}
