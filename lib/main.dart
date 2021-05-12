import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_skills/services/authintication_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authViews/loginPage.dart';
import 'mainViews/homePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AuthinticationWrapepr()),
    );
  }
}

class AuthinticationWrapepr extends StatefulWidget {
  @override
  _AuthinticationWrapeprState createState() => _AuthinticationWrapeprState();
}

class _AuthinticationWrapeprState extends State<AuthinticationWrapepr> {
  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();

    if (firebaseuser == null) {
      return LogInPage();
    } else {
      return HomePage();
    }
  }
}
