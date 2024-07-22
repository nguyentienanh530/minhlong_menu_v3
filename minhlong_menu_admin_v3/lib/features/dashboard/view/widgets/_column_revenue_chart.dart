import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_style.dart';
import '../../../../core/utils.dart';
import '../../data/model/data_chart.dart';

class ColumnRevenueChart extends StatelessWidget {
  const ColumnRevenueChart({super.key, required this.dataCharts});
  final List<DataChart> dataCharts;

  @override
  Widget build(BuildContext context) {
    double maxTotalPrice = dataCharts
        .map((e) => e.totalPrice)
        .reduce((max, current) => max > current ? max : current)
        .toDouble();
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups(),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxTotalPrice + 1000000,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
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
              kBodyStyle.copyWith(fontWeight: FontWeight.w700),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    // switch (value.toInt()) {
    //   case 0:
    //     text = 'T2';
    //     break;
    //   case 1:
    //     text = 'T3';
    //     break;
    //   case 2:
    //     text = 'T4';
    //     break;
    //   case 3:
    //     text = 'T5';
    //     break;
    //   case 4:
    //     text = 'T6';
    //     break;
    //   case 5:
    //     text = 'T7';
    //     break;
    //   case 6:
    //     text = 'CN';
    //     break;
    //   default:
    //     text = '';
    //     break;
    // }
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

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.themeColor.withOpacity(0.2),
          AppColors.themeColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  BarChartGroupData itemChart({required int x, required double toY}) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          width: 30,
          borderRadius: BorderRadius.circular(5),
          toY: toY,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    );
  }

  List<BarChartGroupData> barGroups() {
    return dataCharts
        .asMap()
        .map((key, value) {
          return MapEntry(key, itemChart(x: key, toY: value.totalPrice));
        })
        .values
        .toList();
  }
}
