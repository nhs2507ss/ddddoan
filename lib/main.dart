/*import 'package:doan1/UI/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:doan1/UI/home/home.dart';
import 'package:doan1/UI/signup/sign_up_screen.dart';


void main() => runApp(const Learnify1());
class Learnify1 extends StatefulWidget {const Learnify1({super.key});



  @override
  State<Learnify1> createState() => _Learnify1State();
}



class _Learnify1State extends State<Learnify1> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // Load the login status from shared preferences
    isLoggedIn = widget.prefs.getBool('isLoggedIn') ?? false;
  }


  void login() {
    setState(() {
      isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: isLoggedIn ? const MusicHomePage() : LoginScreen(login: login),
      routes: {
        '/login': (context) => LoginScreen(login: login),
        '/signup': (context) => const SignUpScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:ddddoan/UI/home/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'UI/login/login_screen.dart';
import 'UI/signup/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false); // Thêm dòng này
  runApp(Learnify1(prefs: prefs));
}

class Learnify1 extends StatefulWidget {
  final SharedPreferences prefs;
  const Learnify1({super.key, required this.prefs});

  @override
  State<Learnify1> createState() => _Learnify1State();
}

class _Learnify1State extends State<Learnify1> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // Load the login status from shared preferences
    isLoggedIn = widget.prefs.getBool('isLoggedIn') ?? false;
  }

  void login() {
    setState(() {
      isLoggedIn = true;
      widget.prefs.setBool('isLoggedIn', true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefs = widget.prefs;
    return MaterialApp(

      title: 'Learnify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: isLoggedIn ? const MusicHomePage() : LoginScreen(login: login, prefs: prefs),
      routes: {
        '/login': (context) => LoginScreen(login: login, prefs: prefs),
        '/signup': (context) => SignUpScreen(login: login, prefs: prefs),
      },
      debugShowCheckedModeBanner: false,

    );
  }
}

