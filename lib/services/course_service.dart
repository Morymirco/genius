import 'package:cloud_firestore/cloud_firestore.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Ajouter un nouveau cours
  Future<void> addCourse(Map<String, dynamic> courseData) async {
    try {
      await _firestore.collection('courses').add({
        ...courseData,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'enrolledStudents': [],
        'ratings': [],
        'averageRating': 0.0,
      });
    } catch (e) {
      print('Erreur lors de l\'ajout du cours: $e');
      rethrow;
    }
  }

  // Initialiser les cours de base
  Future<void> initializeDefaultCourses() async {
    try {
      // Vérifier si des cours existent déjà
      final coursesSnapshot = await _firestore.collection('courses').get();
      if (coursesSnapshot.docs.isNotEmpty) {
        print('Les cours existent déjà');
        return;
      }

      // Liste des leçons par défaut
      final List<Map<String, dynamic>> defaultLessons = [
        {
          'lessonName': 'Introduction au Design',
          'lessonDuration': '02:10',
          'videoUrl': '',
          'description': 'Introduction aux principes de base du design',
          'order': 1,
        },
        {
          'lessonName': 'Principes de base',
          'lessonDuration': '10:25',
          'videoUrl': '',
          'description': 'Les fondamentaux du design UI/UX',
          'order': 2,
        },
        {
          'lessonName': 'Prototypage',
          'lessonDuration': '07:55',
          'videoUrl': '',
          'description': 'Création de prototypes interactifs',
          'order': 3,
        },
      ];

      // Liste des cours par défaut avec les bons chemins d'images
      final List<Map<String, dynamic>> defaultCourses = [
        {
          'title': 'Digital Marketing',
          'coursePrice': '80K GNF',
          'teacherName': 'Albert Siba Beavogui',
          'courseDuration': '2h 15m',
          'numberOfLessons': '15 leçons',
          'courseImage': 'assets/images/marketting.jpg',
          'teacherImage': 'assets/images/alexander.jpg',
          'courseDescription': 'The Digital Marketing course brings a comprehensive approach...',
          'lessons': defaultLessons,
          'sliderImages': [
            'assets/images/ui-ux-design.jpg',
            'assets/images/coding.jpg',
            'assets/images/marketing.jpg'
          ],
          'category': 'Marketing',
          'level': 'Débutant',
        },
        {
          'title': 'UI/UX Design',
          'coursePrice': '200K GNF',
          'teacherName': 'Mory koulibaly',
          'courseDuration': '1h 15m',
          'numberOfLessons': '12 leçons',
          'courseImage': 'assets/images/marketting.jpg',
          'teacherImage': 'assets/images/samanta-yasamin.jpg',
          'courseDescription': 'The UI/UX Design Specialization brings a design centric approach...',
          'lessons': defaultLessons,
          'sliderImages': [
            'assets/images/ui-ux-design.jpg',
            'assets/images/coding.jpg',
            'assets/images/marketing.jpg'
          ],
          'category': 'Design',
          'level': 'Intermédiaire',
        },
        {
          'title': 'HTML & CSS',
          'coursePrice': '250K GNF',
          'teacherName': 'Souleymane Diallo',
          'courseDuration': '2h 10m',
          'numberOfLessons': '20 Leçons',
          'courseImage': 'assets/images/affiche.jpg',
          'teacherImage': 'assets/images/alexander.jpg',
          'courseDescription': 'Learn the fundamentals of web development...',
          'lessons': defaultLessons,
          'sliderImages': [
            'assets/images/ui-ux-design.jpg',
            'assets/images/coding.jpg',
            'assets/images/marketing.jpg'
          ],
          'category': 'Développement Web',
          'level': 'Débutant',
        },
        {
          'title': 'Flutter Development',
          'coursePrice': '300K GNF',
          'teacherName': 'Thierno Barry',
          'courseDuration': '3h 30m',
          'numberOfLessons': '25 Leçons',
          'courseImage': 'assets/images/coding.jpg',
          'teacherImage': 'assets/images/alexander.jpg',
          'courseDescription': 'Learn Flutter development from scratch...',
          'lessons': defaultLessons,
          'sliderImages': [
            'assets/images/ui-ux-design.jpg',
            'assets/images/coding.jpg',
            'assets/images/marketing.jpg'
          ],
          'category': 'Mobile Development',
          'level': 'Intermédiaire',
        },
        {
          'title': 'React Native',
          'coursePrice': '280K GNF',
          'teacherName': 'Mamadou Diallo',
          'courseDuration': '2h 45m',
          'numberOfLessons': '18 Leçons',
          'courseImage': 'assets/images/3affiche.jpg',
          'teacherImage': 'assets/images/alexander.jpg',
          'courseDescription': 'Master React Native development...',
          'lessons': defaultLessons,
          'sliderImages': [
            'assets/images/ui-ux-design.jpg',
            'assets/images/coding.jpg',
            'assets/images/marketing.jpg'
          ],
          'category': 'Mobile Development',
          'level': 'Avancé',
        },
      ];

      // Ajouter chaque cours dans Firestore
      for (var courseData in defaultCourses) {
        await addCourse(courseData);
        print('Cours ajouté: ${courseData['title']}');
      }

      print('Cours initialisés avec succès');
    } catch (e) {
      print('Erreur lors de l\'initialisation des cours: $e');
      rethrow;
    }
  }

  // Obtenir tous les cours
  Stream<QuerySnapshot> getAllCourses() {
    return _firestore
        .collection('courses')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Obtenir un cours par son ID
  Future<DocumentSnapshot> getCourseById(String courseId) {
    return _firestore.collection('courses').doc(courseId).get();
  }

  // Mettre à jour un cours
  Future<void> updateCourse(String courseId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('courses').doc(courseId).update({
        ...updates,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Erreur lors de la mise à jour du cours: $e');
      rethrow;
    }
  }

  // Supprimer un cours
  Future<void> deleteCourse(String courseId) async {
    try {
      await _firestore.collection('courses').doc(courseId).delete();
    } catch (e) {
      print('Erreur lors de la suppression du cours: $e');
      rethrow;
    }
  }
} 