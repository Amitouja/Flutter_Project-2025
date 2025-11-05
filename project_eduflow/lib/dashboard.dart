
import 'package:flutter/material.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}
class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  int _selected = 0;
  late AnimationController _anim;
  final tabs = ['Flashcards', 'Quiz', 'Report'];
  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _anim.forward();
  }
  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }
  void _open(String route) {
    Navigator.pushNamed(context, route);
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.black54),
          )
        ],
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFF7E6), Color(0xFFFCEBD3)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Top curvy panel
          Positioned(
            top: 80,
            left: -40,
            right: -40,
            child: Transform.rotate(
              angle: -0.04,
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFFE9BC), Color(0xFFFFF3D6)]),
                  borderRadius: BorderRadius.circular(36),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 8))],
                ),
                padding: const EdgeInsets.all(22),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 36, backgroundColor: Color(0xFF6B4C00), child: Icon(Icons.person, color: Colors.white)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Hello, Amitouja!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 6),
                          Text('Choose a learning mode below', style: TextStyle(fontSize: 14, color: Colors.black54)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD99B2B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: () => _open('/flashcards'),
                      child: const Text('Start', style: TextStyle(fontSize: 14)),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Action cards
          Positioned(
            top: 320,
            left: 18,
            right: 18,
            bottom: 16,
            child: FadeTransition(
              opacity: CurvedAnimation(parent: _anim, curve: Curves.easeIn),
              child: Column(
                children: [
                  Row(
                    children: [
                      _ActionCard(title: 'Flashcards', subtitle: 'Learn quickly', icon: Icons.menu_book, onTap: () => _open('/flashcards')),
                      const SizedBox(width: 12),
                      _ActionCard(title: 'Quiz Game', subtitle: 'Test yourself', icon: Icons.quiz, onTap: () => _open('/quiz')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _ActionCard(title: 'Progress', subtitle: 'View report', icon: Icons.insert_chart, flex: 1, onTap: () => _open('/report')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Study Streak', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 8),
                                  Text('4 days', style: TextStyle(fontSize: 28, color: Color(0xFFD99B2B))),
                                  SizedBox(height: 6),
                                  Text('Keep it up!', style: TextStyle(fontSize: 12, color: Colors.black54)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // quick actions row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _SmallAction(icon: Icons.star, label: 'Favorites'),
                      _SmallAction(icon: Icons.history, label: 'Recent'),
                      _SmallAction(icon: Icons.bookmark, label: 'Saved'),
                      _SmallAction(icon: Icons.shield, label: 'Practice'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final int flex;
  const _ActionCard({required this.title, required this.subtitle, required this.icon, required this.onTap, this.flex = 1});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(colors: [Colors.white, Color(0xFFFFF8EE)]),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon, size: 28, color: const Color(0xFFD99B2B)),
            const Spacer(),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(subtitle, style: const TextStyle(color: Colors.black54)),
          ]),
        ),
      ),
    );
  }
}
class _SmallAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SmallAction({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)]),
          padding: const EdgeInsets.all(12),
          child: Icon(icon, size: 20, color: const Color(0xFFD99B2B)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}
