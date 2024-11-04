import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Référence aux collections
  CollectionReference get _users => _firestore.collection('users');
  CollectionReference get _courses => _firestore.collection('courses');
  CollectionReference get _enrollments => _firestore.collection('enrollments');

  // Créer un profil utilisateur
  Future<void> createUserProfile(String uid, Map<String, dynamic> userData) async {
    try {
      await _users.doc(uid).set({
        ...userData,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Erreur lors de la création du profil: $e');
      rethrow;
    }
  }

  // Mettre à jour le profil utilisateur
  Future<void> updateUserProfile(String uid, Map<String, dynamic> userData) async {
    try {
      await _users.doc(uid).update({
        ...userData,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Erreur lors de la mise à jour du profil: $e');
      rethrow;
    }
  }

  // Obtenir les données d'un utilisateur
  Future<DocumentSnapshot> getUserProfile(String uid) async {
    try {
      return await _users.doc(uid).get();
    } catch (e) {
      print('Erreur lors de la récupération du profil: $e');
      rethrow;
    }
  }

  // Obtenir tous les cours
  Stream<QuerySnapshot> getAllCourses() {
    try {
      return _courses.orderBy('createdAt', descending: true).snapshots();
    } catch (e) {
      print('Erreur lors de la récupération des cours: $e');
      rethrow;
    }
  }

  // Obtenir les cours d'un utilisateur
  Stream<QuerySnapshot> getUserCourses(String uid) {
    try {
      return _enrollments
          .where('userId', isEqualTo: uid)
          .orderBy('enrolledAt', descending: true)
          .snapshots();
    } catch (e) {
      print('Erreur lors de la récupération des cours de l\'utilisateur: $e');
      rethrow;
    }
  }

  // Inscrire un utilisateur à un cours
  Future<void> enrollInCourse(String courseId) async {
    try {
      final String uid = _auth.currentUser!.uid;
      await _enrollments.add({
        'userId': uid,
        'courseId': courseId,
        'enrolledAt': FieldValue.serverTimestamp(),
        'progress': 0,
        'status': 'active'
      });
    } catch (e) {
      print('Erreur lors de l\'inscription au cours: $e');
      rethrow;
    }
  }

  // Mettre à jour la progression d'un cours
  Future<void> updateCourseProgress(String enrollmentId, int progress) async {
    try {
      await _enrollments.doc(enrollmentId).update({
        'progress': progress,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Erreur lors de la mise à jour de la progression: $e');
      rethrow;
    }
  }

  // Ajouter un cours au panier
  Future<void> addToCart(String courseId) async {
    try {
      final String uid = _auth.currentUser!.uid;
      await _users.doc(uid).update({
        'cart': FieldValue.arrayUnion([courseId])
      });
    } catch (e) {
      print('Erreur lors de l\'ajout au panier: $e');
      rethrow;
    }
  }

  // Retirer un cours du panier
  Future<void> removeFromCart(String courseId) async {
    try {
      final String uid = _auth.currentUser!.uid;
      await _users.doc(uid).update({
        'cart': FieldValue.arrayRemove([courseId])
      });
    } catch (e) {
      print('Erreur lors du retrait du panier: $e');
      rethrow;
    }
  }

  // Obtenir le panier de l'utilisateur
  Stream<DocumentSnapshot> getCart() {
    try {
      final String uid = _auth.currentUser!.uid;
      return _users.doc(uid).snapshots();
    } catch (e) {
      print('Erreur lors de la récupération du panier: $e');
      rethrow;
    }
  }

  // Rechercher des cours
  Future<QuerySnapshot> searchCourses(String searchTerm) async {
    try {
      return await _courses
          .where('title', isGreaterThanOrEqualTo: searchTerm)
          .where('title', isLessThan: searchTerm + 'z')
          .get();
    } catch (e) {
      print('Erreur lors de la recherche: $e');
      rethrow;
    }
  }

  // Ajouter une note et un commentaire à un cours
  Future<void> rateCourse(String courseId, double rating, String comment) async {
    try {
      final String uid = _auth.currentUser!.uid;
      await _courses.doc(courseId).collection('ratings').doc(uid).set({
        'userId': uid,
        'rating': rating,
        'comment': comment,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Mettre à jour la note moyenne du cours
      final ratings = await _courses.doc(courseId).collection('ratings').get();
      double totalRating = 0;
      ratings.docs.forEach((doc) => totalRating += doc['rating']);
      double averageRating = totalRating / ratings.docs.length;

      await _courses.doc(courseId).update({
        'averageRating': averageRating,
        'totalRatings': ratings.docs.length,
      });
    } catch (e) {
      print('Erreur lors de l\'ajout de la note: $e');
      rethrow;
    }
  }
} 