import 'package:flutter/material.dart';
import 'package:musicapp/Screens/home.dart';
import 'package:musicapp/Screens/message.dart';
import 'package:musicapp/Screens/profile.dart';
import 'package:musicapp/Screens/upload.dart';
import 'package:musicapp/Screens/wrapper.dart';
import 'package:musicapp/models/user.dart';
import 'package:musicapp/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

//class MyAppState extends State<MyApp> {
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
//            icon: Icon(
//              Icons.chat,
//              color: Colors.white,
//            ),
//            onPressed: (){}
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

