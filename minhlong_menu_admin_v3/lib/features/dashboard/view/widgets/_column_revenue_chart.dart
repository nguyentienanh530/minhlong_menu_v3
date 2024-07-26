import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_style.dart';
import '../../../../core/utils.dart';
import '../../data/model/data_chart.dart';

class ColumnRevenueChart extends StatelessWidget {
  ColumnRevenueChart({super.key, required this.dataCharts});
  final List<DataChart> dataCharts;
  final _touchedIndex = ValueNotifier(-1);

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
    return ListenableBuilder(
        listenable: _touchedIndex,
        builder: (context, _) {
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
        });
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
              kBodyStyle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.themeColor,
              ),
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          if (!event.isInterestedForInteractions ||
              barTouchResponse == null ||
              barTouchResponse.spot == null) {
            _touchedIndex.value = -1;
            return;
          }
          _touchedIndex.value = barTouchResponse.spot!.touchedBarGroupIndex;
        },
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

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.themeColor.withOpacity(0.2),
          AppColors.themeColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  BarChartGroupData itemChart({
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
          color: isTouched ? AppColors.themeColor : AppColors.lavender,
          borderSide: isTouched
              ? const BorderSide(color: AppColors.themeColor, width: 2)
              : const BorderSide(color: Colors.white, width: 0),
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    );
  }

  List<BarChartGroupData> barGroups() {
    return dataCharts
        .asMap()
        .map(
          (key, value) => MapEntry(
            key,
            itemChart(
                x: key,
                toY: value.totalPrice,
                isTouched: key == _touchedIndex.value),
          ),
        )
        .values
        .toList();
  }
}