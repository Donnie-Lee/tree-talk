import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'tree_hole_screen.dart';
import 'chat_screen.dart';
import 'meditation_screen.dart';
import 'profile_screen.dart';
import '../widgets/grid_painter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  // 页面列表
  final List<Widget> _pages = [
    const HomeScreen(),
    const ChatScreen(),
    const MeditationScreen(),
    const TreeHoleScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 网格背景
          CustomPaint(
            painter: GridPainter(),
            size: MediaQuery.of(context).size,
          ),

          Column(children: [
            // 当前页面
            Expanded(child:  _pages[_currentIndex]),

            // 顶部状态栏
            // const Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: StatusBar(),
            // ),
            BottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ],)

          // // 底部导航栏
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child:
          // ),
        ],
      ),
    );
  }
}