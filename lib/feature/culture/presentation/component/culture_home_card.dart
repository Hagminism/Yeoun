import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../../ui/presentation/component/app_card_surface.dart';
import '../screen/culture_state.dart';
import '../screen/culture_view_model.dart';
import 'culture_action_target.dart';
import 'culture_artwork_view.dart';

class CultureHomeCard extends ConsumerWidget {
  final void Function() onOpen;

  const CultureHomeCard({super.key, required this.onOpen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CultureState state = ref.watch(cultureViewModelProvider);
    final work = state.works.isEmpty ? null : state.works.first;

    return AppCardSurface(
      minHeight: 156,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '문화 기록장',
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 15),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.apricotAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'CULTURE',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.cultureText,
                    fontSize: 9,
                    letterSpacing: .6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CultureActionTarget(
            semanticLabel: '문화 기록장 열기',
            borderRadius: BorderRadius.circular(12),
            onActivate: onOpen,
            child: Container(
              constraints: const BoxConstraints(minHeight: 85),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.cream,
                border: Border.all(color: AppColors.borderSoft),
                borderRadius: BorderRadius.circular(12),
              ),
              child: work == null
                  ? Row(
                      children: [
                        const Icon(
                          Icons.auto_stories_rounded,
                          color: AppColors.cultureText,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '좋아한 작품과 감상을 모아보세요.',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.bodyText,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.secondaryText,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        CultureArtworkView(
                          artworkBase64: work.artworkBase64,
                          artworkAsset: work.artworkAsset,
                          kind: work.kind,
                          width: 48,
                          height: 64,
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                work.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.cardBody.copyWith(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 16,
                                    color: AppColors.cultureText,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    work.averageRating?.toStringAsFixed(1) ??
                                        '—',
                                    style: AppTextStyles.badge.copyWith(
                                      color: AppColors.ink,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${work.reviews.length}개의 감상',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                work.reviews.isEmpty
                                    ? '첫 감상을 기다리고 있어요.'
                                    : work.reviews.last.review.isEmpty
                                    ? '평점으로 남긴 감상'
                                    : work.reviews.last.review,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.small,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            state.works.isEmpty
                ? '기억하고 싶은 작품을 기록해 보세요.'
                : '작품 ${state.works.length}개 · 감상을 모아보기',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
