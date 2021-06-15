import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/finance.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import './chart.dart';
import '../widgets/amount.dart';
import '../widgets/interest.dart';
import '../widgets/years.dart';
import '../assets/constants.dart' as Constants;
import '../assets/enums.dart' as Enums;

class Contents extends StatefulWidget {
  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  final _amountController = TextEditingController(
    text: '1000',
  );
  final _interestController = TextEditingController(
    text: '8',
  );
  final _yearsController = TextEditingController(
    text: '3',
  );
  final indianCurrency = NumberFormat.currency(locale: "HI", name: "₹ ");

  int _currentAmount = 1000;
  var _currentInterest = 8.0;
  var _currentYears = 3.0;
  var _futureValue = 0.00;
  var _investedValue = 1000.0 * 12.0 * 3.0;
  var _widthFactor = 0.02;
  var _radioValue = Enums.RadioValue.sip;

  void _fvCalculate(int amount, double interest, double years) {
    if (_radioValue == Enums.RadioValue.sip) {
      setState(() {
        _futureValue = (Finance.fv(
                    rate: interest / 100 / 12,
                    nper: years * 12,
                    pmt: -amount,
                    pv: -amount) -
                amount)
            .roundToDouble();
        _investedValue = (years * 12 * amount).roundToDouble();
        if (_futureValue > 0)
          _widthFactor = _investedValue / _futureValue;
        else
          _widthFactor = 1;
        if (_widthFactor < 0.02) _widthFactor = 0.02;
      });
    } else {
      setState(() {
        _futureValue =
            Finance.fv(rate: interest / 100, nper: years, pmt: 0, pv: -amount)
                .roundToDouble();
        _investedValue = amount.toDouble();

        if (_futureValue > 0)
          _widthFactor = _investedValue / _futureValue;
        else
          _widthFactor = 1;
        if (_widthFactor < 0.02) _widthFactor = 0.02;
      });
    }
    print(_widthFactor);
  }

  void _yearsChanged(newValue) {
    if (double.parse(newValue) >= Constants.MAX_YEARS) {
      newValue = Constants.MAX_YEARS.toString();
    }
    setState(() {
      _currentYears = double.parse(newValue);
      if (newValue != _yearsController.text) {
        _yearsController.text = double.parse(newValue).toStringAsFixed(0);
      }
    });
    _fvCalculate(
      _currentAmount,
      _currentInterest,
      _currentYears,
    );
  }

  void _interestChanged(newValue) {
    if (double.parse(newValue) >= Constants.MAX_INTEREST) {
      newValue = Constants.MAX_INTEREST.toString();
    }
    setState(() {
      _currentInterest = double.parse(newValue);
      if (newValue != _interestController.text) {
        _interestController.text = double.parse(newValue).toStringAsFixed(0);
      }
    });
    _fvCalculate(
      _currentAmount,
      _currentInterest,
      _currentYears,
    );
  }

/* Hits when  the entered amount changes */
  void _amountChanged(String newValue) {
    if (newValue == "") {
      newValue = "0.0";
      print('Null value');
    } else if (newValue != _amountController.text) {
      _amountController.text = double.parse(newValue).round().toString();
    }
    print(newValue);
    if (double.parse(newValue) >= Constants.MAX_AMOUNT) {
      newValue = Constants.MAX_AMOUNT.toString();
    }
    setState(() {
      _currentAmount = double.parse(newValue).round();
    });
    _fvCalculate(
      _currentAmount,
      _currentInterest,
      _currentYears,
    );
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fvCalculate(
          _currentAmount,
          _currentInterest,
          _currentYears,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text('SIP'),
                leading: Radio(
                  value: Enums.RadioValue.sip,
                  groupValue: _radioValue,
                  onChanged: (Enums.RadioValue value) {
                    setState(() {
                      _radioValue = value;
                      _fvCalculate(
                        _currentAmount,
                        _currentInterest,
                        _currentYears,
                      );
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text('Lumpsum'),
                leading: Radio(
                  value: Enums.RadioValue.lumpsum,
                  groupValue: _radioValue,
                  onChanged: (Enums.RadioValue value) {
                    setState(() {
                      _radioValue = value;
                      _fvCalculate(
                        _currentAmount,
                        _currentInterest,
                        _currentYears,
                      );
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Amount(
          _amountChanged,
          _amountController,
          _currentAmount,
          _radioValue,
        ),
        Interest(
          _interestChanged,
          _interestController,
          _currentInterest,
        ),
        Years(
          _yearsChanged,
          _yearsController,
          _currentYears,
        ),
        Card(
          //height: 40,
          elevation: 4,
          shadowColor: Theme.of(context).accentColor,
          color: Theme.of(context).primaryColorLight,
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Text(
                  'Invested Amount: ',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  indianCurrency.format(_investedValue),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
        Card(
          //height: 40,
          elevation: 4,
          shadowColor: Theme.of(context).accentColor,
          color: Theme.of(context).primaryColorLight,
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Total Amount: ',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    indianCurrency.format(_futureValue),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
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
