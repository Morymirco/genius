import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/model/model.dart';
import 'package:coursenligne/screen/course-detail/course-detail.dart';
import 'package:flutter/material.dart';

import '../../util/util.dart';

class CoursesListScreen extends StatefulWidget {
  static String routeName = '/courses-list';
  const CoursesListScreen({Key? key}) : super(key: key);

  @override
  State<CoursesListScreen> createState() => _CoursesListScreenState();
}

class _CoursesListScreenState extends State<CoursesListScreen> {
  List<Course> courses = [];
  String _selectedFilter = 'Tous';

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() {
    // Créer une liste de leçons
    List<Lesson> lessons = [
      Lesson(
        lessonName: 'Introduction au Design',
        lessonDuration: '02:10'
      ),
      Lesson(
        lessonName: 'Principes de base',
        lessonDuration: '10:25'
      ),
      Lesson(
        lessonName: 'Prototypage',
        lessonDuration: '07:55'
      ),
    ];

    // Simuler le chargement des cours avec les leçons
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
        lessons: lessons,
        sliderImages: ['assets/images/ui-ux-design.jpg', 'assets/images/coding.jpg', 'assets/images/marketing.jpg'],
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
        lessons: lessons,
        sliderImages: ['assets/images/ui-ux-design.jpg', 'assets/images/coding.jpg', 'assets/images/marketing.jpg'],
      ),
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
        automaticallyImplyLeading: false,
        title: const Text(
          'Tous les cours',
          style: TextStyle(
            color: AppColors.colorTint700,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Container(
          height: getProportionateScreenWidth(40),
          width: getProportionateScreenWidth(40),
          margin: EdgeInsets.only(left: getProportionateScreenWidth(15)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.colorTint400)
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.colorTint600, 
              size: 18,
            ),
            onPressed: () {
              // Vérifier si on peut retourner en arrière
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                // Si on ne peut pas retourner en arrière, rediriger vers la page d'accueil
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
          ),
        ),
        actions: [
          Container(
            height: getProportionateScreenWidth(40),
            width: getProportionateScreenWidth(40),
            margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.colorTint400)
            ),
            child: IconButton(
              icon: Icon(
                Icons.filter_list,
                color: AppColors.colorTint600,
                size: 20,
              ),
              onPressed: _showFilterDialog,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return _buildCourseCard(course);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('Tous'),
          _buildFilterChip('Populaires'),
          _buildFilterChip('Nouveautés'),
          _buildFilterChip('En cours'),
          _buildFilterChip('Terminés'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            _selectedFilter = selected ? label : 'Tous';
          });
        },
        backgroundColor: isSelected ? const Color(0xFF43BCCD) : AppColors.colorTint200,
        selectedColor: const Color(0xFF43BCCD),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF6A3085),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filtres',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorTint700,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildFilterSection('Prix', ['Gratuit', '< 50€', '50€ - 100€', '> 100€']),
                    const SizedBox(height: 20),
                    _buildFilterSection('Durée', ['< 2h', '2h - 5h', '5h - 10h', '> 10h']),
                    const SizedBox(height: 20),
                    _buildFilterSection('Niveau', ['Débutant', 'Intermédiaire', 'Avancé']),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              side: const BorderSide(color: Color(0xFF43BCCD)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Réinitialiser',
                              style: TextStyle(
                                color: Color(0xFF43BCCD),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF43BCCD),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Appliquer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.colorTint700,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) => FilterChip(
            label: Text(option),
            onSelected: (bool selected) {},
            backgroundColor: AppColors.colorTint200,
            labelStyle: const TextStyle(color: AppColors.colorTint700),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildCourseCard(Course course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(course: course),
          ),
        );
      },
      child: Container(
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
                          color: const Color(0xFF43BCCD).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          course.coursePrice ?? '',
                          style: const TextStyle(
                            color: Color(0xFF43BCCD),
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