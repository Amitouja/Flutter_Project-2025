
import 'package:flutter/material.dart';
import 'dart:math' as math;
class FlashcardPage extends StatefulWidget {
  const FlashcardPage({super.key});
  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}
class _FlashcardPageState extends State<FlashcardPage> with SingleTickerProviderStateMixin {
  final List<Map<String, String>> cards = [
    {'front': 'What is Flutter?', 'back': 'An open-source UI toolkit by Google.'},
    {'front': 'Programming language?', 'back': 'Dart'},
    {'front': 'Widget types?', 'back': 'Stateless and Stateful'},
    {'front': 'Hot reload?', 'back': 'Inject updated source code at runtime.'},
  ];
  int index = 0;
  bool showingFront = true;
  late AnimationController _flipController;
  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(vsync: this, duration: const Duration(milliseconds: 420));
  }
  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }
  void _flip() {
    if (showingFront) _flipController.forward();
    else _flipController.reverse();
    setState(() => showingFront = !showingFront);
  }
  void _next() {
    setState(() {
      index = (index + 1) % cards.length;
      if (!showingFront) {
        showingFront = true;
        _flipController.reverse();
      }
    });
  }
  void _prev() {
    setState(() {
      index = (index - 1 + cards.length) % cards.length;
      if (!showingFront) {
        showingFront = true;
        _flipController.reverse();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final front = cards[index]['front']!;
    final back = cards[index]['back']!;
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards'), backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black87)),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFFFFFBF2), Color(0xFFFFF5E6)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // stacked shadow cards for depth
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(-20, 18),
                    child: _decorCard(shade: 12),
                  ),
                  Transform.translate(offset: const Offset(8, 36), child: _decorCard(shade: 8)),
                  GestureDetector(
                    onTap: _flip,
                    child: AnimatedBuilder(
                      animation: _flipController,
                      builder: (context, child) {
                        final val = _flipController.value;
                        final angle = val * math.pi;
                        final isBack = val > 0.5;
                        return Transform(
                          transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(angle),
                          alignment: Alignment.center,
                          child: Container(
                            width: 340,
                            height: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 18)],
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(isBack ? back : front, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text('Card ${index + 1} of ${cards.length}', style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 12),
              Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(onPressed: _prev, icon: const Icon(Icons.chevron_left)),
                ElevatedButton(onPressed: _flip, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD99B2B)), child: const Text('Flip')),
                IconButton(onPressed: _next, icon: const Icon(Icons.chevron_right)),
              ]),
              const SizedBox(height: 18),
              const Text('Tap the card to flip', style: TextStyle(fontSize: 12, color: Colors.black45)),
            ],
          ),
        ),
      ),
    );
  }
  Widget _decorCard({double shade = 10}) {
    return Container(
      width: 340,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.9),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: shade)],
      ),
    );
  }
}
