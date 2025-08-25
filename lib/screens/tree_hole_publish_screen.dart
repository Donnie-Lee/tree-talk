import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TreeHolePublishScreen extends StatefulWidget {
  const TreeHolePublishScreen({super.key});

  @override
  State<TreeHolePublishScreen> createState() => _TreeHolePublishScreenState();
}

class _TreeHolePublishScreenState extends State<TreeHolePublishScreen> {
  final TextEditingController _textController = TextEditingController();
  final int _maxLength = 500;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handlePublish() {
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('请输入内容后再发布'),
          backgroundColor: AppColors.accent,
        ),
      );
      return;
    }

    // 返回上一页并传递发布的内容
    Navigator.pop(context, {
      'content': _textController.text.trim(),
      'time': '刚刚',
      'likes': 0,
      'comments': 0,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '发布树洞',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: _handlePublish,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              child: Text(
                '发布',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.glassBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: 8,
                  maxLength: _maxLength,
                  decoration: InputDecoration(
                    hintText: '分享你的心事...\n在这里你可以匿名分享你的故事、烦恼或快乐',
                    hintStyle: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${_textController.text.length}/$_maxLength',
                  style: TextStyle(
                    color: _textController.text.length > _maxLength * 0.9
                        ? AppColors.accent
                        : AppColors.textTertiary,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.glassBg.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '树洞是匿名分享的，请文明发言，尊重他人',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
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
}