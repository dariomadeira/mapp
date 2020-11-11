import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarGeneral extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: SvgPicture.asset(
        'assets/svgs/logo.svg',
        semanticsLabel: 'Manno App',
        width: 130,
      ),
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize {
    return new Size.fromHeight(kToolbarHeight);
  }
}
