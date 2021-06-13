import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/finance.dart';

import './chart.dart';

class Contents extends StatefulWidget {
  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  static const MAX_AMOUNT = 100000.0;
  static const MAX_INTEREST = 50.0;
  static const MAX_YEARS = 50.0;

  final _amountController = TextEditingController(
    text: '1000',
  );
  final _interestController = TextEditingController(
    text: '8',
  );
  final _yearsController = TextEditingController(
    text: '3',
  );

  var _currentAmount = 1000.0;
  var _currentInterest = 8.0;
  var _currentYears = 3.0;
  var _futureValue = 0.0;
  var _investedValue = 1000.0;
  var _widthFactor = 0.0;

  double _fvCalculate(double amount, double interest, double years) {
    _futureValue = Finance.fv(
            rate: interest / 100 / 12,
            nper: years * 12,
            pmt: -amount,
            pv: -amount) -
        amount;
    _investedValue = years * 12 * amount;
    setState(() {
      if (_futureValue != 0)
        _widthFactor = _investedValue / _futureValue;
      else
        _widthFactor = 0.5;
      if (_widthFactor <= 0) _widthFactor = 0.5;
    });
    return _futureValue;
  }

  void _yearsChanged(newValue) {
    if (double.parse(newValue) >= MAX_YEARS) {
      newValue = MAX_YEARS.toString();
    }
    setState(() {
      _currentYears = double.parse(newValue);
      if (newValue != _yearsController.text) {
        _yearsController.text = double.parse(newValue).toStringAsFixed(0);
      }
    });
  }

  void _interestChanged(newValue) {
    if (double.parse(newValue) >= MAX_INTEREST) {
      newValue = MAX_INTEREST.toString();
    }
    setState(() {
      _currentInterest = double.parse(newValue);
      if (newValue != _interestController.text) {
        _interestController.text = double.parse(newValue).toStringAsFixed(0);
      }
    });
  }

/* Hits when  the entered amount changes */
  void _amountChanged(String newValue) {
    if (double.parse(newValue) >= MAX_AMOUNT) {
      newValue = MAX_AMOUNT.toString();
    }
    setState(() {
      _currentAmount = double.parse(newValue);
      if (newValue != _amountController.text) {
        _amountController.text = double.parse(newValue).toStringAsFixed(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Amount',
            labelStyle: Theme.of(context).textTheme.headline6,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (newValue) => _amountChanged(newValue),
          controller: _amountController,
          autofocus: true,
        ),
        Slider(
          value: _currentAmount,
          min: 0.0,
          max: MAX_AMOUNT,
          divisions: 10,
          label: '$_currentAmount',
          onChanged: (newValue) => _amountChanged(newValue.toString()),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Interest',
            labelStyle: Theme.of(context).textTheme.headline6,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (newValue) => _interestChanged(newValue),
          controller: _interestController,
          autofocus: true,
        ),
        Slider(
          value: _currentInterest.toDouble(),
          min: 0.0,
          max: MAX_INTEREST,
          divisions: 10,
          label: '$_currentInterest',
          onChanged: (newValue) => _interestChanged(newValue.toString()),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Years',
            labelStyle: Theme.of(context).textTheme.headline6,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (newValue) => _yearsChanged(newValue),
          controller: _yearsController,
          autofocus: true,
        ),
        Slider(
          value: _currentYears.toDouble(),
          min: 0.0,
          max: MAX_YEARS,
          divisions: 10,
          label: '$_currentYears',
          onChanged: (newValue) => _yearsChanged(newValue.toString()),
        ),
        Container(
          height: 40,
          child: Text(
            _fvCalculate(
              _currentAmount,
              _currentInterest,
              _currentYears,
            ).roundToDouble().toStringAsFixed(0),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          child: Chart(_widthFactor),
          height: 100,
          width: 150,
        ),
      ],
    );
  }
}
