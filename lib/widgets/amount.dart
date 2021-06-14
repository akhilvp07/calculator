import 'package:flutter/material.dart';

import '../assets/constants.dart' as Constants;

class Amount extends StatelessWidget {
  final Function amountChanged;
  final amountController;
  final currentAmount;
  Amount(this.amountChanged, this.amountController, this.currentAmount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Monthly Investment Amount',
            labelStyle: Theme.of(context).textTheme.headline6,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (newValue) => amountChanged(newValue),
          controller: amountController,
          autofocus: true,
        ),
        Slider(
          value: currentAmount,
          min: 0.0,
          max: Constants.MAX_AMOUNT,
          label: '$currentAmount',
          onChanged: (newValue) => amountChanged(newValue.toString()),
        ),
      ],
    );
  }
}
