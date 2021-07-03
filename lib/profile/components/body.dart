import 'package:chat_application/auth_screen.dart';
import 'package:chat_application/profile/components/myacc.dart';
import 'package:flutter/material.dart';

import './profile_picture.dart';
import './profile_section_bar.dart';
import '../../../size_config.dart';
import '../../main.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(40)),
          ProfilePicture(),
          SizedBox(height: getProportionateScreenHeight(60)),
          ProfileSectionButton(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => myacc()),
              );
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: loginUserName.toString(),
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
