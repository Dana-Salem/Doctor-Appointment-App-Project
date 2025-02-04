import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/DoctorClass.dart'; // Your doctor model file
import 'dart:convert';

class AppointmentBookingPage extends StatefulWidget {
  AppointmentBookingPage({super.key});

  @override
  _AppointmentBookingPageState createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? selectedDoctor;
  List<Doctor> _doctors = [];
  bool _isLoading = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadDoctorsFromJson();
  }

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
  DatabaseReference ref = FirebaseDatabase.instance.ref("appointments");
  void _submitForm() async {
    if (_formKey.currentState!.validate() && selectedDoctor != null) {
      try {
        // Preparing appointment details
        print('Form validated. Submitting appointment...');
        final appointmentDetails = {
          'doctorName': selectedDoctor!,
          'date': _dateController.text.trim(),
          'time': _timeController.text.trim(),
          'name': _nameController.text.trim(),
          'mobile': _mobileController.text.trim(),
          'description': _descriptionController.text.trim(),
        };

        // Reference to Firebase Realtime Database
        DatabaseReference ref = FirebaseDatabase.instance.ref("appointments");  // Realtime Database reference
        // Push new data to the "appointments" node, this automatically generates a unique key
        DatabaseReference newAppointmentRef = ref.push();
        await newAppointmentRef.set(appointmentDetails);  // Add the appointment details

        // Log the document ID (generated key)
        print('Appointment added with ID: ${newAppointmentRef.key}');

        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) => AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.teal,
                  size: 100, // Increased the size to make it huge
                ),
                const SizedBox(height: 20), // Space between icon and title
                const Text(
                  "Appointment Booked",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            content: const Text(
              'Your appointment has been successfully booked.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Close the dialog
                  Navigator.pushNamed(context, '/schedule'); // Navigate to the /Schedule page
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        );

      } catch (e) {
        print('Error adding appointment: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields and select a doctor')));
    }
  }



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
                      (route) => true,
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
                  '/login',
                      (route) => false,
                );
              },
              child: Text(
                'Profile (not routed)',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.network(
                    'https://media.istockphoto.com/id/1222748836/vector/online-medicine-concept-vector-illustration-cartoon-flat-tiny-woman-patient-character-makes.jpg?s=612x612&w=0&k=20&c=bwwmbFhzlKt_WDHKkHY0JpdzSOpuOJGXqH4dEqsJpIg=',
                    height: 150,
                    width: 350,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    Center(
                      child: Text(
                        "Enter Patient Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF105849),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Name field
                TextFormField(
                  controller: _nameController,
                  focusNode: _focusNode, // Add focusNode
                  decoration: InputDecoration(
                    labelText: "Patient Name",
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty";
                    }
                    String pattern = r'^[a-zA-Z ]+$';
                    if (!RegExp(pattern).hasMatch(value)) {
                      return "Name can only contain letters and spaces";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Mobile field
                TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone number cannot be empty";
                    }
                    String pattern = r'^\+?[1-9]\d{1,14}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Dropdown to select doctor
                if (_isLoading)
                  const Center(child: CircularProgressIndicator()) // Show loading spinner while loading doctors
                else
                  DropdownButtonFormField<String>(
                    value: selectedDoctor,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDoctor = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    items: _doctors.map((doctor) {
                      return DropdownMenuItem<String>(
                        value: doctor.name,
                        child: SizedBox(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(doctor.imageUrl),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      doctor.name,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    hint: const Text('Select a doctor'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a doctor';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 10),
                // Description field
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description (Symptoms)",
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Date field
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: "Date",
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  readOnly: true,
                  onTap: _pickDate,
                ),
                const SizedBox(height: 10),
                // Time field
                TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: "Time",
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  readOnly: true,
                  onTap: _pickTime,
                ),
                const SizedBox(height: 20),
                // Book appointment button
                ElevatedButton(
                  onPressed: () {
                    print("Submit button pressed"); // Unfocus any element before submitting
                    _submitForm();
                  },
                  child: Text('Book Now', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to pick date
  Future<void> _pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  // Method to pick time
  Future<void> _pickTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _timeController.text = selectedTime.format(context);
      });
    }
  }
} 