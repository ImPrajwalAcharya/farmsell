import 'dart:convert';

import 'package:farmersapp/model/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmersapp/methods/authmethods.dart';
import 'package:farmersapp/methods/firestore_methods.dart';
import 'package:farmersapp/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

List<dynamic> fruits = jsonDecode(fruitList);

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Usermodel? user;
  List<num> totalsaleslist = [];
  num totalsales = 0;
  num stock = 0;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    user = await AuthMethods().getUserDetails();
    final data = await FirebaseFirestore.instance
        .collection('farmproduct')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (var i in data.docs) {
      if (i['soldquantity'] != '') {
        totalsales = totalsales + i['soldquantity'];
        totalsaleslist.add(i['soldquantity']);
      } else {
        totalsaleslist.add(0);
      }

      stock = stock + num.parse(i['quantity']);
    }
    setState(() {
      totalsales;
      stock;
      totalsaleslist;
    });
    print(totalsaleslist);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      // appBar: AppBar(
      //   title: Text('Dashboard'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'HELLO',
               
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'Solway',
                ),
              ),
            ),
            CircleAvatar(
                radius: 60, backgroundImage: NetworkImage(user!.photoUrl)),
            Text(user!.username.toUpperCase(), style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontFamily: 'Solway',
                ),),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  elevation: 2,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'My Product',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'Total',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'Sold',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('farmproduct')
                                      .where('uid',
                                          isEqualTo: FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(snapshot.data!
                                                  .docs[index]['productname']),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(snapshot.data!
                                                  .docs[index]['quantity']),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(totalsaleslist[index]
                                                  .toString()),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  })),
                          Column(
                            children: [
                              Text('Total: $stock '),
                              Text('Remaining: ${stock - totalsales}')
                            ],
                          )
                        ],
                      )),
                ),
                Card(
                  elevation: 2,
                  child: Container(
                    
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        children: [
                          Text('Sales'),
                          Expanded(
                              child: CircularPercentIndicator(
                            radius: 60.0,
                            lineWidth: 10.0,
                            animation: true,
                            percent: totalsales / (stock),
                            center: Text(
                              (totalsales * 100 / (stock)).toStringAsFixed(3) +
                                  "%",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            backgroundColor: Colors.grey,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.redAccent,
                            footer: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      color: Colors.red,
                                      width: 20,
                                      height: 2,
                                    ),
                                    Text('Sales'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      color: Colors.grey,
                                      width: 20,
                                      height: 2,
                                    ),
                                    Text('Stock')
                                  ],
                                )
                              ],
                            ),
                          ))
                        ],
                      )),
                )
              ],
            )),
            Column(
                // appBar: AppBar(
                //   foregroundColor: Colors.white,
                //   title: Text('Articles'),
                // ),
                children: [
                  Container(
                    
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.white),
                      ),
                    ),
                    child: Text(
                      'Articles',
                      style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Solway',
                ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.45,
                    child: ListView.builder(
                      itemCount: fruits.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Scaffold(
                                appBar:
                                    AppBar(title: Text(fruits[index]['name'])),
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
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        //for the image
                                                        height: 250,
                                                        width: 250,
                                                        child: Image(
                                                          image: NetworkImage(
                                                              fruits[index][
                                                                  'photo_url']),
                                                        ),
                                                      ),
                                                      Card(
                                                          elevation: 5,
                                                          child: ListTile(
                                                            title: Text(
                                                              fruits[index][
                                                                  'description'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                            color: Colors.white,
                            shadowColor: Colors.black,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  fruits[index]['name'],
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'Roboto',
                                    color: new Color(0xFF212121),
                                  ),
                                ),
                                Image(
                                    height: 50,
                                    width: 150,
                                    image: NetworkImage(
                                        fruits[index]['photo_url'])),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  width: 150,
                                  height: 50,
                                  child: Text(
                                    fruits[index]['description'],
                                    softWrap: true,
                                    style: TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontSize: 13.0,
                                      fontFamily: 'Roboto',
                                      color: new Color(0xFF212121),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
