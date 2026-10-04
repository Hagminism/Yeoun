import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yeoun/core/presentation/component/bottom_app_bar/app_bottom_app_bar.dart';
import 'package:yeoun/core/routing/router.dart';
import 'package:yeoun/core/routing/routes.dart';
import 'package:yeoun/feature/bucket/domain/model/bucket_list_category.dart';
import 'package:yeoun/feature/bucket/presentation/component/filter/bucket_list_filter_chips.dart';
import 'package:yeoun/feature/bucket/presentation/screen/bucket_list_view_model.dart';
import 'package:yeoun/main.dart';

void main() {
  testWidgets('Bottom navigation preserves bucket tab state', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    router.go(Routes.home);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(tester.widget<Scaffold>(find.byType(Scaffold)).extendBody, isTrue);

    await tester.tap(
      find.descendant(
        of: find.byType(AppBottomAppBar),
        matching: find.text('버킷'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(BucketListFilterChips),
        matching: find.text('여행'),
      ),
    );
    await tester.enterText(find.byType(TextFormField), '이동 후에도 남길 버킷');
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MyApp)),
      listen: false,
    );
    expect(
      container.read(bucketListViewModelProvider).selectedCategory,
      BucketListCategory.travel,
    );

    await tester.tap(
      find.descendant(
        of: find.byType(AppBottomAppBar),
        matching: find.text('설정'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Space 관리'), findsOneWidget);

    await tester.tap(
      find.descendant(
        of: find.byType(AppBottomAppBar),
        matching: find.text('버킷'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      container.read(bucketListViewModelProvider).selectedCategory,
      BucketListCategory.travel,
    );
    final inputField = tester.widget<EditableText>(
      find.descendant(
        of: find.byType(TextFormField),
        matching: find.byType(EditableText),
      ),
    );
    expect(inputField.controller.text, '이동 후에도 남길 버킷');
    expect(tester.takeException(), isNull);
  });
}
