import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/finance.dart';

import './chart.dart';

class Contents extends StatefulWidget {
  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  final _amountController = TextEditingController();
  final _interestController = TextEditingController();
  final _yearsController = TextEditingController();

  var _currentAmount = 1000.0;
  var _currentInterest = 8.0;
  var _currentYears = 3;
  var _futureValue = 0.0;
  var _investedValue = 1000.0;
  var _widthFactor = 0.0;

  double _fvCalculate(double amount, double interest, int years) {
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
    print(_investedValue);
    print(_futureValue);
    print(_widthFactor);
    return _futureValue;
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
          onChanged: (newValue) {
            setState(() {
              _currentAmount = double.parse(newValue);
            });
          },
          controller: _amountController,
          autofocus: true,
        ),
        Slider(
          value: _currentAmount.toDouble(),
          min: 0.0,
          max: 100000.0,
          divisions: 10,
          label: '$_currentAmount',
          onChanged: (double newValue) {
            setState(() {
              _currentAmount = newValue.roundToDouble();
              _amountController.text =
                  newValue.roundToDouble().toStringAsFixed(0);
            });
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Interest',
            labelStyle: Theme.of(context).textTheme.headline6,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (newValue) {
            setState(() {
              _currentInterest = double.parse(newValue);
            });
          },
          controller: _interestController,
          autofocus: true,
        ),
        Slider(
          value: _currentInterest.toDouble(),
          min: 0.0,
          max: 50.0,
          divisions: 10,
          label: '$_currentInterest',
          onChanged: (double newValue) {
            setState(() {
              _currentInterest = newValue.roundToDouble();
              _interestController.text =
                  newValue.roundToDouble().toStringAsFixed(0);
            });
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Years',
            labelStyle: Theme.of(context).textTheme.headline6,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (newValue) {
            setState(() {
              _currentYears = int.parse(newValue);
            });
          },
          controller: _yearsController,
          autofocus: true,
        ),
        Slider(
          value: _currentYears.toDouble(),
          min: 0.0,
          max: 50.0,
          divisions: 10,
          label: '$_currentYears',
          onChanged: (double newValue) {
            setState(() {
              _currentYears = newValue.round();
              _yearsController.text = newValue.round().toStringAsFixed(0);
            });
          },
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
