//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                        (route) => false,
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
        body: SingleChildScrollView(
          // Wrap body in SingleChildScrollView
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Colors.teal.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Search Bar
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search doctors",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Quote Box
                Container(
                  width: double.infinity,
                  height: 180,
                  // Adjust the height based on your UI
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.purple],
                    ),
                    border: Border.all(
                        color: Colors.teal, style: BorderStyle.solid),
                    // color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Featured Doctors",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing:
                          1.0, // Slight spacing for better readability
                        ),
                        textAlign: TextAlign.center, // Center the text
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            // Doctor Card 1
                            Container(
                              width: 300,
                              // Card width
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        "https://png.pngtree.com/png-vector/20191205/ourmid/pngtree-female-doctor-vector-illustration-png-image_2026067.jpg"),
                                    // Replace with doctor's image URL
                                  ),
                                  SizedBox(height: 8),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dr. Maria",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.end,
                                      ),
                                      Text(
                                        "Dentist\nExperienced in cosmetic\nand restorative dentistry.",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(height: 25),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            // Doctor Card 2
                            Container(
                              width: 300,
                              // Card width
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        "https://t3.ftcdn.net/jpg/09/17/31/14/360_F_917311412_if4GDw0gVWsOrTNMeNUVpQQ0BegWdgxK.jpg"),
                                    // Replace with doctor's image URL
                                  ),
                                  SizedBox(height: 8, width: 8),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dr. Camilia",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.end,
                                      ),
                                      Text(
                                        "Family Doctor\nExperienced in comprehensive \nfamily medicine .",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            // Doctor Card 3
                            Container(
                              width: 300,
                              // Card width
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        "https://thumbs.dreamstime.com/z/doctor-wearing-medical-mask-portrait-young-man-stethoscope-realistic-vector-illustration-180698583.jpg"),
                                    // Replace with doctor's image URL
                                  ),
                                  SizedBox(height: 8, width: 10),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dr. Filip",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.end,
                                      ),
                                      Text(
                                        "Surgeon\n Experienced in invasive\n and complex abdominal surgeries",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            // Doctor Card 4
                            Container(
                              width: 300,
                              // Card width
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        "https://www.shutterstock.com/image-vector/vector-medical-icon-doctor-image-600nw-1170228883.jpg"),
                                    // Replace with doctor's image URL
                                  ),
                                  SizedBox(height: 8, width: 8),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dr. Smith",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        "Cardiologist\nSpecialist in cancer cases \nand cardiovascular complications.",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Doctor Specialties Scrollable Section
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 80, // Reduced height
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/doctorInfo');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            padding: const EdgeInsets.all(8), // Reduced padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.monitor_heart_outlined,
                                color: Colors.white,
                                size: 28, // Reduced icon size
                              ),
                              SizedBox(height: 6),
                              Text(
                                'CARDIOLOGY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14, // Reduced text size
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // Reduced spacing
                    Expanded(
                      child: SizedBox(
                        height: 80, // Reduced height
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/doctorInfo');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber.shade400,
                            padding: const EdgeInsets.all(8), // Reduced padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.child_care,
                                color: Colors.white,
                                size: 28, // Reduced icon size
                              ),
                              SizedBox(height: 6),
                              Text(
                                'PEDIATRIC',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14, // Reduced text size
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // Reduced spacing
                    Expanded(
                      child: SizedBox(
                        height: 80, // Reduced height
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/doctorInfo');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.all(8), // Reduced padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.family_restroom,
                                color: Colors.white,
                                size: 28, // Reduced icon size
                              ),
                              SizedBox(height: 6),
                              Text(
                                'FAMILY MEDICINE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14, // Reduced text size
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                // What People Think About Us Scrollable Section
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        padding: EdgeInsets.all(15),
                        margin:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star_border,
                                    size: 15, color: Colors.teal),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Great Experience! I had a great experience using this site to book my doctor’s appointments. The process was seamless, and I received reminders to ensure I never missed an appointment.',
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        padding: EdgeInsets.all(15),
                        margin:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star_half,
                                    size: 15, color: Colors.teal),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Time-Saving and Efficient! I love how quick and efficient this service is. I can find available appointments instantly and book them in just a few clicks. It has saved me so much time!',
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        padding: EdgeInsets.all(15),
                        margin:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star, size: 15, color: Colors.teal),
                                Icon(Icons.star_half,
                                    size: 15, color: Colors.teal),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Easy and Convenient! Booking an appointment with my doctor has never been easier. The website is simple to navigate, and I can schedule my visits without any hassle. Highly recommend!',
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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

      ),
    );
  }
}
