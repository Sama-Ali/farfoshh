//this file built for keep the user status
import 'package:farfoshmodi/models/user.dart';
import 'package:farfoshmodi/resources/auth_method.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  //do not forget, should be private
  User? _user;
  final AuthMethod _authMethod = AuthMethod();

  //getter
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetails();
    _user = user;
    notifyListeners(); //update all listenerس
  }
}
