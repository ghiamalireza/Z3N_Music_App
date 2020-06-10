import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference zenCollection = Firestore.instance.collection('members');

  Future updateUserData(String genre, String name) async {
    return await zenCollection.document(uid).setData({
      'genre': genre,
      'name': name,
    });
  }
}