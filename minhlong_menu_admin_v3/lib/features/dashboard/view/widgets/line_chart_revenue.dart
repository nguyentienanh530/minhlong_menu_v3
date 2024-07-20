import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_style.dart';

class LineChartRevenue extends StatelessWidget {
  const LineChartRevenue({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      lineChart,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get lineChart => LineChartData(
        lineTouchData: lineTouch,
        gridData: gridData,
        titlesData: titles,
        borderData: borderData,
        lineBarsData: lineBars,
        minX: 0,
        maxX: 14,
        maxY: 11,
        minY: 0,
      );

  LineTouchData get lineTouch => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
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

  List<LineChartBarData> get lineBars => [
        lineChartBar_1,
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
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: kBodyStyle);
        break;
      case 7:
        text = const Text('OCT', style: kBodyStyle);
        break;
      case 12:
        text = const Text('DEC', style: kBodyStyle);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
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

  LineChartBarData get lineChartBar_1 => LineChartBarData(
        isCurved: true,
        color: AppColors.islamicGreen,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
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
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );
}
