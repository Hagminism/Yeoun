import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/domain/model/space/space_widget_type.dart';
import '../../screen/home_action.dart';
import '../../screen/home_state.dart';
import '../../../../culture/presentation/component/home/culture_home_card.dart';
import '../../../../general_record/presentation/component/home/general_record_home_card.dart';
import '../../../../general_record/presentation/screen/general_record_view_model.dart';
import '../card/anniversary_card.dart';
import '../card/capsule_entry_card.dart';
import '../card/bucket_entry_card.dart';

class HomeWidgetWrapper extends ConsumerWidget {
  final SpaceWidgetType type;
  final HomeState state;
  final void Function(HomeAction) onAction;

  const HomeWidgetWrapper({
    super.key,
    required this.type,
    required this.state,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (type) {
      SpaceWidgetType.anniversary => AnniversaryCard(
        anniversary: state.anniversary,
        onCalendar: () {
          onAction(HomeAction.detailRequested(type));
        },
      ),
      SpaceWidgetType.capsule => CapsuleEntryCard(
        capsule: state.capsule,
        onOpen: () {
          onAction(HomeAction.detailRequested(type));
        },
      ),
      SpaceWidgetType.bucket => BucketEntryCard(
        items: state.buckets,
        onToggle: (String id) {
          onAction(HomeAction.toggleBucket(id));
        },
        onAdd: () {
          onAction(const HomeAction.addBucketRequested());
        },
        onOpen: () {
          onAction(HomeAction.detailRequested(type));
        },
      ),
      SpaceWidgetType.generalRecord => GeneralRecordHomeCard(
        records: ref.watch(generalRecordViewModelProvider).entries,
        onOpen: () {
          onAction(HomeAction.detailRequested(type));
        },
      ),
      SpaceWidgetType.culture => CultureHomeCard(
        onOpen: () {
          onAction(HomeAction.detailRequested(type));
        },
      ),
    };
  }
}
