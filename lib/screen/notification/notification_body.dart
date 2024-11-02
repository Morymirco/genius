import 'package:flutter/material.dart';

import 'package:coursenligne/util/util.dart';
import 'widgets/notification_tile.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(10),
      ),
      physics: const BouncingScrollPhysics(),
      children: [
        NotificationTile(
          title: "Nouveau cours disponible",
          message: "Le cours 'Flutter Avancé' est maintenant disponible",
          time: "Il y a 2h",
          isRead: false,
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        NotificationTile(
          title: "Rappel",
          message: "N'oubliez pas de terminer votre cours 'Bases de Flutter'",
          time: "Il y a 1j",
          isRead: true,
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
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