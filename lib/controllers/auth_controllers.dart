import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:plantist/models/userModel.dart' as modelUser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantist/views/signup_screen.dart';
import '../views/home_screen.dart';
import '../views/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

//reactive variable --> observable
  late Rx<User?> _user;
  User? get user=>_user.value;
  // late Rx<File?> _pickedImage;
  //
  // File? get profilePhoto => _pickedImage.value;

//persist user state
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialScreen);
  }

//if user is not logged in, go to Login screen
  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => SignupScreen());
    } else {
      Get.offAll(() =>  Home());
    }
  }

  //register user function
  Future<String> registerUser(
      String email, String password) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        print("email"+email);
        UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        modelUser.UserModel user = modelUser.UserModel(email: email, uid: cred.user!.uid,);
        print(cred.user!.uid+"iddd");
        print("password"+password);

        //store the user data acording to the modelUser.User in json (Map<String, dynamic>) format model to firestore
        await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({'email':email});
        res = "success";

        Get.snackbar(
          'Successful!',
          'Your account has been successfully created',
        );
      }

      //field missing
      else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
    return res;
  }

  //login user function

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);

        Get.snackbar(
          'Login Successful',
          'You\'ve successfully logged in!',
        );
        // print("USER LOGIN SUCCESSFUL");
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Logging in',
        e.toString(),
      );
    }
  }

  //sign out function

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}