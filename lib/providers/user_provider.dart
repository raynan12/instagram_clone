import '../models/user.dart';
// import '../models/user_model.dart';
import 'package:flutter/widgets.dart';
// import '../res/auth_method.dart';
import '../resources/auth_methods.dart';
// import 'package:instagram_clone_flutter/models/user.dart';
// import 'package:instagram_clone_flutter/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}