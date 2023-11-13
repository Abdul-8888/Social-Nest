import 'package:chattybuzz/screens/home_screen.dart';
import 'package:chattybuzz/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api/apis.dart';
import '../helper/dialogs.dart';
import '../utils/widgets_function.dart';
import 'auth/login_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("LogOut"),
      onPressed: () async {
        Dialogs.showProgressBar(context);

        await APIs.updateActiveStatus(false);

        //sign out from app
        await APIs.auth.signOut().then((value) async {
          await GoogleSignIn().signOut().then((value) {
            //for hiding progress dialog
            Navigator.pop(context);

            //for moving to home screen
            Navigator.pop(context);

            APIs.auth = FirebaseAuth.instance;

            //replacing home screen with login screen
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginScreen()));
          });
        });
      },
    );

// set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("LogOut?"),
      content: Text("Are you sure you want to LogOut?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return Drawer(
      child: Container(
        height: double.infinity,
        width: 250,
        color: Colors.blue.shade100,
        child: SafeArea(
            child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            addVerticalSpace(20),
            const Center(
              child: ListTile(
                leading: Image(
                  image: AssetImage('images/1.png'),
                ),
                title: Text(
                  "ChattyBuzz",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
              indent: 0,
              endIndent: 0,
              thickness: 1.5,
              height: 40,
            ),
            addVerticalSpace(40),
            Column(
              children: [
                Material(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: const SizedBox(
                          height: 38,
                          width: 38,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              CupertinoIcons.home,
                              color: Colors.blue,
                            ),
                          )),
                      title: const Text(
                        "Home",
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()));
                      },
                    )),
                const Divider(
                  color: Colors.cyan,
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  height: 5,
                ),
                Material(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: const SizedBox(
                          height: 38,
                          width: 38,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              CupertinoIcons.person,
                              color: Colors.blue,
                            ),
                          )),
                      title: const Text(
                        "Profile",
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProfileScreen(user: APIs.me)));
                      },
                    )),
                const Divider(
                  color: Colors.cyan,
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  height: 5,
                ),
                Material(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: const SizedBox(
                          height: 38,
                          width: 38,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              CupertinoIcons.question,
                              color: Colors.blue,
                            ),
                          )),
                      title: const Text(
                        "FAQ",
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {},
                    )),
                const Divider(
                  color: Colors.cyan,
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  height: 5,
                ),
                // Material(
                //     color: Colors.transparent,
                //     child: ListTile(
                //       leading: const SizedBox(
                //           height: 38,
                //           width: 38,
                //           child: CircleAvatar(
                //             backgroundColor: Colors.white,
                //             child: Icon(
                //               CupertinoIcons.settings,
                //               color: Colors.blue,
                //             ),
                //           )),
                //       title: const Text(
                //         "Settings",
                //         style: TextStyle(color: Colors.black),
                //       ),
                //       onTap: () {},
                //     )),
              ],
            ),
            addVerticalSpace(120),
            Material(
                color: Colors.white38,
                child: ListTile(
                  leading: const SizedBox(
                      height: 38,
                      width: 38,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.logout,
                          color: Colors.blue,
                        ),
                      )),
                  title: const Text(
                    "Log Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                )),
            addVerticalSpace(80),
            const Divider(
              color: Colors.black,
              indent: 20,
              endIndent: 20,
              thickness: 1,
              height: 60,
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Center(
                  child: Text(
                "© All rights reserved | For more information\ncontact +923484601027 ",
                textAlign: TextAlign.center,
              )),
            )
          ],
        )),
      ),
    );
  }
}
