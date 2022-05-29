import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import './data.dart';

class PieCharts extends StatelessWidget {
  const PieCharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> gg = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };
    final Data data = Data();
    return Scaffold(
      body: FutureProvider<Map<String, double>>(
        initialData: gg,
        create: (_) {
          return data.fetch(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<Map<String, double>>(
            builder: (context, value, child) => PieChart(
              dataMap: value,
              chartType: ChartType.disc,
              baseChartColor: Colors.grey[300]!,
              //colorList: colorList,
            ),
          ),
        ),
      ),
    );
  }
}
