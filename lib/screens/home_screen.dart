import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        // padding: const EdgeInsets.only(top: 44, bottom: 84),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                '今天感觉如何？',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '选择一个最能代表你当前情绪的状态',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              
              // 情绪网格
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildEmotionItem('开心', Icons.sentiment_very_satisfied, AppColors.emotionHappy),
                  _buildEmotionItem('平静', Icons.sentiment_satisfied, AppColors.emotionCalm),
                  _buildEmotionItem('焦虑', Icons.sentiment_neutral, AppColors.emotionAnxious),
                  _buildEmotionItem('悲伤', Icons.sentiment_dissatisfied, AppColors.emotionSad),
                  _buildEmotionItem('愤怒', Icons.sentiment_very_dissatisfied, AppColors.emotionAngry),
                  _buildEmotionItem('疲惫', Icons.bedtime, AppColors.emotionTired),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // 情绪日记
              Text(
                '记录你的心情',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              
              // 输入区域
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.glassBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Column(
                  children: [
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: '写下你的感受...',
                        hintStyle: TextStyle(color: AppColors.textTertiary),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tag, color: AppColors.textSecondary, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              '添加标签',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('保存'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // 情绪趋势
              Text(
                '情绪趋势',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              
              // 趋势图
              Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.glassBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: CustomPaint(
                  size: const Size(double.infinity, 200),
                  painter: EmotionChartPainter(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildEmotionItem(String label, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.2),
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// 情绪趋势图绘制
class EmotionChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    final dotPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.fill;
    
    final path = Path();
    
    // 模拟数据点
    final points = [
      Offset(0, size.height * 0.5),
      Offset(size.width * 0.2, size.height * 0.7),
      Offset(size.width * 0.4, size.height * 0.3),
      Offset(size.width * 0.6, size.height * 0.5),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width, size.height * 0.4),
    ];
    
    // 绘制路径
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    
    canvas.drawPath(path, paint);
    
    // 绘制数据点
    for (var point in points) {
      canvas.drawCircle(point, 4, dotPaint);
    }
    
    // 绘制X轴标签
    final textStyle = TextStyle(color: AppColors.textSecondary, fontSize: 10);
    final textSpan = TextSpan(
      text: '过去7天',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - textPainter.width, size.height - textPainter.height));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}