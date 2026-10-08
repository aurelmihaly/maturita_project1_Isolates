import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maturita_project1/home_screen.dart';
import 'package:maturita_project1/prime_calculator.dart';
import 'package:maturita_project1/spinner_box.dart';

Widget _app() => MaterialApp(
  home: HomeScreen(
    limit: 100,
    // V testu nepoužíváme skutečný isolate, widget testy běží v „falešném čase“.
    isolateRunner: (limit) async => countPrimes(limit),
  ),
);

void main() {
  testWidgets('zobrazí obě tlačítka a výchozí text', (tester) async {
    await tester.pumpWidget(_app());

    expect(find.text('UI vlákno'), findsOneWidget);
    expect(find.text('Isolate'), findsOneWidget);
    expect(find.textContaining('Zatím nic'), findsOneWidget);
  });

  testWidgets('po stisku Isolate zobrazí výsledek výpočtu', (tester) async {
    await tester.pumpWidget(_app());

    await tester.tap(find.text('Isolate'));
    await tester.pump();
    expect(find.textContaining('Počítám'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump();
    expect(find.textContaining('prvočísel: 25'), findsOneWidget);
  });

  testWidgets('animace se otáčí', (tester) async {
    await tester.pumpWidget(_app());

    final rotation = find.descendant(
      of: find.byType(SpinnerBox),
      matching: find.byType(RotationTransition),
    );
    double turns() => tester.widget<RotationTransition>(rotation).turns.value;

    final before = turns();
    await tester.pump(const Duration(milliseconds: 500));
    expect(turns(), isNot(before));
  });
}
