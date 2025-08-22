import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.glassBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.glassBorder),
          ),
          title: Text(
            '确认退出',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '确定要退出登录吗？退出后需要重新登录才能使用应用。',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 取消关闭弹窗
              },
              child: Text(
                '取消',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 关闭确认弹窗
                // 跳转到登录页
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: Text(
                '确定',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        // padding: const EdgeInsets.only(top: 44, bottom: 84),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 用户头像和基本信息
              _buildUserHeader(),
              const SizedBox(height: 24),

              // 情绪统计卡片
              _buildStatsCard(),
              const SizedBox(height: 16),

              // 设置选项
              _buildSettingItem(
                icon: Icons.notifications_outlined,
                title: '通知设置',
                onTap: () {},
              ),
              _buildSettingItem(
                icon: Icons.lock_outline,
                title: '隐私设置',
                onTap: () {},
              ),
              _buildSettingItem(
                icon: Icons.help_outline,
                title: '帮助中心',
                onTap: () {},
              ),
              _buildSettingItem(
                icon: Icons.info_outline,
                title: '关于我们',
                onTap: () {},
              ),
              _buildSettingItem(
                icon: Icons.logout,
                title: '退出登录',
                onTap: () => _showLogoutDialog(context),
                showDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 左侧头像
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.accent, AppColors.neonOrange],
              ),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Icon(Icons.person, color: Colors.white, size: 40),
            ),
          ),
          const SizedBox(width: 40),
          // 右侧用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '用户名',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                // 统计信息
                Row(
                  children: [
                    _buildUserStat('已记录', '32'),
                    Container(
                      height: 24,
                      width: 1,
                      color: AppColors.glassBorder,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    _buildUserStat('连续打卡', '7天'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '本月情绪统计',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildEmotionStat('开心', 40, AppColors.emotionHappy),
              _buildEmotionStat('平静', 25, AppColors.emotionCalm),
              _buildEmotionStat('焦虑', 15, AppColors.emotionAnxious),
              _buildEmotionStat('其他', 20, AppColors.emotionSad),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionStat(String label, int percentage, Color color) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    value: percentage / 100,
                    strokeWidth: 8,
                    backgroundColor: Colors.black12,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Icon(icon, color: AppColors.textSecondary, size: 24),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.textTertiary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(color: AppColors.glassBorder, height: 1),
      ],
    );
  }
}
