import 'package:flutter/material.dart';
import 'package:weather_app/pages/edit_profile_page.dart';
import '../widgets/widgets.dart';
import '../model/user.dart';
import '../constants/constants.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.currentUserId, required this.visitedUserId}) : super(key: key);

  final String currentUserId;
  final String visitedUserId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: usersRef.doc(widget.visitedUserId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
            User user = User.fromDoc(snapshot.data);
            return ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: ClipPathClass(),
                      child: Container(
                        height: 150,
                        width: Get.width,
                        color: Colors.blue[600],
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(5.0, 40.0, 0.0),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: user.profilePicture.isEmpty
                                ? AssetImage('assets/images/nameless.png') as ImageProvider
                                    : NetworkImage(user.profilePicture),
                                ),
                              Positioned(
                                bottom: 0,
                                right: 4,
                                child: ClipOval(
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(3),
                                    child: ClipOval(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        color: Colors.blue[600],
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) =>
                                                  EditProfilePage(
                                                    currentUserId: widget.currentUserId,
                                                    visitedUserId: widget.visitedUserId,
                                                  )),
                                            );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ),
                          SizedBox(height: 15),
                          buildName(user),
                          SizedBox(height: 24),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildButton(context, user.gender, 'Jenis Kelamin'),
                                buildDivider(),
                                buildButton(context, user.age.toString(), 'Umur'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 350),
                          buildBio(user),
                          SizedBox(height: 48),
                          buildAbout(user),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
      ),
    );
  }

}

Widget buildDivider() => Container(
  height: 24,
  child: VerticalDivider(),
);

Widget buildButton(BuildContext context, String value, String text) => MaterialButton(
    onPressed: () {},
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        SizedBox(height: 2),
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

Widget buildBio(User user) => Container(
  padding: EdgeInsets.symmetric(horizontal: 48.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Bio',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 16),
      Text(
        user.bio,
        style: TextStyle(fontSize: 16, height: 1.4),
      ),
    ],
  ),
);

Widget buildAbout(User user) => Container(
  padding: EdgeInsets.symmetric(horizontal: 48.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'About',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 16),
      Text(
        user.about,
        style: TextStyle(fontSize: 16, height: 1.4),
      ),
    ],
  ),
);

Widget buildButtonNumber(BuildContext context, int value, String text) => MaterialButton(
  onPressed: () {},
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        value.toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      SizedBox(height: 2),
      Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
);

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}

Widget buildName(User user) => Column(
  children: [
    Text(
      '${user.firstName} ${user.lastName}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24
      ),
    ),
    SizedBox(height: 4),
    Text(
      '${user.email}',
      style: TextStyle(
          color: Colors.grey
      ),
    ),
  ],
);

Widget buildEditIcon(Color color) => buildCircle (
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    )
);

buildCircle({
  required Color color,
  required double all,
  required Icon child
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );


