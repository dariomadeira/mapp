import 'package:flutter/material.dart';
import 'package:mozoapp/src/colors/custom_color_scheme.dart';

class GeneralButtonWidget extends StatelessWidget {
  final String btnText;
  final int styleBtn;
  final Function buttonAction;
  GeneralButtonWidget({
    @required this.btnText,
    this.styleBtn = 0,
    @required this.buttonAction,
  });
  @override
  Widget build(BuildContext context) {
    EdgeInsets theFace;
    BorderRadius theBorder;
    if (this.styleBtn == 0) {
      theFace = EdgeInsets.symmetric(horizontal: 0 ,vertical: 0);
      theBorder = BorderRadius.circular(5.0);
    } else if (this.styleBtn == 1) {
      theFace = EdgeInsets.symmetric(horizontal: 30.0 ,vertical: 12.0);
      theBorder = BorderRadius.circular(30.0);
    }
    return RaisedButton(
      elevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      color: Theme.of(context).colorScheme.redNormal,
      textColor: Colors.white,
      onPressed: this.buttonAction,
      shape: RoundedRectangleBorder(
        borderRadius: theBorder,
      ),
      child: Container(
        padding: theFace,
        child: Text(
          this.btnText,
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}