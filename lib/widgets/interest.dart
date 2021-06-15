import 'package:flutter/material.dart';

import '../assets/constants.dart' as Constants;

class Interest extends StatelessWidget {
  final Function interestChanged;
  final interestController;
  final currentInterest;

  Interest(
    this.interestChanged,
    this.interestController,
    this.currentInterest,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Expected Annual Interest (%)',
            labelStyle: Theme.of(context).textTheme.headline6,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (newValue) => interestChanged(newValue),
          controller: interestController,
          autofocus: true,
        ),
        Slider(
          value: currentInterest.toDouble(),
          divisions: 2 * Constants.MAX_INTEREST.round() - 1,
          min: 0.5,
          max: Constants.MAX_INTEREST,
          label: '$currentInterest %',
          onChanged: (newValue) => interestChanged(newValue.toString()),
        ),
      ],
    );
  }
}
