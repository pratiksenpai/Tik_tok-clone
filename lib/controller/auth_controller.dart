import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart' as model;
import 'package:tiktok_clone/views/screens/home_screen.dart';
import 'package:tiktok_clone/views/screens/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  // persisting the auth state
  late Rx<User?> _user;
  User get user => _user.value!;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  //function for picking image for circle avtar
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage
      .value; //as _pickedImage is private so to access its value we created a public file
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('profile picture',
          'you have successfully updated your profile picture');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //uploading the image picked to firebase
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downlaodUrl = await snap.ref.getDownloadURL();
    return downlaodUrl;
  }

  // creating a user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
            name: username,
            email: email,
            uid: cred.user!.uid,
            profilePhoto: downloadUrl);
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('error creating account', 'please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('error creating account', e.toString());
    }
  }

  // logging in user
  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar('error Logging in', 'please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('error Logging in', e.toString());
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}
