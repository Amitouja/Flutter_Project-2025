import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_eduflow/main.dart'; // keep your package name

void main() {
  testWidgets('Login flows to Dashboard', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const EduTechApp());
    await tester.pumpAndSettle();

    // The login screen should show the app title
    expect(find.text('EduFlow'), findsOneWidget);

    // There are two TextFormField widgets: email and password.
    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;

    // Fill them
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');

    // Tap the Login button
    final loginButton = find.widgetWithText(ElevatedButton, 'Login');
    expect(loginButton, findsOneWidget);
    await tester.tap(loginButton);

    // Wait for animations and navigation
    await tester.pumpAndSettle();

    // Dashboard should appear (we expect "Hello, Learner" text)
    expect(find.text('Hello, Learner'), findsOneWidget);
  });
}
