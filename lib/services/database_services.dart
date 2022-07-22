import '../constants/constants.dart';
import '../model/user.dart';

class DatabaseServices {
  static void updateUserData(User user) {
    usersRef.doc(user.id).update({
      'first name': user.firstName,
      'last name': user.lastName,
      'bio': user.bio,
      'profilePicture': user.profilePicture,
      'age': user.age,
      'gender': user.gender,
      'about': user.about
    });
  }
}