import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/screen/notification/notification_screen.dart';
import 'package:coursenligne/screen/profile/profile_screen.dart';
import 'package:coursenligne/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(15),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _userName(),
              Row(
                children: [
                  _notification(context),
                  SizedBox(width: getProportionateScreenWidth(12)),
                  _avatar(context)
                ],
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            children: [
              Expanded(child: _searchField()),
              SizedBox(width: getProportionateScreenWidth(12)),
              _setting(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _userName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bienvenue',
          style: TextStyle(
            color: AppColors.colorTint500,
            fontSize: getProportionateScreenWidth(14),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(4)),
        Text(
          'MircoLgv',
          style: TextStyle(
            color: AppColors.colorTint700,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        )
      ],
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

  Widget _avatar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MonProfil()),
        );
      },
      child: Container(
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/images/profile-image.jpg'),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }

  Widget _searchField() {
    return Container(
      height: getProportionateScreenHeight(45),
      decoration: BoxDecoration(
        color: AppColors.colorTint200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        autofocus: false,
        style: TextStyle(
          fontSize: getProportionateScreenWidth(14),
          color: AppColors.colorTint700
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          hintText: 'Rechercher un cours',
          hintStyle: TextStyle(
            color: AppColors.colorTint500,
            fontSize: getProportionateScreenWidth(14),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              color: AppColors.colorTint500,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _setting() {
    return Container(
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
        onPressed: () {},
      ),
    );
  }
}