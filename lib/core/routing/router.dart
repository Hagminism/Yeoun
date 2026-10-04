import 'package:go_router/go_router.dart';

import '../presentation/screen/app_shell.dart';
import '../../core/domain/model/space/space_widget_type.dart';
import 'routes.dart';
import '../../feature/bucket/presentation/screen/bucket_list_screen_root.dart';
import '../../feature/home/presentation/screen/home_detail_screen_root.dart';
import '../../feature/home/presentation/screen/home_screen_root.dart';
import '../../feature/settings/presentation/screen/settings_screen_root.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) {
                return const HomeScreenRoot();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.memories,
              builder: (context, state) {
                return const HomeDetailScreenRoot(type: SpaceWidgetType.memory);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.bucketList,
              builder: (context, state) {
                return const BucketListScreenRoot();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.timeCapsule,
              builder: (context, state) {
                return const HomeDetailScreenRoot(
                  type: SpaceWidgetType.capsule,
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (context, state) {
                return const SettingsScreenRoot();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
