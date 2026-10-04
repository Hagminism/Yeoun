import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/model/space/space_widget_type.dart';
import 'home_detail_screen.dart';
import 'home_view_model.dart';

class HomeDetailScreenRoot extends ConsumerWidget {
  final SpaceWidgetType type;

  const HomeDetailScreenRoot({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HomeDetailScreen(
      type: type,
      state: ref.watch(homeViewModelProvider),
    );
  }
}
