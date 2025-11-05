
import 'package:flutter/material.dart';
import 'login.dart';
import 'dashboard.dart';
import 'flashcard.dart';
import 'quizgame.dart';
import 'report.dart';
void main() {
  runApp(const EduTechApp());
}
class EduTechApp extends StatelessWidget {
  const EduTechApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (c) => const LoginPage(),
        '/dashboard': (c) => const DashboardPage(),
        '/flashcards': (c) => const FlashcardPage(),
        '/quiz': (c) => const QuizGamePage(),
        '/report': (c) => const ReportPage(),
      },
    );
  }
}
