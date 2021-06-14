import 'package:flutter/material.dart';

import '../assets/constants.dart' as Constants;

class Years extends StatelessWidget {
  final Function yearsChanged;
  final yearsController;
  final currentYears;

  Years(
    this.yearsChanged,
    this.yearsController,
    this.currentYears
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Years',
            labelStyle: Theme.of(context).textTheme.headline6,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (newValue) => yearsChanged(newValue),
          controller: yearsController,
          autofocus: true,
        ),
        Slider(
          value: currentYears.toDouble(),
          min: 0.0,
          max: Constants.MAX_YEARS,
          label: '$currentYears',
          onChanged: (newValue) => yearsChanged(newValue.toString()),
        )
      ],
    );
  }
}
