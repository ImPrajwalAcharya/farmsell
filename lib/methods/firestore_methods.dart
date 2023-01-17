

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmersapp/methods/storage_methods.dart';
import 'package:farmersapp/model/product_model.dart';
import 'package:farmersapp/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final _firebase = FirebaseFirestore.instance;

  addtocart(
      {required pid,
      required price,
      required photoUrl,
      required productname,
      required totalquantity,
      required unit,
      required description,
      context}) async {
    final checking = await _firebase
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('mycart')
        .doc(pid)
        .get();
    // Map<String, dynamic> data = checking.data() as Map<String, dynamic>;
    print('vayoooo');
    if (!checking.exists) {
      await _firebase
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('mycart')
          .doc(pid)
          .set({
        'productname': productname,
        'category': '',
        'pid': pid,
        'price': price,
        'photourl': photoUrl,
        'quantity': 1,
        'unit': unit,
        'description': description,
        'totalquantity': totalquantity,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      });
    } else {
      // print(data['totalquantity']);
      // if (int.parse((data['totalquantity'])) <= (data['quantity'])) {
      //   showSnackBar('Out of stock', context);
      // } else {
      await _firebase
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('mycart')
          .doc(pid)
          .update({
        'quantity': FieldValue.increment(1),
      });
    }
    // }
     final getdata =await _firebase
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('mycart')
          .doc(pid).get();
         
    await _firebase
        .collection('farmproduct')
        .doc(pid)
        .update({
          'soldquantity':getdata['quantity']
        });
  }

  addproduct(
      {required price,
      required file,
      required productname,
      required category,
      required quantity,
      required unit,
      required description}) async {
    
      String producturl =
          await StorageMethods().uploadimage('products', file, true);
      String id = const Uuid().v1();

      await _firebase.collection('farmproduct').doc(id).set(Productmodel(
              price: price,
              productname: productname,
              quantity: quantity,
              unit: unit,
              category: category,
              description: description,
              photoUrl: producturl,
              soldquantity:'',
              uid: FirebaseAuth.instance.currentUser!.uid,
              pid: id)
          .toJson());
   
  }
}
