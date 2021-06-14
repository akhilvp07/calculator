import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final widthFactor;

  Chart(this.widthFactor);

  @override
  Widget build(BuildContext context) {
    //return LayoutBuilder(builder: (ctx, constraints) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(
            color: Theme.of(context).buttonColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      FractionallySizedBox(
        widthFactor: widthFactor,
        heightFactor: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            border: Border.all(
              color: Theme.of(context).buttonColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      )
    ]);
  }
}
