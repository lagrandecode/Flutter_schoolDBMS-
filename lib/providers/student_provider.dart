import 'package:flutter/foundation.dart';
import '../models/student.dart';
import '../services/api_service.dart';

class StudentProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Student> _students = [];
  bool _isLoading = false;
  String _error = '';
  DateTime? _lastFetchTime;
  bool _autoRefreshEnabled = true;

  List<Student> get students => _students;
  bool get isLoading => _isLoading;
  String get error => _error;
  DateTime? get lastFetchTime => _lastFetchTime;
  bool get autoRefreshEnabled => _autoRefreshEnabled;

  // Search functionality
  List<Student> searchStudents(String query) {
    if (query.isEmpty) return _students;
    
    query = query.toLowerCase();
    return _students.where((student) {
      return student.firstName.toLowerCase().contains(query) ||
          student.lastName.toLowerCase().contains(query) ||
          student.studentId.toLowerCase().contains(query) ||
          student.grade.toString().contains(query);
    }).toList();
  }

  // Age distribution
  Map<int, int> getAgeDistribution() {
    final distribution = <int, int>{};
    for (final student in _students) {
      distribution[student.age] = (distribution[student.age] ?? 0) + 1;
    }
    return Map.fromEntries(
      distribution.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key))
    );
  }

  // Grade distribution with percentages
  Map<int, double> getGradeDistributionPercentages() {
    final distribution = <int, int>{};
    for (final student in _students) {
      distribution[student.grade] = (distribution[student.grade] ?? 0) + 1;
    }
    
    final total = _students.length;
    return Map.fromEntries(
      distribution.entries.map(
        (entry) => MapEntry(entry.key, (entry.value / total) * 100),
      ),
    );
  }

  // Toggle auto-refresh
  void toggleAutoRefresh() {
    _autoRefreshEnabled = !_autoRefreshEnabled;
    if (_autoRefreshEnabled) {
      startAutoRefresh();
    }
    notifyListeners();
  }

  // Add auto-refresh timer
  void startAutoRefresh() {
    if (!_autoRefreshEnabled) return;
    
    Future.delayed(const Duration(seconds: 30), () {
      if (_autoRefreshEnabled) {
        fetchStudents();
        startAutoRefresh();
      }
    });
  }

  // Stop auto-refresh
  void stopAutoRefresh() {
    _autoRefreshEnabled = false;
    notifyListeners();
  }

  Future<void> fetchStudents() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      _students = await _apiService.getStudents();
      _lastFetchTime = DateTime.now();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Refresh data if it's older than 30 seconds
  Future<void> refreshIfNeeded() async {
    if (_lastFetchTime == null ||
        DateTime.now().difference(_lastFetchTime!) > const Duration(seconds: 30)) {
      await fetchStudents();
    }
  }

  Future<void> addStudent(Student student) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final newStudent = await _apiService.createStudent(student);
      _students.add(newStudent);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateStudent(Student student) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final updatedStudent = await _apiService.updateStudent(student);
      final index = _students.indexWhere((s) => s.id == student.id);
      if (index != -1) {
        _students[index] = updatedStudent;
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteStudent(int id) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      await _apiService.deleteStudent(id);
      _students.removeWhere((student) => student.id == id);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Map<String, int> getGenderDistribution() {
    final maleCount = _students.where((s) => s.gender == 'M').length;
    final femaleCount = _students.where((s) => s.gender == 'F').length;
    return {
      'Male': maleCount,
      'Female': femaleCount,
    };
  }

  Map<int, int> getGradeDistribution() {
    final distribution = <int, int>{};
    for (final student in _students) {
      distribution[student.grade] = (distribution[student.grade] ?? 0) + 1;
    }
    return Map.fromEntries(
      distribution.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key))
    );
  }

  int getTotalStudents() {
    return _students.length;
  }
} 