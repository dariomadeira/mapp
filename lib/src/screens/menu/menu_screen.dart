import 'package:flutter/material.dart';
import 'package:mozoapp/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('menu'),
            Image.network(
              Provider.of<UserProvider>(context).getUserImagePath,
            ),
            Text(Provider.of<UserProvider>(context).getUserName),
          ],
        ),
     ),
   );
  }
}