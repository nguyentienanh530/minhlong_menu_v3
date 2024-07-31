import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_style.dart';
import '../../data/model/daily_revenue.dart';

class LineChartRevenue extends StatelessWidget {
  const LineChartRevenue({super.key, required this.dailyRevenues});
  final List<DailyRevenue> dailyRevenues;

  @override
  Widget build(BuildContext context) {
    double maxTotalPrice;

    if (dailyRevenues.isNotEmpty) {
      maxTotalPrice = dailyRevenues
          .map((e) => e.revenue)
          .reduce((max, current) => max > current ? max : current)
          .toDouble();
    } else {
      maxTotalPrice = 0.0;
    }
    dailyRevenues.sort((a, b) => a.date.compareTo(b.date));
    return LineChart(
      lineChart(maxTotalPrice),
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData lineChart(double max) => LineChartData(
        lineTouchData: lineTouch,
        gridData: gridData,
        titlesData: titles,
        borderData: borderData,
        lineBarsData: lineBars(),
        minX: 0,
        maxX: dailyRevenues.length.toDouble() - 1,
        maxY: max,
        minY: 0,
      );

  LineTouchData get lineTouch => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => AppColors.white.withOpacity(0.8),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return spot.barIndex == 0
                  ? LineTooltipItem(
                      'Đơn: ${Ultils.currencyFormat(spot.y / 500000)}\n',
                      kBodyStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.islamicGreen,
                      ))
                  : LineTooltipItem(
                      '${Ultils.currencyFormat(spot.y)}\n',
                      kBodyStyle.copyWith(
                        color: AppColors.red,
                        fontWeight: FontWeight.bold,
                      ));
            }).toList();
          },
        ),
      );

  FlTitlesData get titles => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> lineBars() => [
        lineChartBarOrderCount(),
        lineChartBar_2,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0m';
        break;
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '4m';
        break;
      case 5:
        text = '5m';
        break;
      case 6:
        text = '6m';
        break;
      case 7:
        text = '7m';
        break;
      case 8:
        text = '8m';
        break;
      case 9:
        text = '9m';
        break;
      case 10:
        text = '10m';
        break;
      case 11:
        text = '11m';
        break;

      // break;
      default:
        return Container();
    }

    return Text(text, style: kBodyStyle, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: false,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        Ultils.formatDateToString(dailyRevenues[value.toInt()].date,
            onlyDayAndMonth: true),
        style: kCaptionStyle,
      ),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 40,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData =>
      const FlGridData(show: true, drawVerticalLine: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: AppColors.secondTextColor.withOpacity(0.2), width: 1),
          left: BorderSide(
              color: AppColors.secondTextColor.withOpacity(0.2), width: 1),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData lineChartBarOrderCount() => LineChartBarData(
        isCurved: true,
        color: AppColors.islamicGreen,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          ...dailyRevenues.asMap().map((key, value) {
            return MapEntry(
                key,
                FlSpot(key.toDouble(),
                    double.parse(((value.orderCount * 500000)).toString())));
          }).values,
        ],
      );

  LineChartBarData get lineChartBar_2 => LineChartBarData(
        isCurved: true,
        color: Colors.pink,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.pink.withOpacity(0),
        ),
        spots: [
          ...dailyRevenues.asMap().map((key, value) {
            return MapEntry(key, FlSpot(key.toDouble(), value.revenue));
          }).values,
        ],
      );
}
