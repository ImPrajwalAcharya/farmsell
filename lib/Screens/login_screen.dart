import 'package:farmersapp/Screens/home_screen.dart';
import 'package:farmersapp/Screens/signup_screen.dart';
import 'package:farmersapp/methods/authmethods.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passcontroller.dispose();
    _emailcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passcontroller.text);
    setState(() {
      isLoading = false;
    });
    // showSnackBar(res, context);
    if (res == 'Success✅') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg.jpg'), fit: BoxFit.fill)),
              child: Text("FarmSell",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
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
                          child: Text('Login',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold,
                                  color: Colors.teal)),
                        ),
                        Row(
                          children: [
                            // Container(
                            //     padding: EdgeInsets.only(left: 30),
                            //     width: MediaQuery.of(context).size.width * 0.2,
                            //     child: Text(
                            //       'Email:',
                            //       style: TextStyle(
                            //           fontSize: 15, fontWeight: FontWeight.bold),
                            //     )),
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
                                controller: _passcontroller,
                                obscureText: true,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: 'Password'),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                          child: isLoading?CircularProgressIndicator():TextButton(
                            style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.all(10)),
                                elevation: MaterialStateProperty.all(1)),
                            onPressed: () {
                              loginUser();
                            },
                            child: Text(
                              'Login',
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
                          child: TextButton(
                            style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.all(10)),
                                elevation: MaterialStateProperty.all(1)),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return SignupScreen();
                                },
                              ));
                            },
                            child: Text(
                              'Register an account',
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
