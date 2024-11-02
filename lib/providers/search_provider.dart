import 'package:flutter/foundation.dart';
import 'package:coursenligne/model/model.dart';

class SearchProvider with ChangeNotifier {
  List<Course> _allCourses = [];
  List<Course> _filteredCourses = [];
  String _searchQuery = '';

  List<Course> get filteredCourses => _filteredCourses;
  String get searchQuery => _searchQuery;

  void setAllCourses(List<Course> courses) {
    _allCourses = courses;
    _filterCourses();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _filterCourses();
  }

  void _filterCourses() {
    if (_searchQuery.isEmpty) {
      _filteredCourses = List.from(_allCourses);
    } else {
      _filteredCourses = _allCourses.where((course) {
        final title = course.title?.toLowerCase() ?? '';
        final description = course.courseDescription?.toLowerCase() ?? '';
        final teacher = course.teacherName?.toLowerCase() ?? '';
        
        return title.contains(_searchQuery) ||
               description.contains(_searchQuery) ||
               teacher.contains(_searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredCourses = List.from(_allCourses);
    notifyListeners();
  }
} 