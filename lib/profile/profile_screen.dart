import 'package:flutter/material.dart';

import './components/body.dart';
import '../../size_config.dart';
import '../custom_bottom_navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Merhaba"),
      ),
      body: Body(),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedMenu: Menu.profile),
    );
  }
}
