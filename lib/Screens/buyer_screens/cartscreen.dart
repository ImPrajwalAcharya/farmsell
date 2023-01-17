import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var products;
  num total = 0;
  caltotal() async {
    final ref = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('mycart')
        .get();
    for (var i in ref.docs) {
      total = total + i.data()['quantity'] * num.parse(i.data()['price']);
    }
    setState(() {
      total;
    });
  }

  @override
  void initState() {
    caltotal();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('mycart')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                              title: Text(
                                  snapshot.data!.docs[index]['productname'])),
                          body: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Hero(
                                    tag: 'DetailedView',
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Card(
                                            elevation: 5,
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(20),
                                                  //for the image
                                                  height: 250,
                                                  width: 250,
                                                  child: Image(
                                                    image: NetworkImage(snapshot
                                                            .data!.docs[index]
                                                        ['photourl']),
                                                  ),
                                                ),
                                                Card(
                                                    elevation: 5,
                                                    child: ListTile(
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
                                                    )),
                                                ListTile(
                                                    subtitle: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Text(
                                                    snapshot.data!.docs[index]
                                                        ['description'],
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )),
                                              ],
                                            ))
                                      ],
                                    )),
                              ]),
                        );
                      }));
                    },
                    child: Card(
                        child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image(
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  snapshot.data!.docs[index]['photourl'])),
                        ),
                        Text(snapshot.data!.docs[index]['productname']
                            .toString()
                            .toUpperCase()),
                        Text(
                            'Quantity: ${snapshot.data!.docs[index]['quantity'].toString()}'),
                        Text(
                            'Total: ${snapshot.data!.docs[index]['quantity'] * num.parse(snapshot.data!.docs[index]['price'])}')
                      ],
                    )),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: Text(' TOTAL BILL: ${total.toString()}'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      var collection = FirebaseFirestore.instance
                          .collection('user')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('mycart');
                      var snapshots = await collection.get();
                      for (var doc in snapshots.docs) {
                        await doc.reference.delete();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 30),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text('BUY'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var collection = FirebaseFirestore.instance
                          .collection('user')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('mycart');
                      var snapshots = await collection.get();
                      for (var doc in snapshots.docs) {
                        FirebaseFirestore.instance
                            .collection('farmproduct')
                            .doc(doc.data()['pid'])
                            .update({
                          'soldquantity':
                              FieldValue.increment(-doc.data()['quantity'])
                        });
                        await doc.reference.delete();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 30),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text('CLEAR'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Container(
        //   height: MediaQuery.of(context).size.height*0.2,
        //   child: Row(
        //     children: [
        //       InkWell(
        //         child: Container(
        //           padding: EdgeInsets.all(20),
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //             color: Colors.green,
        //           ),
        //           child: Text('checkout'),
        //         ),
        //       ),
        //       InkWell(
        //         onTap: () async {
        //           var collection = FirebaseFirestore.instance
        //               .collection('user')
        //               .doc(FirebaseAuth.instance.currentUser!.uid)
        //               .collection('mycart');
        //           var snapshots = await collection.get();
        //           for (var doc in snapshots.docs) {
        //             await doc.reference.delete();
        //           }
        //         },
        //         child: Container(
        //           padding: EdgeInsets.all(20),
        //           decoration: BoxDecoration(
        //             color: Colors.green,
        //           ),
        //           child: Text('Clear'),
        //         ),
        //       ),
        //     ],
        //   ),
        // )
      ],
    )));
  }
}
