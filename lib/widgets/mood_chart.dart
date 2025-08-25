import 'package:flutter/material.dart';
import '../models/mood_record.dart';
import '../services/mood_service.dart';
import '../theme/app_colors.dart';

class MoodChart extends StatelessWidget {
  final MoodService moodService;
  final DateTime? selectedDate;

  const MoodChart({
    super.key,
    required this.moodService,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    // 获取当前月的所有记录
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    
    final records = moodService.getRecordsForDateRange(
      firstDayOfMonth,
      lastDayOfMonth,
    );
    
    // 确保过滤掉null值并确保列表不为空
    final validRecords = records.whereType<MoodRecord>().toList();
    
    if (validRecords.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.glassBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Center(
          child: Text(
            '${now.month}月没有记录',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: MoodChartPainter(
          records: validRecords,
          selectedDate: selectedDate,
        ),
      ),
    );
  }
}

class MoodChartPainter extends CustomPainter {
  final List<MoodRecord> records;
  final DateTime? selectedDate;

  MoodChartPainter({
    required this.records,
    this.selectedDate,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    final dotPaint = Paint()
      ..style = PaintingStyle.fill;
    
    final textStyle = TextStyle(
      color: AppColors.textSecondary,
      fontSize: 10,
    );
    
    // 计算图表区域
    final chartHeight = size.height - 60;
    final chartWidth = size.width - 60;
    final startX = 40;
    final startY = 20;
    
    // 绘制坐标轴
    final axisPaint = Paint()
      ..color = AppColors.glassBorder
      ..strokeWidth = 1;
    
    // 绘制Y轴（垂直线）
    canvas.drawLine(
      Offset(startX.toDouble(), startY.toDouble()),
      Offset(startX.toDouble(), startY + chartHeight),
      axisPaint,
    );
    
    // 绘制X轴（水平线） - 中间位置
    final centerY = startY + chartHeight / 2;
    canvas.drawLine(
      Offset(startX.toDouble(), centerY),
      Offset(startX + chartWidth, centerY),
      axisPaint,
    );
    
    // 绘制Y轴标签
    final yLabels = ['+5', '+3', '0', '-3', '-5'];
    final labelPositions = [0.1, 0.3, 0.5, 0.7, 0.9];
    
    for (int i = 0; i < yLabels.length; i++) {
      final y = startY + (chartHeight * labelPositions[i]);
      final textSpan = TextSpan(
        text: yLabels[i],
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(startX - 25, y - textPainter.height / 2));
    }
    
    // 心情值映射：正数为好心情，负数为坏心情
    final moodValues = {
      '开心': 5.0,
      '平静': 3.0,
      '焦虑': -2.0,
      '悲伤': -4.0,
      '愤怒': -5.0,
      '疲惫': -1.0,
    };
    
    // 获取当前月的天数
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    
    // 按日期排序记录
    final sortedRecords = List<MoodRecord>.from(records)
      ..sort((a, b) => a.date.day.compareTo(b.date.day));
    
    // 绘制数据
    if (sortedRecords.isNotEmpty) {
      final stepX = chartWidth / (daysInMonth - 1);
      final maxValue = 5.0;
      
      final path = Path();
      
      for (int day = 1; day <= daysInMonth; day++) {
        final x = startX + ((day - 1) * stepX);
        
        // 查找当天的记录
        final record = sortedRecords.firstWhere(
          (r) => r.date.day == day,
          orElse: () => MoodRecord(
            date: DateTime(now.year, now.month, day),
            mood: '无',
            color: Colors.transparent,
            icon: Icons.circle,
          ),
        );
        
        if (record.mood != '无') {
          final moodValue = moodValues[record.mood] ?? 0.0;
          
          // 将心情值映射到Y轴位置
          final normalizedValue = moodValue / maxValue;
          final y = centerY - (normalizedValue * chartHeight / 2);
          
          if (path.getBounds().isEmpty) {
            path.moveTo(x.toDouble(), y.toDouble());
          } else {
            path.lineTo(x.toDouble(), y.toDouble());
          }
          
          // 绘制数据点
          dotPaint.color = moodValue > 0 ? Colors.green : Colors.red;
          canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 3, dotPaint);
        }
      }
      
      paint.color = AppColors.accent;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MoodChartPainter oldDelegate) => true;
}