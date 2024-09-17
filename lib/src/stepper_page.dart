import 'package:flutter/material.dart';
import 'stepper_example.dart';

class StepperPage extends StatelessWidget {
  const StepperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(height: 200.0),
          child: StepperExample()),
    );
  }
}
