import 'package:flutter/material.dart';
import '../services/mood_service.dart';
import '../theme/app_colors.dart';

class MoodCalendar extends StatefulWidget {
  final MoodService moodService;
  final Function(DateTime) onDateSelected;

  const MoodCalendar({
    super.key,
    required this.moodService,
    required this.onDateSelected,
  });

  @override
  State<MoodCalendar> createState() => _MoodCalendarState();
}

class _MoodCalendarState extends State<MoodCalendar> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _currentMonth = DateTime.now();
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  List<DateTime> _getDaysInMonth() {
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    
    final days = <DateTime>[];
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }
    
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth();
    final firstWeekday = daysInMonth.first.weekday;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        children: [
          // 月份标题
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: AppColors.textPrimary),
                onPressed: _previousMonth,
              ),
              Text(
                '${_currentMonth.year}年${_currentMonth.month}月',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: AppColors.textPrimary),
                onPressed: _nextMonth,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // 星期标题
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['日', '一', '二', '三', '四', '五', '六'].map((day) {
              return Text(
                day,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 8),
          
          // 日历网格
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: daysInMonth.length + firstWeekday,
            itemBuilder: (context, index) {
              if (index < firstWeekday) {
                return const SizedBox();
              }
              
              final dayIndex = index - firstWeekday;
              final date = daysInMonth[dayIndex];
              final record = widget.moodService.getRecordForDate(date);
              final isToday = date.year == DateTime.now().year &&
                             date.month == DateTime.now().month &&
                             date.day == DateTime.now().day;
              final isSelected = date.year == _selectedDate.year &&
                               date.month == _selectedDate.month &&
                               date.day == _selectedDate.day;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                  widget.onDateSelected(date);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? AppColors.accent.withValues(alpha: 0.3)
                        : isToday
                            ? AppColors.accent.withValues(alpha: 0.1)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected 
                          ? AppColors.accent
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                      if (record != null)
                        Icon(
                          record.icon,
                          color: record.color,
                          size: 16,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}