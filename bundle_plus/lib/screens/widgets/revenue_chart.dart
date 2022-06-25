import 'package:bundle_plus/model/revenue_series.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RevenueChart extends StatelessWidget {
  const RevenueChart({Key? key, required this.data}) : super(key: key);
  final List<RevenueSeries> data;
  @override
  Widget build(BuildContext context) {
    List<charts.Series<RevenueSeries, String>> series = [
      charts.Series(
          id: "developers",
          data: data,
          domainFn: (RevenueSeries series, _) => series.category,
          measureFn: (RevenueSeries series, _) => series.revenue,
          colorFn: (RevenueSeries series, _) => series.barColor)
    ];

    return charts.BarChart(series, animate: true);
  }
}
