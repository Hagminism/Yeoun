import 'package:flutter/material.dart';
import '../../../../core/presentation/screen/app_shell.dart';
import '../../../../ui/app_colors.dart';
import 'home_action.dart';
import 'home_state.dart';
import '../component/header/home_header.dart';
import '../component/layout/home_dashboard_layout.dart';

class HomeScreen extends StatelessWidget {
  final HomeState state;
  final void Function(HomeAction) onAction;

  const HomeScreen({super.key, required this.state, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      onNavigationSelected: (int index) {
        onAction(HomeAction.navigationSelected(index));
      },
      header: HomeHeader(
        title: state.spaceTitle,
        onNewRecord: () {
          onAction(const HomeAction.newRecordRequested());
        },
        onNotifications: () {
          onAction(const HomeAction.notificationsRequested());
        },
        onSettings: () {
          onAction(const HomeAction.settingsRequested());
        },
      ),
      body: ColoredBox(
        color: AppColors.paper,
        child: HomeDashboardLayout(state: state, onAction: onAction),
      ),
    );
  }
}
