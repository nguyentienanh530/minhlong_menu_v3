import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/model/best_selling_food.dart';
import 'indicator.dart';

class PieChartTop4BestSellingFood extends StatefulWidget {
  const PieChartTop4BestSellingFood({super.key, required this.bestSellingFood});
  final List<BestSellingFood> bestSellingFood;

  @override
  State<StatefulWidget> createState() => _PieChartTop4BestSellingFoodState();
}

class _PieChartTop4BestSellingFoodState
    extends State<PieChartTop4BestSellingFood> {
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
                borderData: FlBorderData(show: false),
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
              color: Colors.red,
              text: _bestSellingFood.first.name,
              isSquare: true,
            ),
            Indicator(
              color: Colors.green,
              text: _bestSellingFood[1].name,
              isSquare: true,
            ),
            Indicator(
              color: Colors.blue,
              text: _bestSellingFood[2].name,
              isSquare: true,
            ),
            Indicator(
              color: Colors.orange,
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
            color: Colors.red,
            value: persentFirst,
            title: '${persentFirst.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: persentSecond,
            title: '${persentSecond.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue,
            value: persentThird,
            title: '${persentThird.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: persentFourth,
            title: '${persentFourth.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
