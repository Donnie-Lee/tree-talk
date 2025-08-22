import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const SizedBox(height: 44),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.glassBg,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.accent,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.textSecondary,
                  tabs: const [
                    Tab(text: '冥想音频'),
                    Tab(text: '呼吸练习'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildMeditationAudioList(),
                  _buildBreathingExercise(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeditationAudioList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16, bottom: 84),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '推荐冥想',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _buildMeditationCard(
              title: '减压放松',
              duration: '10分钟',
              image: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
            ),
            const SizedBox(height: 16),
            _buildMeditationCard(
              title: '专注力提升',
              duration: '15分钟',
              image: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
            ),
            const SizedBox(height: 24),
            Text(
              '睡眠冥想',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _buildMeditationCard(
              title: '深度睡眠',
              duration: '30分钟',
              image: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
            ),
            const SizedBox(height: 16),
            _buildMeditationCard(
              title: '舒缓失眠',
              duration: '20分钟',
              image: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeditationCard({
    required String title,
    required String duration,
    required String image,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.network(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    duration,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreathingExercise() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '4-7-8 呼吸法',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '跟随动画，调整你的呼吸节奏',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
                border: Border.all(
                  color: AppColors.accent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentGlow,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '吸气',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text('开始练习'),
            ),
          ],
        ),
      ),
    );
  }
}