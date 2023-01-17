import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Productmodel {
  final String pid;
  final String uid;
  final String photoUrl;
  final String productname;
  final String quantity;
  final String unit;
  final String price;
  final String description;
  final String category;
  final String soldquantity;


  const Productmodel(
      {required this.price,
      required this.category,
      required this.pid,
      required this.uid,
      required this.photoUrl,
      required this.productname,
      required this.quantity,
      required this.soldquantity,
      required this.unit,
      required this.description});

  Map<String, dynamic> toJson() => {
        'productname': productname,
        'uid': uid,
        'pid': pid,
        'category':category,
        'price': price,
        'photourl': photoUrl,
        'quantity': quantity,
        'unit': unit,
        'soldquantity':soldquantity,
        'description':description
      };
  static Productmodel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Productmodel(
        pid: snapshot['pid'],
        uid: snapshot['uid'],
        photoUrl: snapshot['photourl'],
        price: snapshot['price'],
        quantity: snapshot['quantity'],
        unit: snapshot['unit'],
        category: snapshot['category'],
        productname: snapshot['productname'],
        description: snapshot['description'],
        soldquantity: snapshot['soldquantity']);
  }
}
