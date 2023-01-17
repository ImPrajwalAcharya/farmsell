import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmersapp/methods/authmethods.dart';
import 'package:farmersapp/methods/firestore_methods.dart';
import 'package:farmersapp/model/product_model.dart';
import 'package:farmersapp/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyProductScreen extends StatefulWidget {
  const MyProductScreen({super.key});

  @override
  State<MyProductScreen> createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  final c = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  Uint8List? _file;
  String? _selectedCategory;
  List<String> _categories = [
    "vegetables",
    "fruits",
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (var i in c) {
      i.dispose();
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: IconButton(
            onPressed: () async {
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                _file = file;
              });
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add Product'),
                    content: SingleChildScrollView(
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: c[0],
                              decoration:
                                  InputDecoration(labelText: 'Product Name'),
                            ),
                            DropdownButtonFormField(
                              decoration:
                                  InputDecoration(labelText: 'Category'),
                              value: _selectedCategory,
                              items: _categories.map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                              },
                            ),
                            TextFormField(
                              controller: c[1],
                              decoration: InputDecoration(labelText: 'Price'),
                              keyboardType: TextInputType.number,
                            ),
                            TextFormField(
                              controller: c[2],
                              decoration:
                                  InputDecoration(labelText: 'Quantity'),
                              keyboardType: TextInputType.number,
                            ),
                            TextFormField(
                              controller: c[3],
                              decoration: InputDecoration(labelText: 'Unit'),
                            ),
                            TextFormField(
                              controller: c[4],
                              decoration:
                                  InputDecoration(labelText: 'Description'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: InkWell(
                                // onTap: _pickImage,
                                // child: _file==null?
                                //      Container(
                                //         width: double.infinity,
                                //         height: 150.0,
                                //         decoration: BoxDecoration(
                                //           border: Border.all(color: Colors.grey),
                                //           borderRadius:
                                //               BorderRadius.circular(8.0),
                                //         ),
                                //         child: InkWell(
                                //           onTap: () async{
                                //             // Navigator.pop(context);

                                //           },
                                //           child: Column(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             children: [
                                //               Icon(Icons.camera_alt),
                                //               SizedBox(
                                //                 height: 10.0,
                                //               ),
                                //               Text('Add Image'),
                                //             ],
                                //           ),
                                //         ),
                                //       )
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: MemoryImage(_file!),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Save'),
                        onPressed: () async {
                          await FirestoreMethods().addproduct(
                              price: c[1].text,
                              file: file,
                              productname: c[0].text,
                              category: _selectedCategory,
                              quantity: c[2].text,
                              unit: c[3].text,
                              description: c[4].text);
                          showSnackBar('ADDED', context);
                          for (var i in c) {
                            i.clear();
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.green,
            )),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          width: double.infinity,
          height: double.infinity,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                // .collection('user')
                // .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('farmproduct')
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data!.docs.length != 0) {
                // return GridView.builder(
                //   itemCount: snapshot.data!.docs.length,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 4),
                //   itemBuilder: (context, index) {
                //     return Card(
                //         child: Container(
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //               fit: BoxFit.cover,
                //               image: NetworkImage(
                //                   snapshot.data!.docs[index]['photourl']))),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         // crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           Text(
                //             snapshot.data!.docs[index]['productname'],
                //             style: TextStyle(
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.white),
                //           ),
                //           Row(
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Text(snapshot.data!.docs[index]['quantity']),
                //               Text(snapshot.data!.docs[index]['unit'])
                //             ],
                //           ),
                //         ],
                //       ),
                //     ));
                //   },
                // );
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data!.docs[index]['uid'] !=
                          FirebaseAuth.instance.currentUser!.uid) {
                        return Container();
                      }
                      return Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        snapshot.data!.docs[index]['photourl']),
                                  ),
                                  title: Text(snapshot.data!.docs[index]
                                      ['productname']),
                                  subtitle: Text(
                                      "${snapshot.data!.docs[index]['quantity']} x ${snapshot.data!.docs[index]['unit']}"),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('farmproduct')
                                            .doc(snapshot.data!.docs[index]
                                                ['pid'])
                                            .delete();
                                        await FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection('mycart')
                                            .doc(snapshot.data!.docs[index]
                                                ['pid'])
                                            .delete();
                                      }),
                                  //TODO

                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Scaffold(
                                        appBar: AppBar(
                                            title: Text(snapshot.data!
                                                .docs[index]['productname'])),
                                        body: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        //for the image
                                                        height: 200,
                                                        width: 200,
                                                        child: Image(
                                                          image: NetworkImage(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['photourl']),
                                                        ),
                                                      ),
                                                      Card(
                                                          elevation: 5,
                                                          child: ListTile(
                                                            title: Text(
                                                              snapshot
                                                                  .data!
                                                                  .docs[index][
                                                                      'productname']
                                                                  .toUpperCase(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            subtitle: Text(
                                                              "${snapshot.data!.docs[index]['quantity']} x ${snapshot.data!.docs[index]['unit']}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )),
                                                      ListTile(
                                                          subtitle: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ['description'],
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Card(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Comments",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      // color: Colors.blue,
                                                      height: 200,
                                                      width: double.infinity,
                                                      child: StreamBuilder(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'farmproduct')
                                                            .doc(snapshot.data!
                                                                    .docs[index]
                                                                ['pid'])
                                                            .collection(
                                                                'comment')
                                                            .snapshots(),
                                                        builder: (context,
                                                            snapshot1) {
                                                          return ListView
                                                              .builder(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount: snapshot1
                                                                .data!
                                                                .docs
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                      '${snapshot1.data!.docs[index]['username']} :'),
                                                                  Text(snapshot1
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'comment'])
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]),
                                      );
                                    }));
                                  }),
                            ],
                          ));
                    });
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No Items Added'),
                    Container(
                        child: Image.asset('assets/noitem.png'), height: 50)
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
