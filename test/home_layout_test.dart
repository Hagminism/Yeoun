import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yeoun/main.dart';
import 'package:yeoun/ui/app_assets.dart';
import 'package:yeoun/core/presentation/component/bottom_app_bar/app_bottom_app_bar.dart';
import 'package:yeoun/core/presentation/component/navigation_rail/app_navigation_rail.dart';
import 'package:yeoun/feature/home/presentation/component/card/anniversary_card.dart';
import 'package:yeoun/feature/home/presentation/component/dialog/home_widget_editor.dart';
import 'package:yeoun/feature/home/presentation/component/dialog/home_widget_toggle.dart';

void main() {
  setUpAll(() async {
    final loader = FontLoader('Pretendard')
      ..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf'));
    await loader.load();
  });

  testWidgets('Dashboard adapts across browser widths without overflow', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    const boundaryKey = ValueKey('home-capture');
    for (final width in [320.0, 390.0, 600.0, 800.0, 940.0, 1080.0, 1440.0]) {
      tester.view.physicalSize = Size(width, width == 390 ? 1687 : 1000);
      await tester.pumpWidget(
        const ProviderScope(
          child: RepaintBoundary(key: boundaryKey, child: MyApp()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        final context = tester.element(find.byType(MyApp));
        await Future.wait([
          precacheImage(const AssetImage(AppAssets.albumDate), context),
          precacheImage(const AssetImage(AppAssets.albumWalk), context),
          precacheImage(const AssetImage(AppAssets.culturePoster), context),
        ]);
      });
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'Viewport width: $width');
      expect(find.byType(AnniversaryCard), findsOneWidget);
      expect(
        find.byType(AppBottomAppBar),
        width < 1080 ? findsOneWidget : findsNothing,
      );
      expect(
        find.byType(AppNavigationRail),
        width >= 1080 ? findsOneWidget : findsNothing,
      );

      if (Platform.environment['YEOUN_CAPTURE_UI'] == '1' &&
          (width == 390 || width == 1440)) {
        final boundary = tester.renderObject<RenderRepaintBoundary>(
          find.byKey(boundaryKey),
        );
        await tester.runAsync(() async {
          final image = await boundary.toImage();
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          final name = width == 390 ? 'mobile' : 'desktop';
          await File(
            '/private/tmp/yeoun-home-$name.png',
          ).writeAsBytes(bytes!.buffer.asUint8List());
          image.dispose();
        });
      }
    }
  });

  testWidgets(
    'Bucket input can be opened repeatedly and widgets can be hidden',
    (tester) async {
      tester.view.physicalSize = const Size(390, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      for (final title in ['첫 번째 버킷', '두 번째 버킷']) {
        await tester.ensureVisible(find.text('새 버킷 추가하기'));
        await tester.tap(find.text('새 버킷 추가하기'));
        await tester.pumpAndSettle();
        expect(find.byType(TextField), findsOneWidget);
        await tester.enterText(find.byType(TextField), title);
        await tester.pump();
        await tester.tap(find.text('저장'));
        await tester.pumpAndSettle();
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pumpAndSettle();
        expect(find.text(title), findsOneWidget);
      }

      await tester.ensureVisible(find.text('위젯 추가 및 순서 편집'));
      await tester.tap(find.text('위젯 추가 및 순서 편집'));
      await tester.pumpAndSettle();
      expect(find.byType(HomeWidgetEditor), findsOneWidget);
      await tester.tap(find.byType(HomeWidgetToggle).first);
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('편집 닫기'));
      await tester.pumpAndSettle();
      expect(find.byType(AnniversaryCard), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}
