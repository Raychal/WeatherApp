import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weather_app/services/database_services.dart';
import 'package:weather_app/services/storage_services.dart';

import '../../model/user.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.user, }) : super(key: key);

  final UserModel user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _gender;
  String? _about;
  String? _bio;
  int? _age;
  File? _profileImage;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  displayProfileImage() {
    if (_profileImage == null) {
      if (widget.user.profilePicture.isEmpty) {
        return AssetImage('assets/images/nameless.png');
      } else {
        return NetworkImage(widget.user.profilePicture);
      }
    } else {
      return FileImage(_profileImage!);
    }
  }

  saveProfile() async {
    try {
      _formKey.currentState!.save();
      if (_formKey.currentState!.validate() && !_isLoading) {
        setState(() {
          _isLoading = true;
        });
        String profilePictureUrl = '';
        if (_profileImage == null) {
          profilePictureUrl = widget.user.profilePicture;
        } else {
          profilePictureUrl = await StorageService.uploadProfilePicture(
              widget.user.profilePicture, _profileImage!);
        }

        UserModel user = UserModel(
          id: widget.user.id,
          firstName: _firstName!,
          lastName: _lastName!,
          email: _email!,
          profilePicture: profilePictureUrl,
          age: _age!,
          gender: _gender!,
          bio: _bio!,
          about: _about!,
        );

        print(user.id.toString());
        DatabaseServices.updateUserData(user);
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  handleImageFromGallery() async {
    try {
      final imageFile = (await ImagePicker().pickImage(source: ImageSource.gallery));
      if (imageFile != null) {
        print('msg ${imageFile.toString()}');
        _profileImage = File(imageFile.path);
        print('msg ${_profileImage}');
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    _firstName = widget.user.firstName;
    _lastName = widget.user.lastName;
    _email = widget.user.email;
    _gender = widget.user.gender;
    _age = widget.user.age;
    _bio = widget.user.bio;
    _about = widget.user.about;
    super.initState();
  }

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
      body: ListView(
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
                                  backgroundImage: displayProfileImage(),
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
                                              handleImageFromGallery();
                                            },
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
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 180),
                            TextFormField(
                              initialValue: _firstName!,
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (input) => input!.trim().length < 2
                                  ? 'please enter valid name'
                                  : null,
                              onSaved: (value) {
                                _firstName = value;
                              },
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              initialValue: _lastName!,
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (input) => input!.trim().length < 2
                                  ? 'please enter valid name'
                                  : null,
                              onSaved: (value) {
                                _lastName = value;
                              },
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              initialValue: _email!,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (input) => input!.trim().length < 2
                                  ? 'please enter valid name'
                                  : null,
                              onSaved: (value) {
                                _email = value;
                              },
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              initialValue: _gender!,
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (input) => input!.trim().length < 2
                                  ? 'please enter valid name'
                                  : null,
                              onSaved: (value) {
                                _gender = value;
                              },
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              initialValue: _age!.toString(),
                              decoration: InputDecoration(
                                labelText: 'Age',
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (input) => input!.trim().length < 1
                                  ? 'please enter valid name'
                                  : null,
                              onSaved: (value) {
                                _age = int.parse(value!);
                              },
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              initialValue: _bio!,
                              decoration: InputDecoration(
                                labelText: 'Bio',
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (input) => input!.trim().length < 2
                                  ? 'please enter valid name'
                                  : null,
                              onSaved: (value) {
                                _bio = value;
                              },
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              initialValue: _about!,
                              decoration: InputDecoration(
                                labelText: 'About',
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (input) => input!.trim().length < 2
                                  ? 'please enter valid name'
                                  : null,
                              onSaved: (value) {
                                _about = value;
                              },
                              maxLines: 5,
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: GestureDetector(
                                onTap: saveProfile,
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
                    ),
                  ],
                ),
              ],
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

Widget buildName(UserModel user) => Column(
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
