
import 'package:flutter/material.dart';
class QuizGamePage extends StatefulWidget {
  const QuizGamePage({super.key});
  @override
  State<QuizGamePage> createState() => _QuizGamePageState();
}
class _QuizGamePageState extends State<QuizGamePage> {
  final List<Map<String, Object>> _questions = [
    {
      'q': 'Which language is used by Flutter?',
      'options': ['Java', 'Kotlin', 'Dart', 'Swift'],
      'ans': 2
    },
    {
      'q': 'Which widget holds mutable state?',
      'options': ['StatelessWidget', 'StatefulWidget', 'InheritedWidget', 'Builder'],
      'ans': 1
    },
    {
      'q': 'Hot reload helps to:',
      'options': ['Restart app', 'Inject updated source', 'Build release', 'None'],
      'ans': 1
    },
  ];
  int _index = 0;
  int _score = 0;
  bool _answered = false;
  int? _selected;
  void _select(int i) {
    if (_answered) return;
    setState(() {
      _selected = i;
      _answered = true;
      final correct = _questions[_index]['ans'] as int;
      if (i == correct) _score++;
    });
  }
  void _next() {
    if (_index + 1 < _questions.length) {
      setState(() {
        _index++;
        _answered = false;
        _selected = null;
      });
    } else {
      Navigator.pushNamed(context, '/report', arguments: {'score': _score, 'total': _questions.length});
    }
  }
  @override
  Widget build(BuildContext context) {
    final q = _questions[_index];
    final opts = (q['options'] as List<String>);
    final correct = q['ans'] as int;
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Game'), backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black87)),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFFFFBF2), Color(0xFFFFF5E6)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Question ${_index + 1} / ${_questions.length}', style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 8),
                  Text(q['q'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(opts.length, (i) {
              Color? bg;
              if (_answered) {
                if (i == correct) bg = Colors.green.withOpacity(0.12);
                else if (_selected == i && i != correct) bg = Colors.red.withOpacity(0.12);
              }
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Material(
                  color: bg ?? Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: InkWell(
                    onTap: () => _select(i),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Radio<int>(value: i, groupValue: _selected, onChanged: _answered ? null : (v) => _select(v!)),
                          const SizedBox(width: 8),
                          Expanded(child: Text(opts[i])),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            Row(
              children: [
                Text('Score: $_score', style: const TextStyle(fontSize: 16)),
                const Spacer(),
                ElevatedButton(
                  onPressed: _answered ? _next : null,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD99B2B)),
                  child: Text(_index + 1 == _questions.length ? 'Finish' : 'Next'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
