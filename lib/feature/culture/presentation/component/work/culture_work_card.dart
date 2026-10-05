import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../../../domain/model/culture_member.dart';
import '../../../domain/model/culture_review.dart';
import '../../../domain/model/culture_work.dart';
import '../../screen/culture_action.dart';
import '../artwork/culture_artwork_view.dart';
import '../interaction/culture_action_target.dart';
import '../review/culture_work_review_row.dart';

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

    return AppCardSurface(
      padding: const EdgeInsets.all(16),
      radius: 16,
      offset: 3,
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
                          color: AppColors.coralDeep,
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
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 19,
                            color: averageRating == null
                                ? AppColors.disabledText
                                : AppColors.coralDeep,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            averageRating?.toStringAsFixed(1) ?? '—',
                            style: AppTextStyles.heading.copyWith(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                              fontFeatures: const <FontFeature>[
                                FontFeature.tabularFigures(),
                              ],
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
            CultureWorkReviewRow(
              member: members[index],
              activeMemberId: activeMemberId,
              work: work,
            ),
          ],
          const SizedBox(height: 14),
          CultureActionTarget(
            semanticLabel: myReview != null ? '내 감상 수정하기' : '내 감상 남기기',
            onActivate: () =>
                onAction(CultureAction.workEditRequested(work.id)),
            borderRadius: BorderRadius.circular(11),
            child: Container(
              constraints: const BoxConstraints(minHeight: 42),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: myReview != null ? AppColors.cream : AppColors.coralDeep,
                border: myReview != null
                    ? Border.all(color: AppColors.borderSoft)
                    : null,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                myReview != null ? '내 감상 수정하기' : '내 감상 남기기',
                style: AppTextStyles.small.copyWith(
                  color: myReview != null ? AppColors.ink : AppColors.surface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
}
