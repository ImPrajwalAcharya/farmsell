import 'dart:typed_data';

import 'package:farmersapp/model/product_model.dart';
import 'package:farmersapp/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  Future<Usermodel> getUserDetails() async {
    final snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return Usermodel.fromSnap(snap);
  }
    Future<Usermodel> getUserDetail( {required uid}) async {
    final snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get();
    return Usermodel.fromSnap(snap);
  }

  Future<Productmodel> getProductDetails(String productid) async {
    final snap = await FirebaseFirestore.instance
        .collection('farmproduct')
        .doc(productid)
        .get();
    return Productmodel.fromSnap(snap);
  }


  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
  }) async {
      String photourl =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
    String res = 'Some Error occurred';
    try {
      if (email.isEmpty || password.isEmpty || username.isEmpty) {
      } else {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        Usermodel userdata = Usermodel(
            uid: cred.user!.uid,
            username: username,
            email: email,
            photoUrl: photourl,
            bio: bio,
            location: '',
            contactno: '',
            mode: '');
        await _storage
            .collection('user')
            .doc(cred.user!.uid)
            .set(userdata.toJson());

        res = 'Success✅';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'email is badly formatted';
      } else if (err.code == 'weak-password') {
        res = 'weak password';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some Error occurred';
    try {
      if (email.isEmpty || password.isEmpty) {
        res = 'Please enter all the fields';
      } else {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success✅';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
