import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../model/user.dart';
import '../widgets/widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.currentUserId, required this.visitedUserId}) : super(key: key);

  final String currentUserId;
  final String visitedUserId;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: RichText(
            text: TextSpan(
                text: 'Edit Profile',
                style: TextStyle(
                  fontSize: 20,
                )
            )
        ),
        backgroundColor: Colors.blue[600],
        elevation: 0,
      ),
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
                      transform: Matrix4.translationValues(115.0, 40.0, 0.0),
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
                                            onTap: () {},
                                            child: Icon(
                                              Icons.add_a_photo,
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
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 180),
                          TextFieldWidget(
                            label: 'First Name',
                            text: user.firstName,
                            onChanged: (firstName) {},
                            maxLines: 1,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'Last Name',
                            text: user.lastName,
                            onChanged: (lastName) {},
                            maxLines: 1,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'Email',
                            text: user.email,
                            onChanged: (email) {},
                            maxLines: 1,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'Jenis Kelamin',
                            text: user.gender,
                            onChanged: (gender) {},
                            maxLines: 1,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'Usia',
                            text: user.age.toString(),
                            onChanged: (age) {},
                            maxLines: 1,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'Bio',
                            text: user.bio,
                            onChanged: (bio) {},
                            maxLines: 1,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'About',
                            text: user.about,
                            onChanged: (about) {},
                            maxLines: 5,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade600,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
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
