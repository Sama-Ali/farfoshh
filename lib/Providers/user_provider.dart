//this file built for keep the user status
import 'package:farfoshmodi/models/user.dart';
import 'package:farfoshmodi/resources/auth_method.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  //do not forget, should be private
  User? _user;
  final AuthMethod _authMethod = AuthMethod();

  //getter
  // User get getUser => _user!;
  User? get getUser {
    print('UserProvider getUser called, user: $_user');
    return _user;
  }

  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetails();
    print("setting the user from user provider refresh:");
    print(user);
    _user = user;
    notifyListeners(); //update all listener
  }
}
