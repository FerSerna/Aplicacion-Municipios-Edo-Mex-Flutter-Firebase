//Import classes

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Firebase things
import 'package:firebase_core/firebase_core.dart';

import 'adminPage.dart';
import 'consultorPage.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error')),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;
                if (user == null) {
                  //usuario NO logeado
                  return MaterialApp(
                    title: "Blog ...",
                    theme: ThemeData(primarySwatch: Colors.amber),
                    debugShowCheckedModeBanner: false,
                    home: Login(),
                  );
                } else {
                  //usuario logeado
                  if (!user.isAnonymous) {
                    if (user.email.toString() == "admin@gmail.com") {
                      return MaterialApp(
                        title: "Blog ...",
                        theme: ThemeData(primarySwatch: Colors.amber[100]),
                        debugShowCheckedModeBanner: false,
                        home: AdminPage(),
                      );
                    }
                    if (user.email.toString() != "admin@gmail.com") {
                      return MaterialApp(
                        title: "Blog ...",
                        theme: ThemeData(primarySwatch: Colors.amber[100]),
                        debugShowCheckedModeBanner: false,
                        home: ConsultorPage(),
                      );
                      //return UserPage();
                    }
                  }
                }
              }

              return Scaffold(
                body: Center(child: Text('Checkin auth')),
              );
            },
          );
        }

        return Scaffold(
            body: Center(
          child: Text('Conecting to app...'),
        ));
      },
    );
  }
}
