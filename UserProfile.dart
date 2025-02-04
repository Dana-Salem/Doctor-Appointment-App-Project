import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  const ProfileScreen({
    Key? key,
    required this.name,
    required this.phone,
    required this.email,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff4cb8c4), Color(0xff3cd3ad)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 60, color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.name,  // Use widget.name to get the passed parameter
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildListTile(icon: Icons.person, label: widget.name),  // Use widget.name
            buildListTile(icon: Icons.phone, label: widget.phone),  // Use widget.phone
            buildListTile(icon: Icons.email, label: widget.email),  // Use widget.email
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                      (route) => false,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(Icons.login)
                ],),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // Adds a notch (optional)
        color: Colors.white, // Background color
        elevation: 15, // Increase elevation for more noticeable shadow
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), // Rounded top corners
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 5, // Spread of the shadow
                blurRadius: 10, // Blur effect
                offset: Offset(0, 3), // Offset of the shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 10), // Adds padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.teal, // Icon color
                ),
                iconSize: 28, // Icon size
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/schedule');
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.teal, // Icon color
                ),
                iconSize: 28, // Icon size
              ),

              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                icon: Icon(
                  Icons.person_2_outlined,
                  color: Colors.teal, // Icon color
                ),
                iconSize: 28, // Icon size
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget buildListTile({required IconData icon, required String label, IconData? trailingIcon}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          leading: Icon(icon),
          title: Text(label),
          trailing: trailingIcon != null ? Icon(trailingIcon, color: Colors.grey) : null,
        ),
      ),
    );
  }
}
