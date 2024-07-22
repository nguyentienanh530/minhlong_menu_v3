import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../data/model/best_selling_food.dart';
import 'indicator.dart';

class PieChartBestSellingFood extends StatefulWidget {
  const PieChartBestSellingFood({super.key, required this.bestSellingFood});
  final List<BestSellingFood> bestSellingFood;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartBestSellingFood> {
  int touchedIndex = -1;
  late List<BestSellingFood> _bestSellingFood;

  @override
  void initState() {
    super.initState();
    _bestSellingFood = widget.bestSellingFood;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Indicator(
              color: Colors.redAccent,
              text: _bestSellingFood.first.name,
              isSquare: true,
            ),
            Indicator(
              color: Colors.blueAccent,
              text: _bestSellingFood[1].name,
              isSquare: true,
            ),
            Indicator(
              color: Colors.purpleAccent,
              text: _bestSellingFood[2].name,
              isSquare: true,
            ),
            Indicator(
              color: Colors.amberAccent,
              text: _bestSellingFood.last.name,
              isSquare: true,
            ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    var totalOrderCount = _bestSellingFood.fold(
        0.0, (double total, current) => total + current.orderCount);
    var persentFirst =
        ((_bestSellingFood.first.orderCount / totalOrderCount) * 100);
    var persentSecond =
        ((_bestSellingFood[1].orderCount / totalOrderCount) * 100);
    var persentThird =
        ((_bestSellingFood[2].orderCount / totalOrderCount) * 100);
    var persentFourth =
        ((_bestSellingFood.last.orderCount / totalOrderCount) * 100);
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.redAccent,
            value: persentFirst,
            title: '${persentFirst.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blueAccent,
            value: persentSecond,
            title: '${persentSecond.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purpleAccent,
            value: persentThird,
            title: '${persentThird.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.amberAccent,
            value: persentFourth,
            title: '${persentFourth.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
