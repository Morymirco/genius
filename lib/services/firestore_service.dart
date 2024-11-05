import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Référence aux collections
  CollectionReference get _users => _firestore.collection('users');
  CollectionReference get _courses => _firestore.collection('courses');

  // Obtenir le panier de l'utilisateur
  Future<List<String>> getUserCart() async {
    try {
      final String uid = _auth.currentUser!.uid;
      final doc = await _users.doc(uid).get();
      final data = doc.data() as Map<String, dynamic>?;
      return List<String>.from(data?['cart'] ?? []);
    } catch (e) {
      print('Erreur lors de la récupération du panier: $e');
      return [];
    }
  }

  // Obtenir les mises à jour du panier en temps réel
  Stream<DocumentSnapshot> getCartStream() {
    try {
      final String uid = _auth.currentUser!.uid;
      return _users.doc(uid).snapshots();
    } catch (e) {
      print('Erreur lors de la récupération du stream du panier: $e');
      rethrow;
    }
  }

  // Ajouter au panier
  Future<void> addToCart(String courseTitle) async {
    try {
      final String uid = _auth.currentUser!.uid;
      await _users.doc(uid).update({
        'cart': FieldValue.arrayUnion([courseTitle])
      });
      print('Cours ajouté au panier: $courseTitle');
    } catch (e) {
      print('Erreur lors de l\'ajout au panier: $e');
      rethrow;
    }
  }

  // Retirer du panier
  Future<void> removeFromCart(String courseTitle) async {
    try {
      final String uid = _auth.currentUser!.uid;
      await _users.doc(uid).update({
        'cart': FieldValue.arrayRemove([courseTitle])
      });
      print('Cours retiré du panier: $courseTitle');
    } catch (e) {
      print('Erreur lors du retrait du panier: $e');
      rethrow;
    }
  }

  // Obtenir les données d'un utilisateur
  Future<DocumentSnapshot> getUserProfile(String uid) async {
    try {
      print('Récupération du profil utilisateur: $uid');
      final doc = await _users.doc(uid).get();
      if (doc.exists) {
        print('Profil trouvé avec données: ${doc.data()}');
      } else {
        print('Profil non trouvé');
      }
      return doc;
    } catch (e) {
      print('Erreur lors de la récupération du profil: $e');
      rethrow;
    }
  }

  // Créer un profil utilisateur
  Future<void> createUserProfile(String uid, Map<String, dynamic> userData) async {
    try {
      print('Création du profil utilisateur avec données: $userData');
      await _users.doc(uid).set({
        ...userData,
        'cart': [],
        'favorites': [],
        'enrolledCourses': [],
        'completedCourses': [],
        'certificates': [],
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('Profil utilisateur créé avec succès');
    } catch (e) {
      print('Erreur lors de la création du profil: $e');
      rethrow;
    }
  }

  // Mettre à jour le profil utilisateur
  Future<void> updateUserProfile(String uid, Map<String, dynamic> userData) async {
    try {
      print('Mise à jour du profil utilisateur: $userData');
      await _users.doc(uid).set(
        userData,
        SetOptions(merge: true),
      );
      print('Profil utilisateur mis à jour avec succès');
    } catch (e) {
      print('Erreur lors de la mise à jour du profil: $e');
      rethrow;
    }
  }

  // Obtenir les cours par titre
  Future<List<Map<String, dynamic>>> getCoursesById(List<String> courseTitles) async {
    try {
      print('Recherche des cours avec les titres: $courseTitles');
      List<Map<String, dynamic>> courses = [];
      
      final querySnapshot = await _courses.get();
      print('Nombre total de cours trouvés: ${querySnapshot.docs.length}');
      
      for (String courseTitle in courseTitles) {
        try {
          final courseDoc = querySnapshot.docs.firstWhere(
            (doc) {
              final data = doc.data() as Map<String, dynamic>;
              print('Comparaison: ${data['title']} avec $courseTitle');
              return data['title'] == courseTitle;
            },
          );
          
          final data = courseDoc.data() as Map<String, dynamic>;
          data['id'] = courseDoc.id;
          courses.add(data);
          print('Cours ajouté: ${data['title']}');
        } catch (e) {
          print('Cours non trouvé: $courseTitle - Erreur: $e');
          continue;
        }
      }
      
      print('Nombre de cours récupérés: ${courses.length}');
      return courses;
    } catch (e) {
      print('Erreur lors de la récupération des cours: $e');
      return [];
    }
  }

  // Rechercher des cours
  Future<List<Map<String, dynamic>>> searchCourses(String searchTerm) async {
    try {
      print('Recherche de cours avec le terme: $searchTerm');
      final coursesRef = _firestore.collection('courses');
      final querySnapshot = await coursesRef.get();

      final results = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((course) {
            final title = (course['title'] as String?)?.toLowerCase() ?? '';
            final description = (course['courseDescription'] as String?)?.toLowerCase() ?? '';
            final teacher = (course['teacherName'] as String?)?.toLowerCase() ?? '';
            
            return title.contains(searchTerm) ||
                   description.contains(searchTerm) ||
                   teacher.contains(searchTerm);
          })
          .toList();

      print('Nombre de résultats trouvés: ${results.length}');
      return results;
    } catch (e) {
      print('Erreur lors de la recherche: $e');
      return [];
    }
  }
} 