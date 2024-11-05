import 'dart:math';

import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/screen/notification/notification_screen.dart';
import 'package:coursenligne/screen/profile/profile_screen.dart';
import 'package:coursenligne/services/auth_service.dart';
import 'package:coursenligne/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreenAppBar extends StatefulWidget {
  const HomeScreenAppBar({Key? key}) : super(key: key);

  @override
  State<HomeScreenAppBar> createState() => _HomeScreenAppBarState();
}

class _HomeScreenAppBarState extends State<HomeScreenAppBar> {
  final _authService = AuthService();

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '';
    final names = name.trim().split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return name.substring(0, min(2, name.length)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    final initials = _getInitials(user?.displayName);

    return Container(
      height: getProportionateScreenHeight(140),
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: getProportionateScreenHeight(10),
        bottom: getProportionateScreenHeight(10),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bonjour,',
                    style: TextStyle(
                      color: AppColors.colorTint500,
                      fontSize: getProportionateScreenWidth(14),
                    ),
                  ),
                  Text(
                    user?.displayName ?? 'Utilisateur',
                    style: TextStyle(
                      color: AppColors.colorTint700,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _notification(context),
                  SizedBox(width: getProportionateScreenWidth(12)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MonProfil()),
                      );
                    },
                    child: user?.photoURL != null && user!.photoURL!.isNotEmpty
                        ? CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.colorTint200,
                            backgroundImage: NetworkImage(user.photoURL!),
                          )
                        : CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xFF43BCCD),
                            child: Text(
                              initials,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    child: Container(
                      height: getProportionateScreenHeight(45),
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(12),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.colorTint200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              'assets/icons/search.svg',
                              color: AppColors.colorTint500,
                              width: getProportionateScreenWidth(18),
                              height: getProportionateScreenWidth(18),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Rechercher un cours',
                              style: TextStyle(
                                color: AppColors.colorTint500,
                                fontSize: getProportionateScreenWidth(14),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(12)),
                _setting(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _notification(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.colorTint400)
      ),
      child: IconButton(
        icon: Stack(
          children: [
            SvgPicture.asset(
              'assets/icons/notification.svg',
              color: AppColors.colorTint600,
              width: getProportionateScreenWidth(20),
              height: getProportionateScreenWidth(20),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: getProportionateScreenWidth(8),
                height: getProportionateScreenWidth(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorAccent,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            )
          ],
        ),
        onPressed: () {
          Navigator.pushNamed(context, NotificationScreen.routeName);
        }
      ),
    );
  }

  Widget _setting() {
    return Builder(
      builder: (context) => Container(
        height: getProportionateScreenWidth(45),
        width: getProportionateScreenWidth(45),
        decoration: BoxDecoration(
          color: AppColors.colorTint200,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/setting.svg',
            color: AppColors.colorPrimary,
            width: getProportionateScreenWidth(20),
            height: getProportionateScreenWidth(20),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Paramètres non disponibles'),
                backgroundColor: Color(0xFF43bccd),
              ),
            );
          },
        ),
      ),
    );
  }
}