import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/screen/home/home-body.dart';
import 'package:coursenligne/screen/screen.dart';
import 'package:coursenligne/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coursenligne/screen/profile/profile_screen.dart';
import 'package:coursenligne/screen/cart/cart_screen.dart';

class Nav extends StatefulWidget {
  static String routeName = '/nav';
  const Nav({Key? key}): super(key: key);
  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int currentIndex = 0;
  
  final List<Widget> screens = const [
    HomeScreenBody(),
    MyCoursesScreen(),
    CartScreen(),
    MonProfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.colorPrimary,
            unselectedItemColor: AppColors.colorTint400,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  colorFilter: ColorFilter.mode(
                    currentIndex == 0 ? AppColors.colorPrimary : AppColors.colorTint400,
                    BlendMode.srcIn,
                  ),
                  width: getProportionateScreenWidth(19),
                  height: getProportionateScreenWidth(19),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/document.svg',
                  colorFilter: ColorFilter.mode(
                    currentIndex == 1 ? AppColors.colorPrimary : AppColors.colorTint400,
                    BlendMode.srcIn,
                  ),
                  width: getProportionateScreenWidth(19),
                  height: getProportionateScreenWidth(19),
                ),
                label: 'Courses',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/shopping-cart.svg',
                  colorFilter: ColorFilter.mode(
                    currentIndex == 2 ? AppColors.colorPrimary : AppColors.colorTint400,
                    BlendMode.srcIn,
                  ),
                  width: getProportionateScreenWidth(19),
                  height: getProportionateScreenWidth(19),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/User.svg',
                  colorFilter: ColorFilter.mode(
                    currentIndex == 3 ? AppColors.colorPrimary : AppColors.colorTint400,
                    BlendMode.srcIn,
                  ),
                  width: getProportionateScreenWidth(19),
                  height: getProportionateScreenWidth(19),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (currentIndex == 0) {
      return Future.value(true);
    } else {
      setState(() {
        currentIndex = 0;
      });
      return Future.value(false);
    }
  }
}
