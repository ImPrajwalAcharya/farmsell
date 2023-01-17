import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Usermodel {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final String location;
  final String contactno;
  final String mode;

  const Usermodel(
      {required this.location,
      required this.email,
      required this.uid,
      required this.photoUrl,
      required this.username,
      required this.bio,
      required this.contactno,
      required this.mode});

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'bio': bio,
        'email': email,
        'photourl': photoUrl,
        'location': location,
        'contactno': contactno,
        'mode':mode
      };
  static Usermodel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Usermodel(
        email: snapshot['email'],
        uid: snapshot['uid'],
        photoUrl: snapshot['photourl'],
        username: snapshot['username'],
        bio: snapshot['bio'],
        location: snapshot['location'],
        contactno: snapshot['contactno'],
        mode: snapshot['mode']);
  }
}
