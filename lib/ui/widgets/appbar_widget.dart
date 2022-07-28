import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {

  return AppBar(
    leading: BackButton(),
    title: RichText(
        text: TextSpan(
          text: 'Profile',
          style: TextStyle(
            fontSize: 20,
          )
        )
    ),
    backgroundColor: Colors.blue[600],
    elevation: 0,
    actions: [
      IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
      ),
    ],
  );
}