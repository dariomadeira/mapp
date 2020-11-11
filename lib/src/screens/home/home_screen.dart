import 'package:flutter/material.dart';
import 'package:mozoapp/src/widgets/app_bar_general_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:mozoapp/src/localizations/app_localization.dart';
import 'package:mozoapp/src/colors/custom_color_scheme.dart';
import 'package:mozoapp/src/screens/historial/historial_screen.dart';
import 'package:mozoapp/src/screens/menu/menu_screen.dart';
import 'package:mozoapp/src/screens/order/order_screen.dart';
import 'package:mozoapp/src/screens/tickets/tickets_screen.dart';
import 'package:mozoapp/src/customs/custom_mozo_icons_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedTab = _SelectedTab.menu;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneral(),
      body: Column(
        children: [
          Expanded(
            child: _callScreen(_SelectedTab.values.indexOf(_selectedTab)),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: SalomonBottomBar(
              currentIndex: _SelectedTab.values.indexOf(_selectedTab),
              onTap: _handleIndexChanged,
              items: [
                SalomonBottomBarItem(
                  unselectedColor: Theme.of(context).colorScheme.grayNormal,
                  icon: Icon(CustomMozoIcons.menu),
                  title: Text(AppLocalizations.of(context).translate("main.menu")),
                  selectedColor: Theme.of(context).colorScheme.redNormal,
                ),
                SalomonBottomBarItem(
                  unselectedColor: Theme.of(context).colorScheme.grayNormal,
                  icon: Icon(CustomMozoIcons.order),
                  title: Text(AppLocalizations.of(context).translate("main.order")),
                  selectedColor: Theme.of(context).colorScheme.redNormal,
                ),
                SalomonBottomBarItem(
                  unselectedColor: Theme.of(context).colorScheme.grayNormal,
                  icon: Icon(CustomMozoIcons.tickets),
                  title: Text(AppLocalizations.of(context).translate("main.tickets")),
                  selectedColor: Theme.of(context).colorScheme.redNormal,
                ),
                SalomonBottomBarItem(
                  unselectedColor: Theme.of(context).colorScheme.grayNormal,
                  icon: Icon(CustomMozoIcons.location),
                  title: Text(AppLocalizations.of(context).translate("main.historial")),
                  selectedColor: Theme.of(context).colorScheme.redNormal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _callScreen(int index) {
    switch (index) {
      case 0:
        return MenuScreen();
        break;
      case 1:
        return OrderScreen();
        break;
      case 2:
        return TicketsScreen();
        break;
      case 3:
        return HistorialScreen();
        break;
      default:
        return MenuScreen();
        break;
    }
  }

}

enum _SelectedTab { menu, orders, tickets, historial }