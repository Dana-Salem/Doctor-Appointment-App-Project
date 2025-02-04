
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'DoctorClass.dart';
import 'DoctorInfo.dart';

class DoctorListPage extends StatefulWidget {
  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  List<Doctor> _doctors = [];
  bool _isLoading = true;

  Future<void> _loadDoctorsFromJson() async {
    try {
      final String response = await rootBundle.loadString('assets/doctors.json');
      final dynamic data = json.decode(response);

      if (data is Map<String, dynamic> && data['doctors'] is List<dynamic>) {
        setState(() {
          _doctors = (data['doctors'] as List<dynamic>)
              .map((json) => Doctor.fromJson(json))
              .toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Unexpected JSON structure: Missing "doctors" key or invalid format');
      }
    } catch (e) {
      print('Error loading doctors: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDoctorsFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        backgroundColor: const Color(0xFF17B595),
        title: const Text("MediBook",style: TextStyle(color: Colors.white,),
        )  ,
        // centerTitle: true,
      ),
      
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _doctors.length,
        itemBuilder: (context, index) {
          final doctor = _doctors[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorInfoPage(doctor: doctor),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(doctor.imageUrl),
                ),
                title: Text(
                  doctor.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      doctor.speciality,
                      style: TextStyle(
                          fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 8),
                    Text(
                      doctor.location,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/appointment')   ;
            },
              child: Text('Book Appointment' ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button color
              ),
            ),
              ),
            ),
          );
        },
      ),
    );
  }
}
