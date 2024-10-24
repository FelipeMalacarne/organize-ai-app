import 'package:flutter/material.dart';
import 'package:organize_ai_app/models/user.dart';
import 'package:organize_ai_app/services/user_service.dart';

class UserController with ChangeNotifier {
  final UserService userService;

  UserController(this.userService);

  Future<User> getCurrentUser() async {
    try {
      return await userService.getSelf();
    } catch (error) {
      rethrow;
    }
  }
}
