import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();
  final TextEditingController _loginemailController = TextEditingController();
  final TextEditingController _loginpasswordController =
  TextEditingController();

  @override
  void dispose() {
    _loginemailController.dispose();
    _loginpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MediBook',
          style: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'roboto',
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.teal,
        ),
      ),
      body:SingleChildScrollView(child:  Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _loginformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  'https://media.istockphoto.com/id/1290139310/vector/vector-of-a-medical-staff-group-of-doctors-and-nurses.jpg?s=612x612&w=0&k=20&c=cYvcXpTZhDWtfd0uZu6vucPOdHP0Zr3I1La0uKsb4rg=',
                  height: 190,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF105849),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _loginemailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains("@")) {
                    return "Email must contain '@'";
                  }
                  if (!value.endsWith(".com")) {
                    return "Email must end with '.com'";
                  }
                  const allowedDomains = [
                    'gmail.com',
                    'yahoo.com',
                    'hotmail.com',
                    'outlook.com',
                    'windowslive.com',
                    'microsoft.com',
                    'icloud.com'
                  ];
                  final domain = value.split('@').last;
                  if (!allowedDomains.contains(domain)) {
                    return "Email must be from one of the allowed domains.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _loginpasswordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String? errorMessage = await _login(
                        _loginemailController.text,
                        _loginpasswordController.text,
                      );
                      if (errorMessage != null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Login Failed"),
                            content: Text(errorMessage),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF13826B),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Sign Up ",
                      style: TextStyle(
                        color: Color(0xFF13826B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
          ),
    );
  }

  Future<String?> _login(String email, String password) async {
    if (_loginformKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushNamed(context, '/home');
        return null; // No error
      } on FirebaseAuthException catch (e) {
        return e.message;
      }
    }
    return null;
  }
}
