import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../domain/model/culture_member.dart';
import '../../domain/model/culture_review.dart';
import '../../domain/model/culture_work.dart';
import '../screen/culture_action.dart';
import 'culture_action_target.dart';
import 'culture_artwork_view.dart';

class CultureWorkCard extends StatelessWidget {
  final CultureWork work;
  final List<CultureMember> members;
  final String activeMemberId;
  final void Function(CultureAction action) onAction;

  const CultureWorkCard({
    super.key,
    required this.work,
    required this.members,
    required this.activeMemberId,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final CultureReview? myReview = work.reviewFor(activeMemberId);
    final double? averageRating = work.averageRating;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.borderSoft),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CultureArtworkView(
                  artworkBase64: work.artworkBase64,
                  artworkAsset: work.artworkAsset,
                  kind: work.kind,
                  width: 76,
                  height: 100,
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          work.kind.label,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.cultureText,
                            letterSpacing: .5,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          work.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.heading.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 19,
                              color: averageRating == null
                                  ? AppColors.disabledText
                                  : AppColors.cultureText,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              averageRating?.toStringAsFixed(1) ?? '—',
                              style: AppTextStyles.heading.copyWith(
                                fontSize: 21,
                                color: AppColors.ink,
                                fontFeatures: const <FontFeature>[
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                '공간 평균 · ${work.reviews.length}명',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.secondaryText,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          myReview == null
                              ? '아직 내 감상을 남기지 않았어요.'
                              : '내 평점 ${myReview.rating.toStringAsFixed(1)} · ${_formatDate(myReview.reviewedAt)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Divider(height: 1, color: AppColors.creamDeep),
            ),
            for (int index = 0; index < members.length; index++) ...[
              if (index > 0) const SizedBox(height: 11),
              _reviewRow(members[index]),
            ],
            const SizedBox(height: 14),
            _reviewAction(myReview != null),
          ],
        ),
      ),
    );
  }

  Widget _reviewRow(CultureMember member) {
    final CultureReview? review = work.reviewFor(member.id);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: member.id == activeMemberId
                ? AppColors.coralSoft
                : AppColors.cream,
            shape: BoxShape.circle,
          ),
          child: Text(
            member.initials,
            style: AppTextStyles.caption.copyWith(
              color: member.id == activeMemberId
                  ? AppColors.coralDeep
                  : AppColors.bodyText,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    member.name,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (review != null) ...[
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.cultureText,
                      size: 15,
                    ),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: AppTextStyles.small.copyWith(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatDate(review.reviewedAt),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.disabledText,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 3),
              Text(
                review == null
                    ? '아직 감상을 남기지 않았어요.'
                    : review.review.isEmpty
                    ? '평점만 남겼어요.'
                    : review.review,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body.copyWith(
                  color: review == null
                      ? AppColors.disabledText
                      : AppColors.bodyText,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reviewAction(bool hasReview) {
    return CultureActionTarget(
      semanticLabel: hasReview ? '내 감상 수정하기' : '내 감상 남기기',
      onActivate: () => onAction(CultureAction.workEditRequested(work.id)),
      borderRadius: BorderRadius.circular(11),
      child: Container(
        constraints: const BoxConstraints(minHeight: 42),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: hasReview ? AppColors.cream : AppColors.coralDeep,
          border: hasReview ? Border.all(color: AppColors.borderSoft) : null,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Text(
          hasReview ? '내 감상 수정하기' : '내 감상 남기기',
          style: AppTextStyles.small.copyWith(
            color: hasReview ? AppColors.ink : AppColors.surface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
}
