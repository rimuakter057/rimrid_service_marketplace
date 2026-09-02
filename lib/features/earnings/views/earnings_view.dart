import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/empty_state.dart';
import '../controllers/earnings_controller.dart';

class EarningsView extends GetView<EarningsController> {
  const EarningsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.lg),
          children: [
            Text('Earnings', style: AppTextStyles.h2),
            const SizedBox(height: AppSizes.lg),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.lg),
              decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(AppSizes.radiusXl)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Earnings', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white.withValues(alpha: 0.85))),
                  const SizedBox(height: 4),
                  Text(controller.totalEarnings.asCurrency, style: AppTextStyles.h1.copyWith(color: Colors.white)),
                  const SizedBox(height: AppSizes.sm),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_rounded, color: Colors.white.withValues(alpha: 0.85), size: 16),
                      const SizedBox(width: 4),
                      Text('${controller.thisMonthEarnings.asCurrency} this month', style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.85))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.lg),
            Row(
              children: [
                _StatCard(label: 'Completed Jobs', value: '${controller.completedCount}', icon: Icons.task_alt_rounded),
                const SizedBox(width: AppSizes.sm),
                _StatCard(label: 'Avg. Job Value', value: controller.avgJobValue.asCurrency, icon: Icons.trending_up_rounded),
              ],
            ),
            const SizedBox(height: AppSizes.sm),
            Row(
              children: [
                _StatCard(label: 'Pending Payout', value: controller.pendingPayout.asCurrency, icon: Icons.hourglass_bottom_rounded),
                const SizedBox(width: AppSizes.sm),
                _StatCard(label: 'Next Payout', value: 'Fri, Sep 5', icon: Icons.event_available_rounded),
              ],
            ),
            const SizedBox(height: AppSizes.xl),
            _WeeklyEarningsChart(controller: controller),
            const SizedBox(height: AppSizes.xl),
            Text('Recent Payouts', style: AppTextStyles.h4),
            const SizedBox(height: AppSizes.sm),
            if (controller.completedJobs.isEmpty)
              const EmptyState(icon: Icons.receipt_long_outlined, title: 'No completed jobs yet', message: 'Your payout history will appear here once you complete bookings.')
            else
              ...controller.completedJobs.map((b) => Container(
                    margin: const EdgeInsets.only(bottom: AppSizes.sm),
                    padding: const EdgeInsets.all(AppSizes.sm),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 3))],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: AppColors.successSurface, shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_downward_rounded, color: AppColors.success, size: 16),
                        ),
                        const SizedBox(width: AppSizes.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(b.serviceTitle, style: AppTextStyles.labelMedium),
                              Text(b.date.toDayMonth, style: AppTextStyles.caption),
                            ],
                          ),
                        ),
                        Text('+${(b.price + (b.tipAmount ?? 0)).asCurrency}', style: AppTextStyles.labelLarge.copyWith(color: AppColors.success)),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(height: 6),
            Text(value, style: AppTextStyles.labelLarge),
            Text(label, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }
}

/// A smooth gradient-filled line chart for the week's earnings, with a
/// glowing peak-day marker and a week-over-week trend badge — a more
/// distinctive alternative to a plain bar chart.
class _WeeklyEarningsChart extends StatelessWidget {
  final EarningsController controller;

  const _WeeklyEarningsChart({required this.controller});

  @override
  Widget build(BuildContext context) {
    final trend = controller.weeklyTrend;
    final maxValue = trend.fold<double>(0, (m, v) => v > m ? v : m);
    final maxY = maxValue <= 0 ? 100.0 : maxValue * 1.35;
    final change = controller.weekChangePercent;
    final peakIndex = controller.peakDayIndex;
    final todayIndex = controller.todayIndex;

    return Container(
      padding: const EdgeInsets.fromLTRB(AppSizes.lg, AppSizes.lg, AppSizes.lg, AppSizes.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('This Week', style: AppTextStyles.h4),
                    const SizedBox(height: 2),
                    Text(controller.weekRangeLabel, style: AppTextStyles.caption),
                  ],
                ),
              ),
              if (change != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.xs, vertical: 5),
                  decoration: BoxDecoration(
                    color: change >= 0 ? AppColors.successSurface : AppColors.errorSurface,
                    borderRadius: BorderRadius.circular(AppSizes.radiusPill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        change >= 0 ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                        size: 12,
                        color: change >= 0 ? AppColors.success : AppColors.error,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${change.abs().toStringAsFixed(0)}%',
                        style: AppTextStyles.labelSmall.copyWith(color: change >= 0 ? AppColors.success : AppColors.error),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 2),
          Text(controller.weekTotal.asCurrency, style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
          const SizedBox(height: AppSizes.md),
          SizedBox(
            height: 170,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (context, t, _) {
                final spots = List.generate(trend.length, (i) => FlSpot(i.toDouble(), trend[i] * t));
                return LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: maxY,
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 26,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < 0 || index > 6) return const SizedBox.shrink();
                            final isToday = index == todayIndex;
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                EarningsController.weekdayLabels[index].substring(0, 1),
                                style: (isToday ? AppTextStyles.labelSmall : AppTextStyles.caption).copyWith(
                                  color: isToday ? AppColors.primary : AppColors.textHint,
                                  fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => AppColors.primaryDark,
                        tooltipRoundedRadius: AppSizes.radiusSm,
                        tooltipPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        getTooltipItems: (touchedSpots) => touchedSpots.map((s) {
                          final i = s.x.toInt();
                          return LineTooltipItem(
                            '${EarningsController.weekdayLabels[i]}\n\$${trend[i].toStringAsFixed(0)}',
                            AppTextStyles.labelSmall.copyWith(color: Colors.white, height: 1.3),
                          );
                        }).toList(),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        curveSmoothness: 0.32,
                        gradient: const LinearGradient(colors: [AppColors.primaryDark, AppColors.primaryLight]),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) {
                            final isPeak = index == peakIndex && trend[peakIndex] > 0;
                            return FlDotCirclePainter(
                              radius: isPeak ? 5.5 : 3,
                              color: Colors.white,
                              strokeWidth: isPeak ? 3 : 2,
                              strokeColor: AppColors.primary,
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AppColors.primary.withValues(alpha: 0.28), AppColors.primary.withValues(alpha: 0.0)],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
