import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AppointmentListPage extends StatefulWidget {
  const AppointmentListPage({super.key});

  @override
  _AppointmentListPageState createState() => _AppointmentListPageState();
}

class _AppointmentListPageState extends State<AppointmentListPage> {
  final DatabaseReference _appointmentsRef =
  FirebaseDatabase.instance.ref("appointments");

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
      body: StreamBuilder(
        stream: _appointmentsRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            final Map<dynamic, dynamic> appointments =
            snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            final List<Map<String, dynamic>> appointmentList = appointments.entries
                .map((e) => {
              'id': e.key,
              'data': e.value,
            })
                .toList();

            return ListView.builder(
              itemCount: appointmentList.length,
              itemBuilder: (context, index) {
                final appointment = appointmentList[index];
                final appointmentData = appointment['data'];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      "Doctor: ${appointmentData['doctorName']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date: ${appointmentData['date']}"),
                        Text("Time: ${appointmentData['time']}"),
                        Text("Description: ${appointmentData['description']}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteAppointment(appointment['id']),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "No appointments found.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _deleteAppointment(String appointmentId) async {
    try {
      await _appointmentsRef.child(appointmentId).remove();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Appointment deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting appointment: $e")),
      );
    }
  }
}
