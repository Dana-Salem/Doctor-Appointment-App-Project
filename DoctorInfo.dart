import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'DoctorClass.dart';

class DoctorInfoPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorInfoPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17B595),
        title: const Text("MediBook",style: TextStyle(color: Colors.white,),)  ,
        // centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 30),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                      (route) => false,
                );
              },
              child: Text(
                'Home',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/schedule',
                      (route) => false,
                );
              },
              child: Text(
                'Appointments',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/profile',
                      (route) => true,
                );
              },
              child: Text(
                'Profile ',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Spacer(),

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // Rounded corners
                border: Border.all(
                  color: Colors.teal, // Border color
                  width: 2, // Border width
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(doctor.imageUrl),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name: ',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade500,
                              ),
                            ),
                            Text(
                              doctor.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Speciality: ',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade500,
                              ),
                            ),
                            Text(
                              doctor.speciality,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'University: ',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade500,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                doctor.university,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Location: ',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade500,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                doctor.location,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Phone: ',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade500,
                              ),
                            ),
                            Text(
                              doctor.phone,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Description: ',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade500,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                doctor.description,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/appointment');
              },
              child: Center(
                child: Text(
                  'Book Appointment',
                  style: TextStyle( fontSize: 17),
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
