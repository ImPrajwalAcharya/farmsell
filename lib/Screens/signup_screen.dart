import 'package:farmersapp/Screens/home_screen.dart';
import 'package:farmersapp/Screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../methods/authmethods.dart';
import '../utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isloading = false;
  TextEditingController _passcontroller1 = TextEditingController();
  TextEditingController _passcontroller2 = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
    void signupuser() async {
    setState(() {
      isloading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: _emailcontroller.text,
        password: _passcontroller1.text,
        username: _usernamecontroller.text,
        bio: '',
        );
    setState(() {
      isloading = false;
    });
    // showSnackBar(res, context);
    if (res == 'Success✅') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passcontroller1.dispose();
    _passcontroller2.dispose();
    _emailcontroller.dispose();
    _usernamecontroller.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal
              ),
              child: Text("FarmSell",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  )),
            ),
            Center(
              child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  child: Card(
                    // color: Colors.transparent,
                    shadowColor: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                          child: Text('Register',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold,
                                  color: Colors.teal,)),
                        ),
                        Row(
                          children: [
                            // Container(
                            //     padding: EdgeInsets.only(left: 30),
                            //     width: MediaQuery.of(context).size.width * 0.2,
                            //     child: Text('Username:',
                            //         style: TextStyle(
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.bold))),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                              child: TextField(
                                controller: _usernamecontroller,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: 'Username'),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            // Container(
                            //     padding: EdgeInsets.only(left: 30),
                            //     width: MediaQuery.of(context).size.width * 0.2,
                            //     child: Text('Email:',
                            //         style: TextStyle(
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.bold))),
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextField(
                                controller: _emailcontroller,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: 'Email'),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            // Container(
                            //     padding: EdgeInsets.only(left: 30),
                            //     width: MediaQuery.of(context).size.width * 0.2,
                            //     child: Text(
                            //       'Password:',
                            //       style: TextStyle(
                            //           fontSize: 15, fontWeight: FontWeight.bold),
                            //     )),
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextField(
                                controller: _passcontroller1,
                                obscureText: true,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: 'Password'),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            // Container(
                            //     padding: EdgeInsets.only(left: 30),
                            //     width: MediaQuery.of(context).size.width * 0.2,
                            //     child: Text(
                            //       'Password:',
                            //       style: TextStyle(
                            //           fontSize: 15, fontWeight: FontWeight.bold),
                            //     )),
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextField(
                                controller: _passcontroller2,
                                obscureText: true,
                                
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                  errorText: _passcontroller1.text==_passcontroller2.text? null:'write same pass' ,
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: ' Confirm Password'),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                          child: isloading?CircularProgressIndicator(): TextButton(
                            style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.all(10)),
                                elevation: MaterialStateProperty.all(1)),
                            onPressed: () {
                              signupuser();
                            },
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                          child:  TextButton(
                            style: ButtonStyle(
                              
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.all(10)),
                                elevation: MaterialStateProperty.all(1)),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ));
                            },
                            child: Text(
                              'Already have an account ?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
