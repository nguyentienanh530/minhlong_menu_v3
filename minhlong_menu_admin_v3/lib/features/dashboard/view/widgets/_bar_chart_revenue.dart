import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_style.dart';
import '../../../../core/utils.dart';
import '../../data/model/data_chart.dart';

class BarChartRevenue extends StatelessWidget {
  const BarChartRevenue({super.key, required this.dataCharts});
  final List<DataChart> dataCharts;

  @override
  Widget build(BuildContext context) {
    double maxTotalPrice;

    if (dataCharts.isNotEmpty) {
      maxTotalPrice = dataCharts
          .map((e) => e.totalPrice)
          .reduce((max, current) => max > current ? max : current)
          .toDouble();
    } else {
      maxTotalPrice = 0.0;
    }
    dataCharts.sort((a, b) => a.date.compareTo(b.date));
    return BarChart(
      BarChartData(
        barTouchData: barTouchData(context),
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups(context),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxTotalPrice + 1000000,
      ),
    );
  }

  BarTouchData barTouchData(BuildContext context) => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              Ultils.currencyFormat(rod.toY),
              kBodyStyle.copyWith(
                fontWeight: FontWeight.w700,
                color: context.colorScheme.primary,
              ),
            );
          },
        ),
        // touchCallback: (FlTouchEvent event, barTouchResponse) {
        //   if (!event.isInterestedForInteractions ||
        //       barTouchResponse == null ||
        //       barTouchResponse.spot == null) {
        //     _touchedIndex.value = -1;
        //     return;
        //   }
        //   _touchedIndex.value = barTouchResponse.spot!.touchedBarGroupIndex;
        // },
      );

  Widget getTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        dataCharts[value.toInt()].date,
        style: kBodyStyle.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  LinearGradient _barsGradient(BuildContext context) => LinearGradient(
        colors: [
          context.colorScheme.primary.withOpacity(0.2),
          context.colorScheme.primary,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  BarChartGroupData itemChart(
    BuildContext context, {
    required int x,
    required double toY,
    bool isTouched = false,
  }) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          width: 30,
          borderRadius:
              isTouched ? BorderRadius.circular(10) : BorderRadius.circular(5),
          toY: toY,
          color: isTouched ? context.colorScheme.primary : AppColors.lavender,
          borderSide: isTouched
              ? BorderSide(color: context.colorScheme.primary, width: 2)
              : const BorderSide(color: Colors.white, width: 0),
          gradient: _barsGradient(context),
        )
      ],
      showingTooltipIndicators: [0],
    );
  }

  List<BarChartGroupData> barGroups(BuildContext context) {
    return dataCharts
        .asMap()
        .map(
          (key, value) => MapEntry(
            key,
            itemChart(context, x: key, toY: value.totalPrice),
          ),
        )
        .values
        .toList();
  }
}
