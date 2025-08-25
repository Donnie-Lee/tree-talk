import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // 消息列表数据
  final List<Map<String, dynamic>> _messages = [
    {
      'type': 'system',
      'content': '你好，我是你的AI心理助手，今天有什么想和我聊的吗？'
    },
    {
      'type': 'user',
      'content': '最近工作压力很大，感觉很焦虑'
    },
    {
      'type': 'system',
      'content': '我理解你的感受。工作压力确实会带来焦虑感。能具体说说是什么让你感到压力吗？也许我们可以一起找到一些缓解方法。'
    },
    {
      'type': 'user',
      'content': '项目deadline很紧，感觉时间不够用'
    },
    {
      'type': 'system',
      'content': '面对紧张的截止日期确实很有挑战性。我建议你可以尝试这些方法：\n\n1. 列一个任务清单，按优先级排序\n2. 把大任务分解成小步骤，一步步完成\n3. 适当休息，保持专注力\n4. 必要时与团队沟通，寻求支持\n\n记住，照顾好自己的心理健康也很重要。每天给自己5-10分钟的冥想时间，可以帮助减轻焦虑。'
    },
  ];

  // 文本编辑控制器
  final TextEditingController _textController = TextEditingController();

  // 滚动控制器，用于自动滚动到底部
  final ScrollController _scrollController = ScrollController();

  // 发送消息
  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'type': 'user',
        'content': _textController.text.trim(),
      });
      _textController.clear();
    });

    // 模拟AI回复
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'type': 'system',
          'content': '感谢你的分享。我会认真倾听并尽力帮助你。'
        });
      });
      _scrollToBottom();
    });

    _scrollToBottom();
  }

  // 滚动到底部
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: _messages.map((message) {
                    if (message['type'] == 'system') {
                      return _buildSystemMessage(message['content']);
                    } else {
                      return _buildUserMessage(message['content']);
                    }
                  }).toList(),
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
            width: 40, height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.neonOrange, AppColors.accent],
              ),
            ),
            child: const Center(
              child: Icon(Icons.psychology, color: Colors.white, size: 24),
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
              child: Text(message, style: TextStyle(color: AppColors.textPrimary)),
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
              child: Text(message, style: TextStyle(color: AppColors.textPrimary)),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              border: Border.all(color: AppColors.accent, width: 2),
            ),
            child: const Center(
              child: Icon(Icons.person, color: Colors.white, size: 24),
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
                controller: _textController,
                decoration: InputDecoration(
                  hintText: '输入消息...',
                  hintStyle: TextStyle(color: AppColors.textTertiary),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: AppColors.textPrimary),
                onSubmitted: (value) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.neonOrange, AppColors.accent],
                ),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}