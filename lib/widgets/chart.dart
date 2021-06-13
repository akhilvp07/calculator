import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final widthFactor;

  Chart(this.widthFactor);

  @override
  Widget build(BuildContext context) {
    //return LayoutBuilder(builder: (ctx, constraints) {
    return Stack(children: [
      Container(
        color: Theme.of(context).primaryColor,
      ),
      FractionallySizedBox(
        widthFactor: widthFactor,
        heightFactor: 1,
        child: Container(
          color: Theme.of(context).accentColor,
        ),
      )
    ]);
  }
}
