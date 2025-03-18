class Student {
  final int id;
  final String studentId;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String? image;
  final int grade;
  final DateTime dateOfBirth;
  final String address;
  final String parentContact;
  final DateTime createdAt;
  final DateTime updatedAt;

  Student({
    required this.id,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    this.image,
    required this.grade,
    required this.dateOfBirth,
    required this.address,
    required this.parentContact,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      studentId: json['student_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'],
      gender: json['gender'],
      image: json['image'],
      grade: json['grade'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      address: json['address'],
      parentContact: json['parent_contact'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'gender': gender,
      'image': image,
      'grade': grade,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'address': address,
      'parent_contact': parentContact,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
} 