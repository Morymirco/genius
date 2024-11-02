import 'package:flutter/material.dart';
import 'package:coursenligne/config/theme/theme.dart';
import 'widgets/notification_tile.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        NotificationTile(
          title: "Nouveau cours disponible",
          message: "Le cours 'Flutter Avancé' est maintenant disponible",
          time: "Il y a 2h",
          isRead: false,
        ),
        NotificationTile(
          title: "Rappel",
          message: "N'oubliez pas de terminer votre cours 'Bases de Flutter'",
          time: "Il y a 1j",
          isRead: true,
        ),
        NotificationTile(
          title: "Promotion",
          message: "50% de réduction sur tous les cours cette semaine!",
          time: "Il y a 2j",
          isRead: true,
        ),
      ],
    );
  }
} 