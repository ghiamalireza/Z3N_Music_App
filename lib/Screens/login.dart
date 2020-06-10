import 'package:flutter/material.dart';
import 'package:musicapp/Screens/profile.dart';
import 'package:musicapp/Screens/upload.dart';
import 'package:musicapp/services/auth.dart';
import 'package:musicapp/services/auth.dart';

import 'home.dart';
import 'main.dart';

class Login extends StatelessWidget {
  final AuthService _authService = AuthService();
  int _selectedPage = 0;
  final _pageOptions = [
    HomePage(),
    UploadPage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[50],
      appBar: AppBar(
        title:  Text('Z3N'),
        backgroundColor: Colors.greenAccent[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _authService.signOut();
            },
          )
        ],
      ),
      body: _pageOptions[_selectedPage],
    );
  }
}




//class Login extends State<MyApp> {
//  int _selectedPage = 0;
//  final _pageOptions = [
//    HomePage(),
//    UploadPage(),
//    ProfilePage(),
//  ];
//
//  @override
//  Widget build(BuildContext context){
//    return MaterialApp(
//      title: 'Flutter App',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(appBar: AppBar(title: Text('Z3N'),
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(
//                Icons.chat,
//                color: Colors.white,
//              ),
//              onPressed: (){}
//          )
//        ],
//      ),
//        body: _pageOptions[_selectedPage],
//        bottomNavigationBar: BottomNavigationBar(
//          currentIndex: _selectedPage,
//          onTap: (int index) {
//            setState(() {
//              _selectedPage = index;
//            });
//          },
//          items: [
//            BottomNavigationBarItem(
//                icon: Icon(Icons.home),
//                title: Text('Home')
//            ),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.file_upload),
//                title: Text('Upload')
//            ),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.account_box),
//                title: Text('Profile')
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//
