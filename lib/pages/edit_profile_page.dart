import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weather_app/services/database_services.dart';
import 'package:weather_app/services/storage_services.dart';

import '../model/user.dart';
import '../widgets/widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.user, }) : super(key: key);

  final User user;

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
  String? _imagePickedType;
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

        User user = User(
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

        DatabaseServices.updateUserData(user);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  handleImageFromGallery() async {
    try {
      XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        if (_imagePickedType == 'profile') {
          setState(() {
            _profileImage = imageFile as File?;
          });
        }
      }
    } catch (e) {
      print(e);
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
                                              _imagePickedType = 'profile';
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 180),
                          TextFieldWidget(
                            label: 'First Name',
                            text: _firstName!,
                            maxLines: 1,
                            onSaved: (value) {
                              _firstName = value;
                            },
                            validator: (input) => input.toString().length < 2
                              ? 'Please enter valid name'
                              : null,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'Last Name',
                            text: _lastName!,
                            maxLines: 1,
                            onSaved: (value) {
                              _lastName = value;
                            },
                            validator: (input) => input.toString().length < 2
                                ? 'Please enter valid name'
                                : null,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'Email',
                            text: _email!,
                            maxLines: 1,
                            onSaved: (value) {
                              _email = value;
                            },
                            validator: (input) => input.toString().length < 2
                                ? 'Please enter valid email'
                                : null,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'Jenis Kelamin',
                            text: _gender!,
                            maxLines: 1,
                            onSaved: (value) {
                              _gender = value;
                            },
                            validator: (input) => input.toString().length < 2
                                ? 'Please enter valid gender'
                                : null,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'Usia',
                            text: _age!.toString(),
                            maxLines: 1,
                            onSaved: (value) {
                              _age = value as int?;
                            },
                            validator: (input) => input.toString().length < 1
                                ? 'Please enter valid age'
                                : null,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'Bio',
                            text: _bio!,
                            maxLines: 1,
                            onSaved: (value) {
                              _bio = value;
                            },
                            validator: (input) => input.toString().length < 2
                                ? 'Please enter valid bio'
                                : null,
                          ),
                          SizedBox(height: 10),
                          TextFieldWidget(
                            label: 'About',
                            text: _about!,
                            maxLines: 5,
                            onSaved: (value) {
                              _about = value;
                            },
                            validator: (input) => input.toString().length < 2
                                ? 'Please enter valid about'
                                : null,
                          ),
                          SizedBox(height: 10),
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
