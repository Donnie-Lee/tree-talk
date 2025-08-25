import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/page_transitions.dart';
import 'tree_hole_publish_screen.dart';

class TreeHoleScreen extends StatefulWidget {
  const TreeHoleScreen({super.key});

  @override
  State<TreeHoleScreen> createState() => _TreeHoleScreenState();
}

class _TreeHoleScreenState extends State<TreeHoleScreen> {
  void _navigateToPublish() async {
    final result = await Navigator.push(
      context,
      PageTransitions.slideUp(
        const TreeHolePublishScreen(),
      ),
    );

    if (result != null && mounted) {
      // 可以在这里处理发布后的回调
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('发布成功！')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 标题栏
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '树洞',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.add_circle_outline),
                  //   color: AppColors.accent,
                  //   iconSize: 28,
                  //   onPressed: _navigateToPublish,
                  // ),
                ],
              ),
              const SizedBox(height: 16),
              
              // 树洞内容区域
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.forest,
                        size: 80,
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '这里还没有内容',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '点击右上角按钮发布你的第一条树洞',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToPublish,
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.add),
      ),
    );
  }
}