import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.black.withValues(alpha: 0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_4_bar, color: AppColors.textPrimary, size: 14),
              const SizedBox(width: 5),
              Icon(Icons.wifi, color: AppColors.textPrimary, size: 14),
              const SizedBox(width: 5),
              Icon(Icons.battery_full, color: AppColors.textPrimary, size: 14),
            ],
          ),
        ],
      ),
    );
  }
}