import 'package:flutter/material.dart';

import '../assets/constants.dart' as Constants;
import '../assets/enums.dart' as Enums;

class Amount extends StatelessWidget {
  final Function amountChanged;
  final amountController;
  final int currentAmount;
  final Enums.RadioValue radioValue;

  Amount(
    this.amountChanged,
    this.amountController,
    this.currentAmount,
    this.radioValue,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        radioValue == Enums.RadioValue.sip
            ? TextField(
                decoration: InputDecoration(
                  labelText: 'Monthly Investment Amount',
                  labelStyle: Theme.of(context).textTheme.headline6,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (newValue) => amountChanged(newValue),
                controller: amountController,
                autofocus: true,
              )
            : TextField(
                decoration: InputDecoration(
                  labelText: 'Total Investment Amount',
                  labelStyle: Theme.of(context).textTheme.headline6,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (newValue) => amountChanged(newValue),
                controller: amountController,
                autofocus: true,
              ),
        Slider(
          value: currentAmount.toDouble(),
          divisions: (Constants.MAX_AMOUNT / 1000).round(),
          min: 0.0,
          max: Constants.MAX_AMOUNT.toDouble(),
          label: currentAmount.toString(),
          onChanged: (newValue) => amountChanged(newValue.toString()),
        ),
      ],
    );
  }
}
