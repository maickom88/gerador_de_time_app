import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/helpers/keyboard_manenger.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../controllers/home_controller.dart';
import '../controllers/logout_controller.dart';
import '../controllers/team_controller.dart';
import 'nav_controller.dart';
import 'nav_history.dart';
import 'nav_home.dart';
import 'nav_notification.dart';
import 'nav_settings.dart';
import 'nav_team.dart';

class NavPage extends StatefulWidget {
  final NavController controller;
  final LogoutController logoutController;
  final HomeController homeController;
  final TeamController teamController;
  const NavPage({
    Key? key,
    required this.controller,
    required this.teamController,
    required this.logoutController,
    required this.homeController,
  }) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> with KeyboardManager {
  late int currentIndex;
  late List<Widget> pages;
  @override
  void initState() {
    pages = [
      FadeAnimation(
        delay: 0.1,
        child: NavHome(homeController: widget.homeController),
      ),
      NavTeam(teamController: widget.teamController),
      const NavHistoric(),
      const NavNotification(),
      NavSettings(widget.logoutController),
    ];
    currentIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: CupertinoPageScaffold(
          backgroundColor: Colors.white,
          child: pages[currentIndex],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(color: AppColor.lightColor, width: 1),
          )),
          child: BottomNavigationBar(
            elevation: 1,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (current) {
              HapticFeedback.lightImpact();
              SystemSound.play(SystemSoundType.click);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              setState(() {
                currentIndex = current;
              });
            },
            selectedLabelStyle:
                AppTypography.t14().copyWith(fontWeight: FontWeight.w500),
            unselectedItemColor: AppColor.textLight,
            fixedColor: AppColor.primaryColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                  activeIcon: Icon(Iconsax.home_15),
                  icon: Icon(Iconsax.home),
                  label: 'Home'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Iconsax.note_favorite5),
                  icon: Icon(Iconsax.note_favorite),
                  label: 'Equipe'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Iconsax.clock5),
                  icon: Icon(Iconsax.clock),
                  label: 'Historico'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Iconsax.notification5),
                  icon: Icon(Iconsax.notification),
                  label: 'Notificações'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Iconsax.setting_45),
                  icon: Icon(Iconsax.setting_4),
                  label: 'Ajustes'),
            ],
          ),
        ),
      ),
    );
  }
}
