// some issues still exist on flutter
import 'package:flutter/material.dart';

class StepperExample extends StatefulWidget {
  @override
  _StepperExampleState createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      type: StepperType.horizontal,
      onStepContinue: () {
        if (_currentStep >= 4) return;
        setState(() {
          _currentStep += 1;
        });
      },
      onStepCancel: () {
        if (_currentStep <= 0) return;
        setState(() {
          _currentStep -= 1;
        });
      },
      steps: const <Step>[
        Step(
          title: Text('Step 1'),
          content: SizedBox(
            width: 25.0,
            height: 100.0,
          ),
        ),
        Step(
          title: Text('Step 2'),
          content: SizedBox(
            width: 25.0,
            height: 100.0,
          ),
        ),
        Step(
          title: Text('Step 3'),
          content: SizedBox(
            width: 100.0,
            height: 25.0,
          ),
        ),
        // Step(
        //   title: Text('Step 4'),
        //   content: SizedBox(
        //     width: 100.0,
        //     height: 100.0,
        //   ),
        // ),
        // Step(
        //   title: Text('Step 5'),
        //   content: SizedBox(
        //     width: 100.0,
        //     height: 100.0,
        //   ),
        // ),
      ],
    );
  }
}
