import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozoapp/src/colors/custom_color_scheme.dart';

class SpecialButtonWidget extends StatelessWidget {
  final String btnText;
  final Function buttonAction;
  final int styleBtn;
  SpecialButtonWidget({
    @required this.btnText,
    @required this.buttonAction,
    @required this.styleBtn,
  });
  @override
  Widget build(BuildContext context) {
    final viewWidth = MediaQuery.of(context).size.width;
    return RaisedButton(
      elevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      color: Colors.white,
      textColor: Theme.of(context).colorScheme.grayDark,
      onPressed: this.buttonAction,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.grayDark,
          width: 1,
          style: BorderStyle.solid
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Container(
        padding: EdgeInsets.only(left: viewWidth / 5),
        child: Row(
          children: [
            (this.styleBtn == 0)
            ? SvgPicture.asset(
              "assets/svgs/facebookLogo.svg",
              width: 24,
              height: 24,
            )
            : SvgPicture.asset(
              "assets/svgs/googleLogo.svg",
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              this.btnText,
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
