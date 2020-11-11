import 'package:flutter/material.dart';
import 'package:mozoapp/src/colors/custom_color_scheme.dart';
import 'package:mozoapp/src/localizations/app_localization.dart';

class LoadingWidget extends StatelessWidget {

  final double loadingWidth;
  final double loadingHeight;
  final String loadingMessage;

  LoadingWidget({
    this.loadingWidth = double.infinity,
    this.loadingHeight = double.infinity, 
    this.loadingMessage = "general.loading",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  this.loadingWidth,
      height: this.loadingHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.redNormal,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context).translate(this.loadingMessage),
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.grayNormal,
            ),
          ),
        ],
      ),
    );
  }
}
