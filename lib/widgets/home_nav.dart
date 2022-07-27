import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../screens/pages.dart';

class HomeNav extends StatefulWidget {
  final String currentUserId;

  const HomeNav({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomePage(),
        FavoritePage(),
        ProfilePage(
          currentUserId: widget.currentUserId,
          visitedUserId: widget.currentUserId,
        )
      ].elementAt(currentIndex),
      bottomNavigationBar: Container(
        color: Colors.blue[600],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
              backgroundColor: Colors.blue.shade600,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.blue.shade400,
              gap: 8,
              onTabChange: (index) => setState(() => currentIndex = index),

              padding: EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorite',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ]
          ),
        ),
      ),
    );
  }
}
