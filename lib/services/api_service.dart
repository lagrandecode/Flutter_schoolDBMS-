import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class ApiService {
  static String get baseUrl {
    // For Android emulator, use 10.0.2.2 instead of localhost
    if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:8000/api';
    }
    // For iOS simulator and desktop, use localhost
    return 'http://127.0.0.1:8000/api';
  }

  Future<List<Student>> getStudents() async {
    try {
      debugPrint('Fetching students from: $baseUrl/students/');
      final response = await http.get(
        Uri.parse('$baseUrl/students/'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('results')) {
          final List<dynamic> data = responseData['results'];
          return data.map((json) => Student.fromJson(json)).toList();
        } else {
          throw Exception('Invalid response format: missing results key');
        }
      } else {
        throw Exception('Failed to load students: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching students: $e');
      throw Exception('Error fetching students: $e');
    }
  }

  Future<Student> createStudent(Student student) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/students/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(student.toJson()),
      );

      if (response.statusCode == 201) {
        return Student.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create student');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Student> updateStudent(Student student) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/students/${student.id}/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(student.toJson()),
      );

      if (response.statusCode == 200) {
        return Student.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update student');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteStudent(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/students/$id/'),
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete student');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

