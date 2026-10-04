import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/domain/model/space/space_widget_type.dart';
import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../../ui/presentation/component/app_card_surface.dart';
import '../component/detail/home_detail_content.dart';
import 'home_state.dart';

class HomeDetailScreen extends StatelessWidget {
  final SpaceWidgetType type;
  final HomeState state;

  const HomeDetailScreen({super.key, required this.type, required this.state});

  String get _title => switch (type) {
    SpaceWidgetType.memory => '기억들',
    SpaceWidgetType.capsule => '타임캡슐',
    _ => type.label,
  };

  @override
  Widget build(BuildContext context) {
    final scrollBottomPadding = math.max(
      30.0,
      MediaQuery.paddingOf(context).bottom + 16,
    );

    return Column(
      children: [
        Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          color: AppColors.paper,
          child: Text(_title, style: AppTextStyles.header),
        ),
        Expanded(
          child: ColoredBox(
            color: AppColors.paper,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 4, 16, scrollBottomPadding),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: AppCardSurface(
                    child: HomeDetailContent(type: type, state: state),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
