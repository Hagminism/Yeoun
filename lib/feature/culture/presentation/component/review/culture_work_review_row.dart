import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../domain/model/culture_member.dart';
import '../../../domain/model/culture_review.dart';
import '../../../domain/model/culture_work.dart';

class CultureWorkReviewRow extends StatelessWidget {
  final CultureMember member;
  final String activeMemberId;
  final CultureWork work;

  const CultureWorkReviewRow({
    super.key,
    required this.member,
    required this.activeMemberId,
    required this.work,
  });

  @override
  Widget build(BuildContext context) {
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
                      color: AppColors.coralDeep,
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

  String _formatDate(DateTime date) =>
      '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
}
