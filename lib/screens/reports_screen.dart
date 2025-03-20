import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const ReportsScreen({super.key, required this.transactions});

  List<PieChartSectionData> _generateChartData() {
    final categoryTotals = <String, double>{};
    for (var transaction in transactions) {
      final category = transaction['category'];
      final amount = transaction['amount'];
      categoryTotals[category] = (categoryTotals[category] ?? 0) + amount;
    }

    return categoryTotals.entries
        .map(
          (entry) => PieChartSectionData(
        color: _getCategoryColor(entry.key),
        value: entry.value,
        title: '${entry.key}\n\$${entry.value.toStringAsFixed(2)}',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    )
        .toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.orange;
      case 'Transport':
        return Colors.blue;
      case 'Shopping':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Center(
        child: PieChart(
          PieChartData(
            sections: _generateChartData(),
            sectionsSpace: 2,
            centerSpaceRadius: 50,
          ),
        ),
      ),
    );
  }
}
