import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contents extends StatefulWidget {
  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  final _amountController = TextEditingController();
  final _interestController = TextEditingController();
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
          onSubmitted: (_) {},
          controller: _amountController,
          autofocus: true,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Interest',
            labelStyle: Theme.of(context).textTheme.headline6,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onSubmitted: (_) {},
          controller: _interestController,
          autofocus: true,
        ),
      ],
    );
  }
}
