import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../../../../core/presentation/responsive/app_breakpoints.dart';
import '../../screen/home_action.dart';
import '../../screen/home_state.dart';
import '../banner/partner_sync_banner.dart';
import '../button/widget_edit_button.dart';
import 'home_widget_wrapper.dart';

class HomeDashboardLayout extends StatelessWidget {
  final HomeState state;
  final void Function(HomeAction) onAction;

  const HomeDashboardLayout({
    super.key,
    required this.state,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final progress = AppBreakpoints.desktopProgress(constraints.maxWidth);
        final padding = 16 + 16 * progress;
        final scrollBottomPadding = math.max(
          56.0,
          MediaQuery.paddingOf(context).bottom + 16,
        );
        final configs =
            state.widgetConfigs.where((config) => config.visible).toList()
              ..sort(
                (first, second) => first.position.compareTo(second.position),
              );
        final availableWidth = (constraints.maxWidth - padding * 2).clamp(
          0.0,
          AppBreakpoints.maxContentWidth,
        );
        final columns = availableWidth >= AppBreakpoints.twoColumnContent
            ? 2
            : 1;
        final gap = 16 + 8 * progress;
        return SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppBreakpoints.maxContentWidth + padding * 2,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  padding,
                  4 + 12 * progress,
                  padding,
                  scrollBottomPadding,
                ),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (state.bannerVisible) ...[
                        PartnerSyncBanner(
                          onDismiss: () {
                            onAction(const HomeAction.dismissBanner());
                          },
                        ),
                        SizedBox(height: gap),
                      ],
                      // position 순서를 행 단위로 유지하여 넓은 화면에서도 읽는 순서가 바뀌지 않는다.
                      for (
                        var start = 0;
                        start < configs.length;
                        start += columns
                      ) ...[
                        if (start > 0) SizedBox(height: gap),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (
                              var column = 0;
                              column < columns;
                              column++
                            ) ...[
                              if (column > 0) SizedBox(width: gap),
                              Expanded(
                                child: start + column < configs.length
                                    ? HomeWidgetWrapper(
                                        key: ValueKey(
                                          configs[start + column].id,
                                        ),
                                        type: configs[start + column].type,
                                        state: state,
                                        onAction: onAction,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ],
                        ),
                      ],
                      const SizedBox(height: 24),
                      WidgetEditButton(
                        onPressed: () {
                          onAction(const HomeAction.editWidgetsRequested());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
