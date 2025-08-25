import 'package:flutter/material.dart';
import '../services/mood_service.dart';
import '../widgets/mood_calendar.dart';
import '../widgets/mood_chart.dart';
import '../theme/app_colors.dart';
import '../utils/page_transitions.dart';
import 'mood_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MoodService _moodService = MoodService();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  void _navigateToMoodEdit(DateTime date) async {
    final result = await Navigator.push(
      context,
      PageTransitions.slideUp(
        MoodEditScreen(
          date: date,
          moodService: _moodService,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    _navigateToMoodEdit(date);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final hasTodayRecord = _moodService.hasRecordForDate(today);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // 日历组件
              MoodCalendar(
                moodService: _moodService,
                onDateSelected: _onDateSelected,
              ),
              
              const SizedBox(height: 24),
              
              // 情绪图表
              Text(
                '${today.month}月心情走势',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              
              MoodChart(
                moodService: _moodService,
                selectedDate: _selectedDate,
              ),
              
              const SizedBox(height: 24),
              
              // 快速记录按钮 - 仅在今日未记录时显示
              if (!hasTodayRecord)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => _navigateToMoodEdit(today),
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('记录今日心情'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}