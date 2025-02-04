class Doctor {
  final int id;
  final String name;
  final String speciality;
  final String description;
  final String imageUrl;
  final String university;
  final String location;
  final String phone;

  Doctor({
    required this.id,
    required this.name,
    required this.speciality,
    required this.description,
    required this.imageUrl,
    required this.university,
    required this.location,
    required this.phone,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      speciality: json['speciality'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      university: json['university'],
      location: json['location'],
      phone: json['phone'],
    );
  }
}
