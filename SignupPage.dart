import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'UserProfile.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _signup() async {
    if (_signupFormKey.currentState!.validate()) {
      try {
        // Call Firebase Authentication to create a user
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Navigate to home page or show success message
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              name: _nameController.text,
              phone: _phoneController.text,
              email: _emailController.text,
            ),
          ),
        );
        print('User created: ${credential.user?.email}');
      } on FirebaseAuthException catch (e) {
        // Handle Firebase-specific errors
        if (e.code == 'weak-password') {
          _showErrorDialog('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          _showErrorDialog('The account already exists for that email.');
        } else if (e.code == 'invalid-email') {
          _showErrorDialog('The email address is not valid.');
        } else {
          _showErrorDialog('An unexpected error occurred: ${e.message}');
        }
      } catch (e) {
        // Handle other errors
        _showErrorDialog('An unexpected error occurred: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
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
          backgroundColor: Colors.teal,
          iconTheme: IconThemeData(size: 45, color: Colors.grey.shade50),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //the image
                    Center(
                      child: Image.network(
                        'https://media.istockphoto.com/id/1290139310/vector/vector-of-a-medical-staff-group-of-doctors-and-nurses.jpg?s=612x612&w=0&k=20&c=cYvcXpTZhDWtfd0uZu6vucPOdHP0Zr3I1La0uKsb4rg=',
                        height: 190,
                        width: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'roboto',
                            color: Color(0xFF105849),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Name Field
                    Center(
                      child: Container(
                        width: 550,
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            filled: true,
                            fillColor: Colors.teal.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.person, color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Email Field
                    Center(
                      child: Container(
                        width: 550,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            filled: true,
                            fillColor: Colors.teal.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.email, color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Phone Field
                    Center(
                      child: Container(
                        width: 550,
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            filled: true,
                            fillColor: Colors.teal.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.phone, color: Colors.grey),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone number cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Password Field
                    Center(
                      child: Container(
                        width: 550,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            filled: true,
                            fillColor: Colors.teal.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.lock, color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Confirm Password Field
                    Center(
                      child: Container(
                        width: 550,
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            filled: true,
                            fillColor: Colors.teal.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.lock, color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (value != _passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Sign Up Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _signup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF13826B),
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              color: Color(0xFF13826B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Signup Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
