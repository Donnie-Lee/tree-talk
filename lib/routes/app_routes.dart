import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/main_screen.dart';
import '../screens/home_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/meditation_screen.dart';
import '../screens/tree_hole_screen.dart';
import '../screens/profile_screen.dart';

class AppRoutes {
  // 路由名称常量
  static const String splash = '/';
  static const String main = '/main';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String meditation = '/meditation';
  static const String treeHole = '/tree_hole';
  static const String profile = '/profile';

  // 路由表
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    main: (context) => const MainScreen(),
    home: (context) => const HomeScreen(),
    chat: (context) => const ChatScreen(),
    meditation: (context) => const MeditationScreen(),
    treeHole: (context) => const TreeHoleScreen(),
    profile: (context) => const ProfileScreen(),
  };

  // 路由生成器，用于处理未定义的路由或需要传递参数的路由
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // 可以在这里添加需要传递参数的路由处理
      default:
        return null;
    }
  }

  // 页面切换动画
  static PageRouteBuilder buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
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