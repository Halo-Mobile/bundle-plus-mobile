import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class RevenueSeries {
  final String category;
  final double revenue;
  final charts.Color barColor;

  RevenueSeries(
      {required this.category, required this.revenue, required this.barColor});
}
