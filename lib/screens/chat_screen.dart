import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.only(top: 44, bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildSystemMessage('你好，我是你的AI心理助手，今天有什么想和我聊的吗？'),
                    _buildUserMessage('最近工作压力很大，感觉很焦虑'),
                    _buildSystemMessage('我理解你的感受。工作压力确实会带来焦虑感。能具体说说是什么让你感到压力吗？也许我们可以一起找到一些缓解方法。'),
                    _buildUserMessage('项目deadline很紧，感觉时间不够用'),
                    _buildSystemMessage('面对紧张的截止日期确实很有挑战性。我建议你可以尝试这些方法：\n\n1. 列一个任务清单，按优先级排序\n2. 把大任务分解成小步骤，一步步完成\n3. 适当休息，保持专注力\n4. 必要时与团队沟通，寻求支持\n\n记住，照顾好自己的心理健康也很重要。每天给自己5-10分钟的冥想时间，可以帮助减轻焦虑。'),
                  ],
                ),
              ),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildSystemMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.neonOrange, AppColors.accent],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.psychology,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.glassBg,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: Text(
                message,
                style: TextStyle(color: AppColors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
              ),
              child: Text(
                message,
                style: TextStyle(color: AppColors.textPrimary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              border: Border.all(color: AppColors.accent, width: 2),
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        border: Border(
          top: BorderSide(color: AppColors.glassBorder),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.glassBg,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '输入消息...',
                  hintStyle: TextStyle(color: AppColors.textTertiary),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: AppColors.textPrimary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.neonOrange, AppColors.accent],
              ),
            ),
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}