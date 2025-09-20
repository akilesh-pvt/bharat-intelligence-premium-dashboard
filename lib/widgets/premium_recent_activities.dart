import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';

class PremiumRecentActivities extends StatelessWidget {
  const PremiumRecentActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activities',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Activity Items
          _buildActivityItem(
            title: 'Task assigned to Rajesh Kumar',
            subtitle: 'Field survey in Sector 12A',
            time: '2 hours ago',
            icon: Icons.assignment_outlined,
            color: AppTheme.warningColor,
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            title: 'Allowance approved for Amit Singh',
            subtitle: 'Petrol allowance ₹850 approved',
            time: '4 hours ago',
            icon: Icons.check_circle_outline,
            color: AppTheme.successColor,
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            title: 'New farmer registered',
            subtitle: 'Priya Sharma added to database',
            time: '6 hours ago',
            icon: Icons.person_add_outlined,
            color: AppTheme.infoColor,
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            title: 'Field visit completed',
            subtitle: 'Visited 12 farms in Gwalior district',
            time: '8 hours ago',
            icon: Icons.location_on_outlined,
            color: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppTheme.textTertiary,
          ),
        ),
      ],
    );
  }
}