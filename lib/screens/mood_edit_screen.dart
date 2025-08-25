import 'package:flutter/material.dart';
import '../models/mood_record.dart';
import '../services/mood_service.dart';
import '../theme/app_colors.dart';

class MoodEditScreen extends StatefulWidget {
  final DateTime date;
  final MoodService moodService;

  const MoodEditScreen({
    super.key,
    required this.date,
    required this.moodService,
  });

  @override
  State<MoodEditScreen> createState() => _MoodEditScreenState();
}

class _MoodEditScreenState extends State<MoodEditScreen> {
  late TextEditingController _textController;
  String? _selectedMood;
  Color? _selectedColor;
  IconData? _selectedIcon;

  final Map<String, Map<String, dynamic>> _moodOptions = {
    '开心': {'color': AppColors.emotionHappy, 'icon': Icons.sentiment_very_satisfied},
    '平静': {'color': AppColors.emotionCalm, 'icon': Icons.sentiment_satisfied},
    '焦虑': {'color': AppColors.emotionAnxious, 'icon': Icons.sentiment_neutral},
    '悲伤': {'color': AppColors.emotionSad, 'icon': Icons.sentiment_dissatisfied},
    '愤怒': {'color': AppColors.emotionAngry, 'icon': Icons.sentiment_very_dissatisfied},
    '疲惫': {'color': AppColors.emotionTired, 'icon': Icons.bedtime},
  };

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _loadExistingRecord();
  }

  void _loadExistingRecord() {
    final existingRecord = widget.moodService.getRecordForDate(widget.date);
    if (existingRecord != null) {
      _textController.text = existingRecord.content ?? '';
      _selectedMood = existingRecord.mood;
      _selectedColor = existingRecord.color;
      _selectedIcon = existingRecord.icon;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _saveRecord() {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('请选择一种心情'),
          backgroundColor: AppColors.accent,
        ),
      );
      return;
    }

    final record = MoodRecord(
      date: widget.date,
      mood: _selectedMood!,
      content: _textController.text.trim(),
      color: _selectedColor!,
      icon: _selectedIcon!,
    );

    widget.moodService.addRecord(record);
    Navigator.pop(context, record);
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
          '${widget.date.month}月${widget.date.day}日心情',
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
              onPressed: _saveRecord,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              child: Text(
                '保存',
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
              Text(
                '今天的心情如何？',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // 心情选择
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: _moodOptions.entries.map((entry) {
                  final isSelected = _selectedMood == entry.key;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMood = entry.key;
                        _selectedColor = entry.value['color'];
                        _selectedIcon = entry.value['icon'];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected 
                            // 修复第161行的withOpacity
                            ? entry.value['color'].withValues(alpha: 0.3)
                            : AppColors.glassBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected 
                              ? entry.value['color']
                              : AppColors.glassBorder,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            entry.value['icon'],
                            color: entry.value['color'],
                            size: 30,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            entry.key,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 24),
              
              // 心情记录输入
              Container(
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
                      '记录今天的心情',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _textController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: '写下你的感受...',
                        hintStyle: TextStyle(color: AppColors.textTertiary),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: AppColors.textPrimary),
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