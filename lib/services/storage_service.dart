import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Télécharger une image de profil
  Future<String> uploadProfileImage(String userId, File imageFile) async {
    try {
      String fileName = 'profile_$userId${path.extension(imageFile.path)}';
      Reference ref = _storage.ref().child('profile_images/$fileName');
      
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Erreur lors du téléchargement de l\'image de profil: $e');
      rethrow;
    }
  }

  // Télécharger une image de cours
  Future<String> uploadCourseImage(String courseId, File imageFile) async {
    try {
      String fileName = 'course_$courseId${path.extension(imageFile.path)}';
      Reference ref = _storage.ref().child('course_images/$fileName');
      
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Erreur lors du téléchargement de l\'image du cours: $e');
      rethrow;
    }
  }

  // Télécharger un fichier de leçon
  Future<String> uploadLessonFile(String courseId, String lessonId, File file) async {
    try {
      String fileName = 'lesson_${lessonId}_${path.basename(file.path)}';
      Reference ref = _storage.ref().child('courses/$courseId/lessons/$fileName');
      
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Erreur lors du téléchargement du fichier de leçon: $e');
      rethrow;
    }
  }

  // Supprimer une image de profil
  Future<void> deleteProfileImage(String userId) async {
    try {
      Reference ref = _storage.ref().child('profile_images/profile_$userId');
      await ref.delete();
    } catch (e) {
      print('Erreur lors de la suppression de l\'image de profil: $e');
      rethrow;
    }
  }

  // Supprimer une image de cours
  Future<void> deleteCourseImage(String courseId) async {
    try {
      Reference ref = _storage.ref().child('course_images/course_$courseId');
      await ref.delete();
    } catch (e) {
      print('Erreur lors de la suppression de l\'image du cours: $e');
      rethrow;
    }
  }

  // Supprimer un fichier de leçon
  Future<void> deleteLessonFile(String courseId, String lessonId, String fileName) async {
    try {
      Reference ref = _storage.ref().child('courses/$courseId/lessons/$fileName');
      await ref.delete();
    } catch (e) {
      print('Erreur lors de la suppression du fichier de leçon: $e');
      rethrow;
    }
  }

  // Obtenir l'URL de téléchargement d'un fichier
  Future<String> getDownloadUrl(String path) async {
    try {
      Reference ref = _storage.ref().child(path);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Erreur lors de la récupération de l\'URL: $e');
      rethrow;
    }
  }

  // Télécharger plusieurs fichiers
  Future<List<String>> uploadMultipleFiles(String courseId, List<File> files) async {
    try {
      List<String> downloadUrls = [];
      
      for (File file in files) {
        String fileName = path.basename(file.path);
        Reference ref = _storage.ref().child('courses/$courseId/files/$fileName');
        
        UploadTask uploadTask = ref.putFile(file);
        TaskSnapshot snapshot = await uploadTask;
        
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
      
      return downloadUrls;
    } catch (e) {
      print('Erreur lors du téléchargement multiple: $e');
      rethrow;
    }
  }

  // Obtenir la taille d'un fichier
  Future<int> getFileSize(String path) async {
    try {
      Reference ref = _storage.ref().child(path);
      FullMetadata metadata = await ref.getMetadata();
      return metadata.size ?? 0;
    } catch (e) {
      print('Erreur lors de la récupération de la taille du fichier: $e');
      rethrow;
    }
  }

  // Vérifier si un fichier existe
  Future<bool> fileExists(String path) async {
    try {
      Reference ref = _storage.ref().child(path);
      await ref.getMetadata();
      return true;
    } catch (e) {
      return false;
    }
  }
} 