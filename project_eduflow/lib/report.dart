
import 'package:flutter/material.dart';
import 'dart:math' as math;
class ReportPage extends StatelessWidget {
  const ReportPage({super.key});
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final score = args?['score'] as int? ?? 0;
    final total = args?['total'] as int? ?? 0;
    final percent = total == 0 ? 0.0 : (score / total) * 100.0;
    String grade;
    if (total == 0) grade = 'N/A';
    else if (percent >= 85) grade = 'Excellent';
    else if (percent >= 70) grade = 'Very Good';
    else if (percent >= 50) grade = 'Pass';
    else grade = 'Needs Improvement';
    return Scaffold(
      appBar: AppBar(title: const Text('Report'), backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black87)),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFFFF8EE), Color(0xFFFFF3D6)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Card(
              elevation: 12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // circular progress
                    _CircularProgress(value: percent / 100.0),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Score: $score / $total', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Percentage: ${percent.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Text('Grade: $grade', style: const TextStyle(fontSize: 14, color: Colors.black87)),
                      ]),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Suggestions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  if (percent >= 85)
                    const Text('Great job — you have strong knowledge here. Try a higher difficulty set.')
                  else if (percent >= 50)
                    const Text('Good attempt — review the incorrect areas and retry the quiz.')
                  else
                    const Text('We recommend revisiting fundamentals and using flashcards more frequently.'),
                ]),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/dashboard')),
              icon: const Icon(Icons.home),
              label: const Text('Back to dashboard'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD99B2B)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
class _CircularProgress extends StatelessWidget {
  final double value;
  const _CircularProgress({required this.value});
  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).round();
    return SizedBox(
      width: 92,
      height: 92,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: value.clamp(0.0, 1.0),
            strokeWidth: 8,
            backgroundColor: Colors.grey.withOpacity(0.2),
            color: const Color(0xFFD99B2B),
          ),
          Center(child: Text('$percent%', style: const TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
