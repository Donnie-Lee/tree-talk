import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryDark.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(0, Icons.home_outlined, '首页'),
          _buildTabItem(1, Icons.chat_bubble_outline, '聊天'),
          _buildTabItem(2, Icons.self_improvement_outlined, '冥想'),
          _buildTabItem(3, Icons.shield_outlined, '树洞'),
          _buildTabItem(4, Icons.person_outline, '我的'),
        ],
      ),
    );
  }
  
  Widget _buildTabItem(int index, IconData icon, String label) {
    final isActive = currentIndex == index;
    
    // 增大触摸目标尺寸到48x48像素
    return InkWell(
      onTap: () => onTap(index),
      // 提供水波纹触摸反馈
      splashColor: AppColors.accent.withValues(alpha: 0.3),
      highlightColor: AppColors.accent.withValues(alpha: 0.1),
      // 设置足够大的点击区域
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 60,
        height: 60,
        // padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.accent : AppColors.textSecondary,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.accent : AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}