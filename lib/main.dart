import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/auth/auth_page.dart';
import 'package:weather_app/widgets/home_nav.dart';
import './pages/pages.dart';

bool? seenOnBoard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // to show status bar
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]
  );

  Future seen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    seenOnBoard = pref.getBool('seenOnBoard') ?? false;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        dividerColor: Colors.black,
        textTheme: GoogleFonts.manropeTextTheme(
          Theme.of(context).textTheme
        ),
      ),
      home: seenOnBoard == false ? OnBoardingPage() : getScreenId(),
    );
  }

  Widget getScreenId() {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('home page first condition');
            return HomeNav(currentUserId: snapshot.data!.uid);
          } else {
            print('auth page last condition');
            return AuthPage();
          }
        });
  }
}