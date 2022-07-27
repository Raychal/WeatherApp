import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/emoticon_face.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/asset_path.dart';
import 'pages.dart';

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
  String? _bio;

  Future<void> getData() async {
    User user = _auth.currentUser!;
    _uid = user.uid;
    final DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      // _bio = userDoc.get('bio');
      // _firstName = userDoc.get('first name');
      _bio =  userDoc.data().toString().contains('bio') ? userDoc.get('bio') : 'No Bio';
      _firstName =  userDoc.data().toString().contains('first name') ? userDoc.get('first name') : 'Citizen';
    });
    print('name $_firstName');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  // User user = User.fromDoc(snapshot.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  // Greetings Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage(defaultPhoto),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ${_firstName}!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(
                            height: 8,
                          ),

                          Text(
                            '${_bio}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NotifPage(),
                              )
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  // how do you feel?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'How do you feel?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  // 4 different face

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // bad
                      Column(
                        children: [
                          EmoticonFace(
                            emoticonFace: '😑️',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Bad',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      // fine
                      Column(
                        children: [
                          EmoticonFace(
                            emoticonFace: '😀️',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Fine',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      // well
                      Column(
                        children: [
                          EmoticonFace(
                            emoticonFace: '😁️',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Well',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      // excellent
                      Column(
                        children: [
                          EmoticonFace(
                            emoticonFace: '🥳️',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Excellent',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(25),
                color: Colors.grey[100],
                child: Center(
                  child: Column(
                    children: [
                      // Feature heading
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Feature',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // listview of features
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Weather(),
                                )
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.cloud),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Weather',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),

                                      SizedBox(
                                        height: 5,
                                      ),

                                      Text(
                                        'Check current weather',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.grey
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(Icons.more_horiz),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
