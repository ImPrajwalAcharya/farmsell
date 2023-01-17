import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmersapp/methods/authmethods.dart';
import 'package:farmersapp/methods/firestore_methods.dart';
import 'package:farmersapp/methods/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _locationcontroller = TextEditingController();
  TextEditingController _biocontroller = TextEditingController();
  TextEditingController _contactcontroller = TextEditingController();
  Uint8List? _file;

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('select from'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose From Gallary'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  // setState(() {
                  //   _file = Uint8List(2);
                  // });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: AuthMethods().getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _locationcontroller.text = snapshot.data!.location;
            _biocontroller.text = snapshot.data!.bio;
            _contactcontroller.text = snapshot.data!.contactno;
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(snapshot.data!.photoUrl),
                      ),
                      IconButton(
                          onPressed: () async {
                            _selectImage(context);
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.green,
                          ))
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _biocontroller,
                      decoration: InputDecoration(hintText: 'Bio'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _locationcontroller,
                      decoration: InputDecoration(hintText: 'Location'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _contactcontroller,
                      decoration: InputDecoration(hintText: 'Contact no'),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () async {
                            if(_file!=null){
                              final photourl = await StorageMethods()
                                .uploadimage('Profile', _file!, false);
                            await FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({'photourl': photourl});
                            }
                            
                            await FirebaseFirestore.instance
                                .collection('user')
                                .doc(snapshot.data!.uid)
                                .update({
                              // 'photourl': photourl,
                              'contactno': _contactcontroller.text,
                              'location': _locationcontroller.text,
                              'bio': _biocontroller.text
                            });
                            showSnackBar('saved', context);
                            Navigator.of(context).pop();
                          },
                          child: Text('Save'))),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}
