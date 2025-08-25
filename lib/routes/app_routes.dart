import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';
import '../screens/home_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/meditation_screen.dart';
import '../screens/tree_hole_screen.dart';
import '../screens/profile_screen.dart';
import '../utils/page_transitions.dart';

class AppRoutes {
  // 路由名称常量
  static const String splash = '/';
  static const String login = '/login';
  static const String main = '/main';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String meditation = '/meditation';
  static const String treeHole = '/tree_hole';
  static const String profile = '/profile';

  // 路由表
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    main: (context) => const MainScreen(),
    home: (context) => const HomeScreen(),
    chat: (context) => const ChatScreen(),
    meditation: (context) => const MeditationScreen(),
    treeHole: (context) => const TreeHoleScreen(),
    profile: (context) => const ProfileScreen(),
  };

  // 生成带过渡动画的路由
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return PageTransitions.fade(const SplashScreen());
      case login:
        return PageTransitions.fade(const LoginScreen());
      case main:
        return PageTransitions.slideRight(const MainScreen());
      case home:
        return PageTransitions.slideRight(const HomeScreen());
      case chat:
        return PageTransitions.slideRight(const ChatScreen());
      case meditation:
        return PageTransitions.slideRight(const MeditationScreen());
      case treeHole:
        return PageTransitions.slideRight(const TreeHoleScreen());
      case profile:
        return PageTransitions.slideRight(const ProfileScreen());
      default:
        return PageTransitions.fade(const SplashScreen());
    }
  }

  // 导航到指定页面的方法
  static void navigateTo(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // 导航到指定页面并替换当前页面的方法
  static void navigateToReplace(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  // 导航到指定页面并清除之前的所有页面
  static void navigateToAndRemoveUntil(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      context, 
      routeName, 
      (route) => false,
      arguments: arguments
    );
  }

  // 返回上一页
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}