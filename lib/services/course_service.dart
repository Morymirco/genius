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
          'videoUrl': 'https://example.com/video1.mp4',
          'description': 'Introduction aux principes de base du design',
          'order': 1,
        },
        {
          'lessonName': 'Principes de base',
          'lessonDuration': '10:25',
          'videoUrl': 'https://example.com/video2.mp4',
          'description': 'Les fondamentaux du design UI/UX',
          'order': 2,
        },
        {
          'lessonName': 'Prototypage',
          'lessonDuration': '07:55',
          'videoUrl': 'https://example.com/video3.mp4',
          'description': 'Création de prototypes interactifs',
          'order': 3,
        },
      ];

      // Liste des cours par défaut
      final List<Map<String, dynamic>> defaultCourses = [
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
          'requirements': [
            'Connaissances de base en design',
            'Ordinateur avec Figma installé'
          ],
          'whatYouWillLearn': [
            'Principes de design UI/UX',
            'Création de wireframes',
            'Prototypage avec Figma'
          ],
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
          'requirements': [
            'Aucun prérequis nécessaire',
            'Un éditeur de texte'
          ],
          'whatYouWillLearn': [
            'Structure HTML',
            'Styles CSS',
            'Responsive Design'
          ],
        },
        // Ajoutez d'autres cours ici
      ];

      // Ajouter chaque cours dans Firestore
      for (var courseData in defaultCourses) {
        await addCourse(courseData);
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