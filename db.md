# Schéma de données Firebase pour l'application de cours en ligne

Ce document décrit la structure de la base de données Firebase pour notre application de cours en ligne.

## Collections

### Utilisateurs

Collection : `users`

Champs :
- `id` : String (généré automatiquement par Firebase)
- `email` : String
- `nom` : String
- `prenom` : String
- `dateInscription` : Timestamp
- `dernièreConnexion` : Timestamp
- `coursInscrits` : Array<String> (références aux ID des cours)

### Catégories

Collection : `categories`

Champs :
- `id` : String (généré automatiquement par Firebase)
- `title` : String
- `isSelected` : Boolean

### Cours

Collection : `courses`

Champs :
- `id` : String (généré automatiquement par Firebase)
- `title` : String
- `teacherName` : String
- `teacherImage` : String (URL de l'image)
- `courseImage` : String (URL de l'image)
- `coursePrice` : String
- `numberOfLessons` : String
- `courseDuration` : String
- `courseDescription` : String
- `courseProgressValue` : String
- `sliderImages` : Array<String> (URLs des images)
- `categoryId` : String (référence à l'ID de la catégorie)

### Leçons

Collection : `lessons`

Champs :
- `id` : String (généré automatiquement par Firebase)
- `lessonName` : String
- `lessonDuration` : String
- `courseId` : String (référence à l'ID du cours parent)

## Relations

- Chaque `course` est associé à une `category` via le champ `categoryId`.
- Chaque `lesson` est associée à un `course` via le champ `courseId`.
- Les `users` sont liés aux `courses` via le champ `coursInscrits`.

## Règles de sécurité

- Les utilisateurs authentifiés peuvent lire les données des cours et des catégories.
- Seuls les administrateurs peuvent créer, modifier ou supprimer des cours et des catégories.
- Les utilisateurs peuvent mettre à jour leur propre profil et leur progression dans les cours.

## Indexation

Pour optimiser les requêtes fréquentes, nous recommandons d'indexer les champs suivants :

- `courses`: `categoryId`, `teacherName`
- `lessons`: `courseId`
- `users`: `coursInscrits`

## Remarques

- Utilisez Firebase Storage pour stocker les images des enseignants, des cours et les images du slider.
- Implémentez des Cloud Functions pour gérer la logique métier complexe, comme la mise à jour de la progression des cours.
- Considérez l'utilisation de Firebase Authentication pour gérer l'authentification des utilisateurs.
- Pour les données sensibles comme les prix des cours, assurez-vous d'implémenter des règles de sécurité appropriées.