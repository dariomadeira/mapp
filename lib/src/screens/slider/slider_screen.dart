import 'package:flutter/material.dart';
import 'package:mozoapp/src/localizations/app_localization.dart';
import 'package:mozoapp/src/preferences/preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozoapp/src/helpers/svg_helper.dart';
import 'package:mozoapp/src/widgets/loading_widget.dart';
import 'package:mozoapp/src/widgets/slideshow_widget.dart';
import 'package:mozoapp/src/colors/custom_color_scheme.dart';

class SliderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
        ),
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                height: 24,
                child: SvgPicture.asset("assets/svgs/logo.svg"),
              ),
              Expanded(
                child: Container(
                  child: _WelcomeSlider(),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

class _WelcomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pref = new AppPreferences();
    return FutureBuilder(
      future: Future.wait([
        loadSvg(context, "assets/svgs/1.svg"),
        loadSvg(context, "assets/svgs/2.svg"),
        loadSvg(context, "assets/svgs/3.svg"),
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return LoadingWidget();
        }
        return Slideshow(
            dotColorSelect: Theme.of(context).colorScheme.redNormal,
            dotsColor: Theme.of(context).colorScheme.grayLight,
            dotSizeSelect: 14,
            dotSizeNormal: 10,
            dotsTop: false,
            slides: <Widget>[
              SvgPicture.asset("assets/svgs/1.svg"),
              SvgPicture.asset("assets/svgs/2.svg"),
              SvgPicture.asset("assets/svgs/3.svg"),
            ],
            titles: <String>[
              AppLocalizations.of(context).translate("welcome.slider1.title"),
              AppLocalizations.of(context).translate("welcome.slider2.title"),
              AppLocalizations.of(context).translate("welcome.slider3.title"),
            ],
            descriptions: <String>[
              AppLocalizations.of(context).translate("welcome.slider1.description"),
              AppLocalizations.of(context).translate("welcome.slider2.description"),
              AppLocalizations.of(context).translate("welcome.slider3.description"),
            ],
            finalsliderbutton: () {
              pref.welcome = true;
              Navigator.pushReplacementNamed(context, 'login');
            });
      },
    );
  }
}
