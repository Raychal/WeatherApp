import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/auth/auth_page.dart';
import 'package:weather_app/pages/pages.dart';
import '../pages/pages.dart';

import 'package:shared_preferences/shared_preferences.dart';

bool? seenOnBoard;

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  Future seen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    seenOnBoard = pref.getBool('seenOnBoard') ?? false;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (seenOnBoard == true && snapshot.hasError) {
            return AuthPage();
          } else if (seenOnBoard == false && snapshot.hasError) {
            return OnBoardingPage();
          } else if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
