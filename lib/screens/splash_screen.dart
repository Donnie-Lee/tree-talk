import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/grid_painter.dart';
import '../routes/app_routes.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3秒后自动跳转到主页
    Future.delayed(const Duration(seconds: 3), () {
      AppRoutes.navigateToReplace(context, AppRoutes.main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryDark, AppColors.primary],
          ),
        ),
        child: Stack(
          children: [
            // 网格背景
            Positioned.fill(
              child: CustomPaint(
                painter: GridPainter(),
              ),
            ),
            // 中心光晕
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [AppColors.accentGlow, Colors.transparent],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),
            // 应用信息
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGlow,
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                      ],
                      border: Border.all(
                        color: AppColors.accent,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.spa_outlined,
                        size: 60,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 应用名称
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [AppColors.neonOrange, AppColors.accent],
                    ).createShader(bounds),
                    child: const Text(
                      '心语 TreeTalk',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 应用标语
                  Text(
                    '倾听内心，疗愈心灵',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}