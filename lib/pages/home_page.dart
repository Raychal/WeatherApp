import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String guest = 'Citizen';
  bool isLoading = false;
  String? _uid;
  String? _firstName;

  Future<void> getData() async {
    User user = _auth.currentUser!;
    _uid = user.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _firstName = userDoc.get('first name');
    });
    print('name $_firstName');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello, ${_firstName}',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed In as ${_auth.currentUser?.email}'),
            MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              color: Colors.deepPurple,
              child: Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
