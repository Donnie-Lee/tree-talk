import 'package:flutter/material.dart';
import 'package:tree_talk/services/api_service.dart';
import '../models/user_profile.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var apiService = ApiService();
  UserProfile? userProfile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserInfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadUserInfo() {
    apiService.profile().then((response) {
      if (response.data != null) {
        setState(() {
          userProfile = response.data;
        });
      }
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryDark,
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
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 取消关闭弹窗
              },
              child: Text(
                '取消',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                apiService.removeToken();
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 用户头像和基本信息
              _buildUserHeader(),
              const SizedBox(height: 24),

              // 情绪统计卡片
              _buildStatsCard(),
              const SizedBox(height: 16),

              // 设置列表
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.glassBg.withValues(alpha: 0.4),
                      AppColors.glassBg.withValues(alpha: 0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Column(
                  children: [
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
                      icon: Icons.palette_outlined,
                      title: '主题设置',
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: Icons.help_outline,
                      title: '帮助与反馈',
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: Icons.logout,
                      title: '退出登录',
                      onTap: () => _showLogoutDialog(context),
                      isDestructive: true,
                    ),
                  ],
                ),
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
              color: AppColors.glassBg,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: userProfile?.avatar != null
                  ? Image.network(
                      userProfile!.avatar!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.accent, AppColors.neonOrange],
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.person, color: Colors.white, size: 40),
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.accent, AppColors.neonOrange],
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.person, color: Colors.white, size: 40),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 40),
          // 右侧用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProfile?.nickname ?? '用户名',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userProfile?.username ?? 'user@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                // 统计信息
                Row(
                  children: [
                    _buildUserStat(
                      '已记录',
                      "${userProfile?.totalCheckInDays ?? 0}",
                    ),
                    Container(
                      height: 24,
                      width: 1,
                      color: AppColors.glassBorder,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    _buildUserStat(
                      '连续打卡',
                      '${userProfile?.continuousCheckInDays ?? 0}天',
                    ),
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
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : AppColors.textPrimary,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isDestructive ? Colors.red : AppColors.textPrimary,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
