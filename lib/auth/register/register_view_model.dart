import 'package:events/auth/register/register_navigator.dart';
import 'package:events/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterViewModel extends ChangeNotifier {
  //todo: hold data - handel logic.
  late RegisterNavigator navigator;

  void register(String email, String password) async {
    //todo: register
    //todo: 1- show loading
    navigator.showMyLoading(message: 'waiting...');
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // //todo: save user in firebaseFirestore.
      // MyUser myUser = MyUser(
      //     id: credential.user?.uid ?? '',
      //     name: nameController.text,
      //     email: emailController.text
      // );
      // await FirebaseUtils.addUserToFireStore(myUser);
      // //todo: save user in provider
      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      // userProvider.updateUser(myUser);
      // //todo: selected index = 0 => call getAllEvents
      // var eventListProvider = Provider.of<EventListProvider>(
      //     context, listen: false);
      // eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
      // eventListProvider.getAllFavouriteEvents(userProvider.currentUser!.id);

      //todo: 2- hide loading
      navigator.hideMyLoading();
      //todo: 3- show message
      navigator.showMyMessage(message: 'Register Successfully.',
          posActionName: 'Ok',
          posAction: () {
            navigator.navigator(AppRoute.homeRouteName);
          });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //todo: 2- hide loading
        navigator.hideMyLoading();
        //todo: 3- show message
        navigator.showMyMessage(message: 'the password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        //todo: 2- hide loading
        navigator.hideMyLoading();
        //todo: 3- show message
        navigator.showMyMessage(
          message: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      //todo: 2- hide loading
      navigator.hideMyLoading();
      //todo: 3- show message
      navigator.showMyMessage(message: e.toString());
    }
  }
}
