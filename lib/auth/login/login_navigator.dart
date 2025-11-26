abstract class LoginNavigator {
  void showMyLoading({required String message});

  void hideMyLoading();

  void showMyMessage({
    required String message,
    String? title,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  });

  void navigator(String route);
}
