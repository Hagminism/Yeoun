import 'package:flutter/material.dart';
import '../component/bottom_app_bar/app_bottom_app_bar.dart';
import '../component/navigation_rail/app_navigation_rail.dart';
import '../responsive/app_breakpoints.dart';

class AppShell extends StatelessWidget {
  final Widget header;
  final Widget body;
  final void Function(int) onNavigationSelected;

  const AppShell({
    super.key,
    required this.header,
    required this.body,
    required this.onNavigationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final desktop = constraints.maxWidth >= AppBreakpoints.navigationEnd;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: desktop ? 1 : 0),
          duration: const Duration(milliseconds: 220),
          builder: (BuildContext context, double progress, Widget? child) {
            return Scaffold(
              body: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    if (progress > 0)
                      ClipRect(
                        child: SizedBox(
                          width: 88 * progress,
                          child: OverflowBox(
                            minWidth: 88,
                            maxWidth: 88,
                            alignment: Alignment.centerLeft,
                            child: Opacity(
                              opacity: progress,
                              child: IgnorePointer(
                                ignoring: progress < .5,
                                child: AppNavigationRail(
                                  onSelected: onNavigationSelected,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Column(
                        children: [
                          header,
                          Expanded(child: body),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: progress < 1
                  ? SafeArea(
                      top: false,
                      child: ClipRect(
                        child: SizedBox(
                          height: 65 * (1 - progress),
                          child: OverflowBox(
                            minHeight: 65,
                            maxHeight: 65,
                            alignment: Alignment.bottomCenter,
                            child: Opacity(
                              opacity: 1 - progress,
                              child: IgnorePointer(
                                ignoring: progress >= .5,
                                child: AppBottomAppBar(
                                  onSelected: onNavigationSelected,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}
