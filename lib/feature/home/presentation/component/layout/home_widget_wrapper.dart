import 'package:flutter/material.dart';
import '../../../../../core/domain/model/space/space_widget_type.dart';
import '../../screen/home_action.dart';
import '../../screen/home_state.dart';
import '../card/anniversary_card.dart';
import '../card/capsule_entry_card.dart';
import '../card/bucket_entry_card.dart';
import '../card/memory_album_card.dart';
import '../card/free_memo_card.dart';
import '../card/culture_card.dart';

class HomeWidgetWrapper extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
      ),
      SpaceWidgetType.memory => MemoryAlbumCard(
        memories: state.memories,
        onOpen: () {
          onAction(HomeAction.detailRequested(type));
        },
      ),
      SpaceWidgetType.memo => FreeMemoCard(
        memo: state.memo,
        count: state.memoCount,
        onWrite: () {
          onAction(const HomeAction.memoRequested());
        },
      ),
      SpaceWidgetType.culture => CultureCard(
        record: state.culture,
        onOpen: () {
          onAction(HomeAction.detailRequested(type));
        },
      ),
    };
  }
}
