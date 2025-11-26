import 'package:events/auth/login/login_navigator.dart';
import 'package:events/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../firebase_utils.dart';
import '../../model/my_user.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator navigator;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: 'yasen.ehab.23093@gmail.com',
  );
  TextEditingController passwordController = TextEditingController(
    text: 'Yasenedres258y',
  );

  //todo: hold data - handel logic
  void login() async {
    if (formKey.currentState?.validate() == true) {
      //todo: login
      //todo: 1- show loading
      navigator.showMyMessage(message: 'lodaing...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        //todo: read user from firebaseFireStore
        var user = await FirebaseUtils.readUserFromFireStore(
          credential.user?.uid ?? '',
        );
        if (user == null) {
          return;
        }
        // //todo: save user in provider
        // var userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.updateUser(user);
        // //todo: selected index = 0 => call getAllEvents
        // var eventListProvider = Provider.of<EventListProvider>(
        //     context, listen: false);
        // eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        // eventListProvider.getAllFavouriteEvents(userProvider.currentUser!.id);

        //todo: 2- hide loading
        navigator.hideMyLoading();
        //todo: 3- show message
        navigator.showMyMessage(
          message: 'Login Successfully.',
          posActionName: 'Ok',
          posAction: () {
            navigator.navigator(AppRoute.homeRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo: 2- hide loading
          navigator.hideMyLoading();
          //todo: 3- show message
          navigator.showMyMessage(message: 'Wrong email or password');
        }
      } catch (e) {
        //todo: 2- hide loading
        navigator.hideMyLoading();
        //todo: 3- show message
        navigator.showMyMessage(message: e.toString());
      }
    }
  }

  void loginWithGoogle() async {
    //todo: login with google.
    //todo: 1- show loading
    navigator.showMyLoading(message: 'loading...');
    try {
      //todo: google sign in
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        navigator.hideMyLoading();
        return;
      }
      //todo: create googleAuth
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      //todo: take googleAuth data
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      //todo: chek if user already exist
      var user = await FirebaseUtils.readUserFromFireStore(
        userCredential.user?.uid ?? '',
      );
      //todo: create new user
      if (user == null) {
        user = MyUser(
          id: userCredential.user!.uid,
          name: googleUser.displayName ?? '',
          email: googleUser.email,
        );
        await FirebaseUtils.addUserToFireStore(user);
      }

      // //todo: save user in provider
      // var userProvider = Provider.of<UserProvider>(
      //     context, listen: false);
      // userProvider.updateUser(user);
      //
      // //todo: selected index = 0 => call getAllEvents
      //
      // var eventListProvider = Provider.of<
      //     EventListProvider>(context, listen: false);
      // eventListProvider.changeSelectedIndex(
      //     0, userProvider.currentUser!.id);
      // eventListProvider.getAllFavouriteEvents(
      //     userProvider.currentUser!.id);

      //todo: 2- hide loading
      navigator.hideMyLoading();
      //todo: 3- show message
      navigator.showMyMessage(message: 'Login Successfully.');
    } on FirebaseAuthException catch (e) {
      //todo: 2- hide loading
      navigator.hideMyLoading();
      //todo: 3- show message
      navigator.showMyMessage(message: 'Something went wrong.');
    } catch (e) {
      //todo: 2- hide loading
      navigator.hideMyLoading();
      //todo: 3- show message
      navigator.showMyMessage(message: e.toString());
    }
  }
}
