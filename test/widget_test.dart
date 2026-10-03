// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yeoun/main.dart';

void main() {
  testWidgets('Home banner can be dismissed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    // Verify that the home dashboard shows its connection banner.
    expect(find.text('지우 님과 함께 기록 중'), findsOneWidget);

    // Tap the banner close button and trigger a frame.
    await tester.tap(find.byTooltip('연결 배너 닫기'));
    await tester.pumpAndSettle();

    // Verify that dismissing the banner keeps the dashboard visible.
    expect(find.text('지우 님과 함께 기록 중'), findsNothing);
    expect(find.textContaining('D+354', findRichText: true), findsOneWidget);
  });
}
