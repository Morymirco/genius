import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/model/model.dart';
import 'package:flutter/material.dart';

class CoursesListScreen extends StatefulWidget {
  static String routeName = '/courses-list';
  const CoursesListScreen({Key? key}) : super(key: key);

  @override
  State<CoursesListScreen> createState() => _CoursesListScreenState();
}

class _CoursesListScreenState extends State<CoursesListScreen> {
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() {
    // Simuler le chargement des cours
    courses = [
      Course(
        title: 'UI/UX Design',
        coursePrice: '200K GNF',
        teacherName: 'Mory koulibaly',
        courseDuration: '1h 15m',
        numberOfLessons: '12 leçons',
        courseImage: 'assets/images/marketting.jpg',
        teacherImage: 'assets/images/samanta-yasamin.jpg',
        courseDescription: 'The UI/UX Design Specialization brings a design centric approach...',
      ),
      Course(
        title: 'HTML & CSS',
        coursePrice: '250K GNF',
        teacherName: 'Souleymane Diallo',
        courseDuration: '2h 10m',
        numberOfLessons: '20 Leçons',
        courseImage: 'assets/images/affiche.jpg',
        teacherImage: 'assets/images/alexander.jpg',
        courseDescription: 'Learn the fundamentals of web development...',
      ),
      Course(
        title: 'HTML & CSS',
        coursePrice: '250K GNF',
        teacherName: 'Souleymane Diallo',
        courseDuration: '2h 10m',
        numberOfLessons: '20 Leçons',
        courseImage: 'assets/images/affiche.jpg',
        teacherImage: 'assets/images/alexander.jpg',
        courseDescription: 'Learn the fundamentals of web development...',
      ),
      // Ajoutez d'autres cours ici
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tous les cours',
          style: TextStyle(
            color: AppColors.colorTint700,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.colorTint700),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return _buildCourseCard(course);
        },
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              course.courseImage ?? '',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        course.title ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.colorTint700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.colorPrimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        course.coursePrice ?? '',
                        style: const TextStyle(
                          color: AppColors.colorPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage(course.teacherImage ?? ''),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      course.teacherName ?? '',
                      style: const TextStyle(
                        color: AppColors.colorTint600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoChip(
                      Icons.access_time,
                      course.courseDuration ?? '',
                    ),
                    const SizedBox(width: 16),
                    _buildInfoChip(
                      Icons.book,
                      course.numberOfLessons ?? '',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.colorTint500,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.colorTint500,
          ),
        ),
      ],
    );
  }
} 