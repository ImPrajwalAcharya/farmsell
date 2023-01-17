import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:farmersapp/methods/authmethods.dart';
import 'package:farmersapp/methods/firestore_methods.dart';
import 'package:farmersapp/model/user_model.dart';
import 'package:farmersapp/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  final TextEditingController _search = TextEditingController();
  final TextEditingController _commentcontroller = TextEditingController();
  bool isshowusers = false;
  Usermodel? user;
  Usermodel? selleruser;
  getuser() async {
    return await AuthMethods().getUserDetails();
  }

  getseller(uid) async {
    selleruser = await AuthMethods().getUserDetail(uid: uid);
    setState(() {
      selleruser;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _search.dispose();
    // _commentcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.teal,
        centerTitle: true,

        title: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextFormField(
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            controller: _search,
            onFieldSubmitted: (value) {
              setState(() {
                isshowusers = true;
              });
            },
            decoration: const InputDecoration(
              
              labelStyle: TextStyle(color: Colors.white),
              prefixIconColor: Colors.white,
                iconColor: Colors.white,
                labelText: 'Search product...',
                icon: Icon(Icons.search ,color: Colors.white,)),
          ),
        ),
      ),
      body: SafeArea(
          child: isshowusers
              ? StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('farmproduct')
                      .where('productname',
                          isGreaterThanOrEqualTo: _search.text)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState==ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          itemBuilder: ((context, index) {
                             getseller(snapshot.data!.docs[index]['uid']);
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                        title: Text(snapshot.data!.docs[index]
                                            ['productname'])),
                                    body: SingleChildScrollView(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Card(
                                                elevation: 5,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.all(10),
                                                      //for the image
                                                      height: 200,
                                                      width: 200,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['photourl']),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                                ['productname']
                                                            .toUpperCase(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      subtitle: Text(
                                                        "${snapshot.data!.docs[index]['quantity']} x ${snapshot.data!.docs[index]['unit']}",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                     ListTile(
                                                              title: Text(
                                                                selleruser!.username,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              subtitle: Text(
                                                                ' contact no :${selleruser!.contactno}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                    ListTile(
                                                        subtitle: Text(
                                                      snapshot.data!.docs[index]
                                                          ['description'],
                                                      textAlign: TextAlign.center,
                                                    )),
                                                  ],
                                                )),
                                            // Container(
                                            //   // color: Colors.blue,
                                            //   height: 200,
                                            //   width: double.infinity,
                                            //   child: StreamBuilder(
                                            //     stream: FirebaseFirestore
                                            //         .instance
                                            //         .collection(
                                            //             'farmproduct')
                                            //         .doc(snapshot.data!
                                            //                 .docs[index]
                                            //             ['pid'])
                                            //         .collection('comment')
                                            //         .snapshots(),
                                            //     builder:
                                            //         (context, snapshot1) {
                                            //       return ListView.builder(
                                            //         scrollDirection:
                                            //             Axis.vertical,
                                            //         itemCount: snapshot1
                                            //             .data!
                                            //             .docs
                                            //             .length,
                                            //         itemBuilder:
                                            //             (context, index) {
                                            //           return Row(
                                            //             mainAxisAlignment:
                                            //                 MainAxisAlignment
                                            //                     .spaceAround,
                                            //             children: [
                                            //               Text(
                                            //                   '${snapshot1.data!.docs[index]['username']} :'),
                                            //               Text(snapshot1
                                            //                       .data!
                                            //                       .docs[index]
                                            //                   ['comment'])
                                            //             ],
                                            //           );
                                            //         },
                                            //       );
                                            //     },
                                            //   ),
                                            // )
                                            Column(
                                              children: [
                                                Text(
                                                  'Comment',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                                Container(
                                                  height: 200,
                                                  child: StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('farmproduct')
                                                        .doc(snapshot.data!
                                                            .docs[index]['pid'])
                                                        .collection('comment')
                                                        .snapshots(),
                                                    builder: (context, snapshot) {
                      //                                  if (snapshot.connectionState==ConnectionState.waiting) {
                      // return Center(child: CircularProgressIndicator());
                    // } 
                                                      return ListView.builder(
                                                        itemCount: snapshot
                                                            .data!.docs.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                        width: 1),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    '  ${snapshot.data!.docs[index]['username']} : '),
                                                                Text(snapshot
                                                                            .data!
                                                                            .docs[
                                                                        index]
                                                                    ['comment'])
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                    bottomNavigationBar: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            // onSubmitted:
                                            //     (value) async {
                                  
                                            // },
                                            controller: _commentcontroller,
                                            decoration: InputDecoration(
                                                labelText: 'comment'),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              user = await getuser();
                                              var id = Uuid().v1();
                                              await FirebaseFirestore.instance
                                                  .collection('farmproduct')
                                                  .doc(snapshot
                                                      .data!.docs[index]['pid'])
                                                  .collection('comment')
                                                  .doc(id)
                                                  .set({
                                                'pid': snapshot
                                                    .data!.docs[index]['pid'],
                                                'comment':
                                                    _commentcontroller.text,
                                                'username': user!.username,
                                                'uid': FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                'cid': id
                                              });
                                              showSnackBar('posted', context);
                                              _commentcontroller.clear();
                                            },
                                            icon: Icon(Icons.send))
                                      ],
                                    ),
                                  );
                                }));
                              },
                              //kjjj
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image(
                                          height: 100,
                                          width: 150,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]['photourl'])),
                                    ),
                                    Text(snapshot
                                        .data!.docs[index]['productname']
                                        .toString()
                                        .toUpperCase()),
                                    TextButton(
                                        onPressed: () async {
                                          await FirestoreMethods().addtocart(
                                              photoUrl: snapshot.data!
                                                  .docs[index]['photourl'],
                                              pid: snapshot.data!.docs[index]
                                                  ['pid'],
                                              unit: snapshot.data!.docs[index]
                                                  ['unit'],
                                              description: snapshot.data!
                                                  .docs[index]['description'],
                                              price: snapshot.data!.docs[index]
                                                  ['price'],
                                              productname: snapshot.data!
                                                  .docs[index]['productname'],
                                              totalquantity: snapshot.data!
                                                  .docs[index]['quantity'],
                                              context: context);
                                        },
                                        // child: const Positioned(
                                        //   bottom:10
                                        //   child: Icon(Icons.add_shopping_cart)),
                                        //
                                        child: const Align(
                                            alignment: Alignment.bottomCenter,
                                            child:
                                                Icon(Icons.add_shopping_cart ,size: 30,)))
                                  ],
                                ),
                              ),
                              // child: ListTile(
                              //   leading: CircleAvatar(
                              //       backgroundImage: NetworkImage(
                              //           (snapshot.data as dynamic).docs[index]
                              //               ['photourl'])),
                              //   title: Text(
                              //     (snapshot.data! as dynamic).docs[index]
                              //         ['productname'],
                              //   ),
                              // ),
                            );
                          }));
                    }
                  },
                )
              : Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Fruits',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('farmproduct')
                                .snapshots(),
                            builder: (context, snapshot) {
                    //            if (snapshot.connectionState==ConnectionState.waiting) {
                    //   return Center(child: CircularProgressIndicator());
                    // } 
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  getseller(snapshot.data!.docs[index]['uid']);
                                  if (snapshot.data!.docs[index]['category'] ==
                                      'fruits') {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Scaffold(
                                            appBar: AppBar(
                                                title: Text(
                                                    snapshot.data!.docs[index]
                                                        ['productname'])),
                                            body: SingleChildScrollView(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Card(
                                                        elevation: 5,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.all(
                                                                      10),
                                                              //for the image
                                                              height: 200,
                                                              width: 200,
                                                              child: Image(
                                                                image: NetworkImage(
                                                                    snapshot.data!
                                                                                .docs[
                                                                            index]
                                                                        [
                                                                        'photourl']),
                                                              ),
                                                            ),
                                                            ListTile(
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
                                                            ),
                                                             ListTile(
                                                              title: Text(
                                                                selleruser!.username,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              subtitle: Text(
                                                                ' contact no :${selleruser!.contactno}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                            ListTile(
                                                                subtitle: Text(
                                                              snapshot.data!
                                                                      .docs[index]
                                                                  ['description'],
                                                              textAlign: TextAlign
                                                                  .center,
                                                            )),
                                                          ],
                                                        )),
                                                    // Container(
                                                    //   // color: Colors.blue,
                                                    //   height: 200,
                                                    //   width: double.infinity,
                                                    //   child: StreamBuilder(
                                                    //     stream: FirebaseFirestore
                                                    //         .instance
                                                    //         .collection(
                                                    //             'farmproduct')
                                                    //         .doc(snapshot.data!
                                                    //                 .docs[index]
                                                    //             ['pid'])
                                                    //         .collection('comment')
                                                    //         .snapshots(),
                                                    //     builder:
                                                    //         (context, snapshot1) {
                                                    //       return ListView.builder(
                                                    //         scrollDirection:
                                                    //             Axis.vertical,
                                                    //         itemCount: snapshot1
                                                    //             .data!
                                                    //             .docs
                                                    //             .length,
                                                    //         itemBuilder:
                                                    //             (context, index) {
                                                    //           return Row(
                                                    //             mainAxisAlignment:
                                                    //                 MainAxisAlignment
                                                    //                     .spaceAround,
                                                    //             children: [
                                                    //               Text(
                                                    //                   '${snapshot1.data!.docs[index]['username']} :'),
                                                    //               Text(snapshot1
                                                    //                       .data!
                                                    //                       .docs[index]
                                                    //                   ['comment'])
                                                    //             ],
                                                    //           );
                                                    //         },
                                                    //       );
                                                    //     },
                                                    //   ),
                                                    // )
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Comment',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                        ),
                                                        Container(
                                                          height: 170,
                                                          child: StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'farmproduct')
                                                                .doc(snapshot
                                                                        .data!
                                                                        .docs[
                                                                    index]['pid'])
                                                                .collection(
                                                                    'comment')
                                                                .snapshots(),
                                                            builder: (context,
                                                                snapshot) {
                      //                                              if (snapshot.connectionState==ConnectionState.waiting) {
                      // return Center(child: CircularProgressIndicator());
                    // } 
                                                              return ListView
                                                                  .builder(
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Container(
                                                                    height: 30,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            width:
                                                                                1),
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(10))),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                            '  ${snapshot.data!.docs[index]['username']} : '),
                                                                        Text(snapshot
                                                                            .data!
                                                                            .docs[index]['comment'])
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                            bottomNavigationBar: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    // onSubmitted:
                                                    //     (value) async {

                                                    // },
                                                    controller:
                                                        _commentcontroller,
                                                    decoration: InputDecoration(
                                                        labelText: 'comment'),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      user = await getuser();
                                                      var id = Uuid().v1();
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'farmproduct')
                                                          .doc(snapshot.data!
                                                                  .docs[index]
                                                              ['pid'])
                                                          .collection('comment')
                                                          .doc(id)
                                                          .set({
                                                        'pid': snapshot.data!
                                                            .docs[index]['pid'],
                                                        'comment':
                                                            _commentcontroller
                                                                .text,
                                                        'username':
                                                            user!.username,
                                                        'uid': FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid,
                                                        'cid': id
                                                      });
                                                      showSnackBar(
                                                          'posted', context);
                                                      _commentcontroller
                                                          .clear();
                                                    },
                                                    icon: Icon(Icons.send))
                                              ],
                                            ),
                                          );
                                        }));
                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: Image(
                                                  height: 100,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      snapshot.data!.docs[index]
                                                          ['photourl'])),
                                            ),
                                            Text(snapshot.data!
                                                .docs[index]['productname']
                                                .toString()
                                                .toUpperCase()),
                                            TextButton(
                                                onPressed: () async {
                                                  await FirestoreMethods().addtocart(
                                                      photoUrl: snapshot.data!.docs[index]
                                                          ['photourl'],
                                                      pid: snapshot.data!.docs[index]
                                                          ['pid'],
                                                      unit: snapshot.data!.docs[index]
                                                          ['unit'],
                                                      description:
                                                          snapshot.data!.docs[index]
                                                              ['description'],
                                                      price: snapshot.data!.docs[index]
                                                          ['price'],
                                                      productname:
                                                          snapshot.data!.docs[index]
                                                              ['productname'],
                                                      totalquantity: snapshot
                                                          .data!
                                                          .docs[index]['quantity'],
                                                      context: context);
                                                },
                                                // child: const Positioned(
                                                //   bottom:10
                                                //   child: Icon(Icons.add_shopping_cart)),
                                                //
                                                child: const Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Icon(Icons
                                                        .add_shopping_cart ,size: 30,)))
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Vegetables',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('farmproduct')
                                .snapshots(),
                            builder: (context, snapshot) {
                    //            if (snapshot.connectionState==ConnectionState.waiting) {
                    //   return Center(child: CircularProgressIndicator());
                    // } 
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  getseller(snapshot.data!.docs[index]['uid']);
                                  if (snapshot.data!.docs[index]['category'] ==
                                      'vegetables') {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Scaffold(
                                            appBar: AppBar(
                                                title: Text(
                                                    snapshot.data!.docs[index]
                                                        ['productname'])),
                                            body: SingleChildScrollView(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Hero(
                                                        tag: 'DetailedView',
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Card(
                                                                elevation: 5,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              20),
                                                                      //for the image
                                                                      height: 200,
                                                                      width: 200,
                                                                      child:
                                                                          Image(
                                                                        image: NetworkImage(snapshot
                                                                            .data!
                                                                            .docs[index]['photourl']),
                                                                      ),
                                                                    ),
                                                                    Card(
                                                                      elevation:
                                                                          5,
                                                                      child:
                                                                          ListTile(
                                                                        title:
                                                                            Text(
                                                                          snapshot
                                                                              .data!
                                                                              .docs[index]['productname']
                                                                              .toUpperCase(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                        subtitle:
                                                                            Text(
                                                                          "${snapshot.data!.docs[index]['quantity']} x ${snapshot.data!.docs[index]['unit']}",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    ListTile(
                                                                      title: Text(
                                                                        selleruser!
                                                                            .username,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                      ),
                                                                      subtitle:
                                                                          Text(
                                                                        "contact no : ${selleruser!.contactno}",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                      ),
                                                                    ),
                                                                    ListTile(
                                                                        subtitle:
                                                                            Text(
                                                                      snapshot.data!
                                                                              .docs[index]
                                                                          [
                                                                          'description'],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    )),
                                                                    Container(
                                                                      height: 2,
                                                                      color: Colors
                                                                          .teal,
                                                                    )
                                                                  ],
                                                                ))
                                                          ],
                                                        )),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Comment',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                        ),
                                                        Container(
                                                          height: 150,
                                                          child: StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'farmproduct')
                                                                .doc(snapshot
                                                                        .data!
                                                                        .docs[
                                                                    index]['pid'])
                                                                .collection(
                                                                    'comment')
                                                                .snapshots(),
                                                            builder: (context,
                                                                snapshot) {
                                                                 
                                                              return ListView
                                                                  .builder(
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Container(
                                                                    height: 30,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            width:
                                                                                1),
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(10))),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                            '  ${snapshot.data!.docs[index]['username']} : '),
                                                                        Text(snapshot
                                                                            .data!
                                                                            .docs[index]['comment'])
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                            bottomNavigationBar: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    // onSubmitted:
                                                    //     (value) async {

                                                    // },
                                                    controller:
                                                        _commentcontroller,
                                                    decoration: InputDecoration(
                                                        labelText: 'comment'),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      user = await getuser();
                                                      var id = Uuid().v1();
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'farmproduct')
                                                          .doc(snapshot.data!
                                                                  .docs[index]
                                                              ['pid'])
                                                          .collection('comment')
                                                          .doc(id)
                                                          .set({
                                                        'pid': snapshot.data!
                                                            .docs[index]['pid'],
                                                        'comment':
                                                            _commentcontroller
                                                                .text,
                                                        'username':
                                                            user!.username,
                                                        'uid': FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid,
                                                        'cid': id
                                                      });
                                                      showSnackBar(
                                                          'posted', context);
                                                      _commentcontroller
                                                          .clear();
                                                    },
                                                    icon: Icon(Icons.send))
                                              ],
                                            ),
                                          );
                                        }));
                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: Image(
                                                  height: 100,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      snapshot.data!.docs[index]
                                                          ['photourl'])),
                                            ),
                                            Text(snapshot.data!
                                                .docs[index]['productname']
                                                .toString()
                                                .toUpperCase()),
                                            TextButton(
                                                onPressed: () async {
                                                  await FirestoreMethods().addtocart(
                                                      photoUrl: snapshot.data!.docs[index]
                                                          ['photourl'],
                                                      pid: snapshot.data!.docs[index]
                                                          ['pid'],
                                                      unit: snapshot.data!.docs[index]
                                                          ['unit'],
                                                      description:
                                                          snapshot.data!.docs[index]
                                                              ['description'],
                                                      price: snapshot.data!.docs[index]
                                                          ['price'],
                                                      productname:
                                                          snapshot.data!.docs[index]
                                                              ['productname'],
                                                      totalquantity: snapshot
                                                          .data!
                                                          .docs[index]['quantity'],
                                                      context: context);
                                                },
                                                // child: const Positioned(
                                                //   bottom:10
                                                //   child: Icon(Icons.add_shopping_cart)),
                                                //
                                                child: const Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Icon(Icons
                                                        .add_shopping_cart,size: 30,)))
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
    );
  }
}
