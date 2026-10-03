import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../core/domain/model/culture/culture_record.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../badge/home_badge.dart';
import '../header/home_card_header.dart';

class CultureCard extends StatelessWidget {
  final CultureRecord record;
  final void Function() onOpen;

  const CultureCard({super.key, required this.record, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      minHeight: 156,
      child: Column(
        children: [
          const HomeCardHeader(
            title: '영화 & 문화 기록장',
            trailing: HomeBadge(
              label: 'CULTURE',
              background: AppColors.apricotAccent,
              foreground: AppColors.cultureText,
            ),
          ),
          const SizedBox(height: 12),
          Material(
            color: AppColors.cream,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.borderSoft),
            ),
            child: InkWell(
              onTap: onOpen,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 64,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderSoft),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          record.posterAsset,
                          fit: BoxFit.cover,
                          semanticLabel: record.title,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            record.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.cardBody.copyWith(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                '⭐️⭐️⭐️⭐️⭐️',
                                style: AppTextStyles.small.copyWith(
                                  color: AppColors.cultureText,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                record.rating.toStringAsFixed(1),
                                style: AppTextStyles.badge.copyWith(
                                  color: AppColors.ink,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '"${record.review}"',
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
          ),
        ],
      ),
    );
  }
}
