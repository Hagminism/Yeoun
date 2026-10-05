import 'package:flutter/material.dart';
import 'package:yeoun/ui/app_assets.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../../../domain/model/culture_kind.dart';
import '../../../domain/model/culture_review.dart';
import '../../../domain/model/culture_work.dart';
import '../../screen/culture_action.dart';
import '../artwork/culture_artwork_view.dart';
import '../date_picker/culture_date_picker.dart';
import '../interaction/culture_action_target.dart';
import '../review/culture_rating_picker.dart';
import 'culture_kind_option.dart';

class CultureEditorPanel extends StatefulWidget {
  final CultureWork? work;
  final CultureReview? existingReview;
  final String pendingArtworkBase64;
  final String? message;
  final bool isPickingArtwork;
  final String memberName;
  final void Function(CultureAction action) onAction;

  const CultureEditorPanel({
    super.key,
    required this.work,
    required this.existingReview,
    required this.pendingArtworkBase64,
    required this.message,
    required this.isPickingArtwork,
    required this.memberName,
    required this.onAction,
  });

  @override
  State<CultureEditorPanel> createState() => _CultureEditorPanelState();
}

class _CultureEditorPanelState extends State<CultureEditorPanel> {
  late String _title;
  late String _review;
  late CultureKind _kind;
  late DateTime _reviewedAt;
  double? _rating;
  String? _validationMessage;

  @override
  void initState() {
    super.initState();
    _title = widget.work?.title ?? '';
    _review = widget.existingReview?.review ?? '';
    _kind = widget.work?.kind ?? CultureKind.movie;
    _rating = widget.existingReview?.rating.roundToDouble();
    _reviewedAt =
        widget.existingReview?.reviewedAt ?? DateUtils.dateOnly(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final CultureWork? work = widget.work;
    final String artworkBase64 = widget.pendingArtworkBase64.isNotEmpty
        ? widget.pendingArtworkBase64
        : work?.artworkBase64 ?? '';

    return AppCardSurface(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      radius: 16,
      offset: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      work == null ? '새로운 작품' : '감상 다시 남기기',
                      style: AppTextStyles.heading.copyWith(
                        height: 1.3,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.memberName}님의 감상은 이 작품에 한 번만 남길 수 있어요.',
                      style: AppTextStyles.small.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              CultureActionTarget(
                semanticLabel: '작성 닫기',
                borderRadius: BorderRadius.circular(18),
                onActivate: () =>
                    widget.onAction(const CultureAction.editorClosed()),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.secondaryText,
                    size: 19,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text('작품 종류', style: AppTextStyles.cardTitle),
          const SizedBox(height: 9),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: CultureKind.values
                .map(
                  (CultureKind kind) => CultureKindOption(
                    kind: kind,
                    selected: _kind == kind,
                    onSelected: () {
                      setState(() {
                        _kind = kind;
                      });
                    },
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          TextFormField(
            initialValue: _title,
            onChanged: (String value) => _title = value,
            textCapitalization: TextCapitalization.sentences,
            decoration: _inputDecoration(hint: '기억하고 싶은 작품을 적어주세요'),
            style: AppTextStyles.body.copyWith(color: AppColors.ink),
          ),
          const SizedBox(height: 15),
          Text('대표 이미지 · 선택', style: AppTextStyles.cardTitle),
          const SizedBox(height: 8),
          Row(
            children: [
              CultureArtworkView(
                artworkBase64: artworkBase64,
                artworkAsset: work?.artworkAsset ?? '',
                kind: _kind,
                width: 58,
                height: 76,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CultureActionTarget(
                      semanticLabel: widget.isPickingArtwork
                          ? '이미지 불러오는 중'
                          : '대표 이미지 선택',
                      borderRadius: BorderRadius.circular(14),
                      onActivate: widget.isPickingArtwork
                          ? null
                          : () => widget.onAction(
                              const CultureAction.artworkPickRequested(),
                            ),
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 44),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cream,
                          border: Border.all(color: AppColors.borderSoft),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppAssets.camera3d,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.isPickingArtwork
                                  ? '사진을 불러오는 중'
                                  : '이미지 고르기',
                              style: AppTextStyles.small.copyWith(
                                color: AppColors.ink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '작품을 떠올릴 수 있는 사진 한 장을 골라주세요.',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.message != null) ...[
            const SizedBox(height: 8),
            Text(
              widget.message!,
              style: AppTextStyles.small.copyWith(color: AppColors.coralDeep),
            ),
          ],
          const SizedBox(height: 19),
          CultureRatingPicker(
            rating: _rating,
            onChanged: (double value) {
              setState(() {
                _rating = value;
                _validationMessage = null;
              });
            },
          ),
          const SizedBox(height: 15),
          CultureDatePicker(
            selectedDate: _reviewedAt,
            onChanged: (DateTime date) {
              setState(() {
                _reviewedAt = date;
              });
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            initialValue: _review,
            onChanged: (String value) => _review = value,
            maxLines: 4,
            minLines: 3,
            maxLength: 1000,
            textCapitalization: TextCapitalization.sentences,
            decoration: _inputDecoration(
              hint: '이 작품을 보고 느낀 점을 남겨보세요',
            ).copyWith(alignLabelWithHint: true),
            style: AppTextStyles.body.copyWith(
              color: AppColors.ink,
              height: 1.55,
            ),
          ),
          if (_validationMessage != null) ...[
            const SizedBox(height: 3),
            Text(
              _validationMessage!,
              style: AppTextStyles.small.copyWith(color: AppColors.coralDeep),
            ),
          ],
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CultureActionTarget(
                  semanticLabel: '취소',
                  onActivate: () =>
                      widget.onAction(const CultureAction.editorClosed()),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(minHeight: 48),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      border: Border.all(color: AppColors.borderSoft),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      '취소',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: CultureActionTarget(
                  semanticLabel: '내 감상 저장',
                  onActivate: _rating != null ? _save : null,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(minHeight: 48),
                    decoration: BoxDecoration(
                      color: _rating != null
                          ? AppColors.coralDeep
                          : AppColors.disabledControl,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '내 감상 저장',
                      style: AppTextStyles.body.copyWith(
                        color: _rating != null
                            ? AppColors.surface
                            : AppColors.disabledText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.small.copyWith(
        color: AppColors.disabledText,
        fontSize: 14,
      ),
      labelStyle: AppTextStyles.small.copyWith(color: AppColors.secondaryText),
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.all(16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.borderSoft),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.coralDeep, width: 1.4),
      ),
      counterStyle: AppTextStyles.caption,
    );
  }

  void _save() {
    if (_title.trim().isEmpty) {
      setState(() {
        _validationMessage = '작품명을 입력해 주세요.';
      });
      return;
    }
    final double? selectedRating = _rating;
    if (selectedRating == null) {
      setState(() {
        _validationMessage = '평점을 선택해 주세요.';
      });
      return;
    }
    widget.onAction(
      CultureAction.workSaved(
        workId: widget.work?.id,
        kind: _kind,
        title: _title,
        rating: selectedRating,
        review: _review,
        reviewedAt: _reviewedAt,
      ),
    );
  }
}
