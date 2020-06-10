import 'package:flutter/material.dart';
import 'package:musicapp/Screens/Authentication/authentication.dart';
import 'package:musicapp/Screens/login.dart';
import 'package:provider/provider.dart';
import 'package:musicapp/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);


    if (user == null) {
      return Authentication();
    } else {
      return Login();
    }
  }
}
