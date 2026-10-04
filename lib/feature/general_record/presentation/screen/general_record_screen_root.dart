import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/routing/routes.dart';
import '../../domain/model/general_record_photo.dart';
import 'general_record_action.dart';
import 'general_record_event.dart';
import 'general_record_screen.dart';
import 'general_record_view_model.dart';

class GeneralRecordScreenRoot extends ConsumerStatefulWidget {
  const GeneralRecordScreenRoot({super.key});

  @override
  ConsumerState<GeneralRecordScreenRoot> createState() =>
      _GeneralRecordScreenRootState();
}

class _GeneralRecordScreenRootState
    extends ConsumerState<GeneralRecordScreenRoot> {
  StreamSubscription<GeneralRecordEvent>? _eventSubscription;

  @override
  void initState() {
    super.initState();
    final viewModel = ref.read(generalRecordViewModelProvider.notifier);

    _eventSubscription = viewModel.eventStream.listen((event) async {
      if (!mounted) return;

      switch (event) {
        case GeneralRecordSelectPhotos(:final remaining):
          try {
            final files = await ImagePicker().pickMultiImage();
            final photos = <GeneralRecordPhoto>[];
            for (
              var index = 0;
              index < files.length && index < remaining;
              index++
            ) {
              final file = files[index];
              photos.add(
                GeneralRecordPhoto(
                  id: '${DateTime.now().microsecondsSinceEpoch}-$index',
                  fileName: file.name,
                  bytes: await file.readAsBytes(),
                ),
              );
            }
            if (mounted) {
              ref
                  .read(generalRecordViewModelProvider.notifier)
                  .onAction(GeneralRecordAction.photosAdded(photos));
            }
          } on Object {
            if (mounted) {
              ref
                  .read(generalRecordViewModelProvider.notifier)
                  .onAction(
                    const GeneralRecordAction.photosAdded(
                      <GeneralRecordPhoto>[],
                    ),
                  );
            }
          }
      }
    });
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(generalRecordViewModelProvider.notifier);

    return GeneralRecordScreen(
      state: ref.watch(generalRecordViewModelProvider),
      onAction: (GeneralRecordAction action) {
        switch (action) {
          case TapBackButton():
            context.go(Routes.home);
          case GeneralRecordCreateRequested():
          case GeneralRecordEditRequested():
          case GeneralRecordEditorDismissed():
          case GeneralRecordContentChanged():
          case GeneralRecordDateChanged():
          case GeneralRecordCalendarVisibilityChanged():
          case GeneralRecordCalendarMonthChanged():
          case GeneralRecordPhotosAdded():
          case GeneralRecordPhotoRemoved():
          case GeneralRecordViewModeSelected():
          case GeneralRecordSaveRequested():
            viewModel.onAction(action);
          case GeneralRecordPhotoSelectionRequested():
            viewModel.onAction(action);
        }
      },
    );
  }
}
