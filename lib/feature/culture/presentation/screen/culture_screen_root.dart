import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/routing/routes.dart';
import 'culture_action.dart';
import 'culture_event.dart';
import 'culture_screen.dart';
import 'culture_view_model.dart';

class CultureScreenRoot extends ConsumerStatefulWidget {
  const CultureScreenRoot({super.key});

  @override
  ConsumerState<CultureScreenRoot> createState() => _CultureScreenRootState();
}

class _CultureScreenRootState extends ConsumerState<CultureScreenRoot> {
  StreamSubscription<CultureEvent>? _eventSubscription;

  @override
  void initState() {
    super.initState();
    final CultureViewModel viewModel = ref.read(
      cultureViewModelProvider.notifier,
    );
    _eventSubscription = viewModel.eventStream.listen(_handleEvent);
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CultureViewModel viewModel = ref.read(
      cultureViewModelProvider.notifier,
    );
    return CultureScreen(
      state: ref.watch(cultureViewModelProvider),
      onAction: (CultureAction action) {
        switch (action) {
          case CultureNavigateBackRequested():
          case CultureMemberSelected():
          case CultureWorkCreationRequested():
          case CultureWorkEditRequested():
          case CultureEditorClosed():
          case CultureArtworkPickRequested():
          case CultureArtworkPicked():
          case CultureArtworkPickCancelled():
          case CultureArtworkPickFailed():
          case CultureWorkSaved():
            viewModel.onAction(action);
        }
      },
    );
  }

  Future<void> _handleEvent(CultureEvent event) async {
    if (!mounted) return;
    final CultureViewModel viewModel = ref.read(
      cultureViewModelProvider.notifier,
    );
    switch (event) {
      case CultureNavigateBack():
        context.go(Routes.home);
      case CulturePickArtwork():
        await _pickArtwork(viewModel);
    }
  }

  Future<void> _pickArtwork(CultureViewModel viewModel) async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (!mounted) return;
      if (image == null) {
        viewModel.onAction(const CultureAction.artworkPickCancelled());
        return;
      }
      final List<int> bytes = await image.readAsBytes();
      if (!mounted) return;
      viewModel.onAction(CultureAction.artworkPicked(base64Encode(bytes)));
    } catch (_) {
      if (!mounted) return;
      viewModel.onAction(
        const CultureAction.artworkPickFailed('이미지를 불러오지 못했어요. 다시 선택해 주세요.'),
      );
    }
  }
}
