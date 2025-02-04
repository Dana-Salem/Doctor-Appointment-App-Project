import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UserProfile.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';
import 'SignupPage.dart';
import 'HomePage.dart';
import 'DoctorsList.dart';
import 'BookAppoinment.dart';
import 'package:flutter_project/BookAppoinment.dart';
import 'AppontmintSchedule.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(

      options: DefaultFirebaseOptions.currentPlatform,

    );
    runApp(MyApp());
  } catch (e) {
    print('Firebase initialization failed: $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          titleTextStyle: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'roboto',
          ),
          iconTheme: IconThemeData(
            color: Colors.grey.shade50,
            size: 24, // Default size
          ),
        ),
      ),
      title: 'MediBook',
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
        '/doctorInfo': (context) => DoctorListPage(),
        '/appointment':(context)=>  AppointmentBookingPage(),
        '/schedule':(context)=> AppointmentListPage(),
        '/profile':(context)=>ProfileScreen(name: '', email: '', phone: '',),
      },
    );
  }
}

class AuthStateHandler extends StatefulWidget {
  @override
  _AuthStateHandlerState createState() => _AuthStateHandlerState();
}

class _AuthStateHandlerState extends State<AuthStateHandler> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _user == null ? LoginPage() : HomePage();
  }
}
