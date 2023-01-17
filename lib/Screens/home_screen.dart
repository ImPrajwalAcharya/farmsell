import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmersapp/Screens/buyer_screen.dart';
import 'package:farmersapp/Screens/farmerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            if ((snapshot.data as dynamic)['mode'] == '') {
              return Scaffold(
                body: Stack(children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/bg.jpg'),
                            fit: BoxFit.fill)),
                    child: Text("FARMSELL",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(221, 196, 195, 195),
                        )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        child: FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            child: Card(
                              color: Colors.transparent,
                              shadowColor: Color.fromARGB(255, 233, 233, 233),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 20, 25, 30),
                                  child: TextButton(
                                    child: Text('Buyers Mode',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    onPressed: () async {
                                  await FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                                  'mode':'buyer'
                                });
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) => BuyerScreen(),
                                      ));
                                    },
                                  )),
                            )),
                      ),
                      Center(
                        child: FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            child: Card(
                              color: Colors.transparent,
                              shadowColor: Color.fromARGB(255, 233, 233, 233),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 30),
                                  child: TextButton(
                                    child: Text('Farmers Mode',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    onPressed: () async{
                                                                  await FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                                  'mode':'farmer'
                                });
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) => FarmerScreen(),
                                      ));
                                    },
                                  )),
                            )),
                      ),
                    ],
                  ),
                ]),
              );
            } else if ((snapshot.data as dynamic)['mode'] == 'buyer') {
              return BuyerScreen();
            } else {
              return FarmerScreen();
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
