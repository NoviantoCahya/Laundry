// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main_screen.dart';

void main() {
  testWidgets('HomeScreen displays expected widgets',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: MainScreen()));

    // Verify that the time and date text are displayed.
    expect(find.text("21:31 WIB"), findsOneWidget);
    expect(find.text("Rabu, 20 Juni 2024"), findsOneWidget);

    // Verify the presence of buttons in the grid.
    expect(find.text("Datang"), findsOneWidget);
    expect(find.text("Pulang"), findsOneWidget);
    expect(find.text("Izin"), findsOneWidget);
    expect(find.text("Catatan"), findsOneWidget);

    // Verify the Face ID button is displayed.
    expect(find.text("Attendance Using Face ID"), findsOneWidget);
  });

  testWidgets('Navigates to PresensiScreen on route',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MainScreen(),
      routes: {},
    ));

    // Trigger navigation to PresensiScreen.
    Navigator.pushNamed(tester.element(find.byType(MainScreen)), '/presensi');
    await tester.pumpAndSettle();

    // Verify that PresensiScreen is displayed.
    expect(find.text("Presensi Anda telah berhasil dicatat!"), findsOneWidget);
  });
}
