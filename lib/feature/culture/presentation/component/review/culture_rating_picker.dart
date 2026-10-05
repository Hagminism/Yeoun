import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../interaction/culture_action_target.dart';

class CultureRatingPicker extends StatelessWidget {
  final double? rating;
  final void Function(double value) onChanged;

  const CultureRatingPicker({
    super.key,
    required this.rating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final String score = rating?.toStringAsFixed(1) ?? '—';
    return Semantics(
      slider: true,
      label: '10점 만점 평점',
      value: rating == null ? '선택하지 않음' : '$score점',
      increasedValue: rating == null
          ? '0.5점'
          : '${(rating! + .5).clamp(.5, 10).toStringAsFixed(1)}점',
      decreasedValue: rating == null
          ? '선택하지 않음'
          : '${(rating! - .5).clamp(.5, 10).toStringAsFixed(1)}점',
      onIncrease: () {
        onChanged(((rating ?? 0) + .5).clamp(.5, 10).toDouble());
      },
      onDecrease: () {
        if (rating != null) {
          onChanged((rating! - .5).clamp(.5, 10).toDouble());
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '나의 평점',
                style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
              ),
              const SizedBox(width: 8),
              Text(
                '0.5 단위로 선택',
                style: AppTextStyles.small.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              const Spacer(),
              Text(
                score,
                style: AppTextStyles.heading.copyWith(
                  fontSize: 22,
                  color: rating == null
                      ? AppColors.disabledText
                      : AppColors.cultureText,
                  fontFeatures: const <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
              Text(
                ' / 10',
                style: AppTextStyles.small.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.generate(5, (int index) {
              final double fill = rating == null
                  ? 0
                  : (rating! / 2 - index).clamp(0, 1).toDouble();

              return CultureActionTarget(
                semanticLabel: '별점 영역 선택',
                selected: fill > 0,
                onActivate: () => onChanged((index * 2 + 1).toDouble()),
                onTapUp: (TapUpDetails details) {
                  final double step = (details.localPosition.dx / 48 * 4)
                      .ceilToDouble()
                      .clamp(1, 4)
                      .toDouble();
                  final double value = index * 2 + step * .5;
                  onChanged(value);
                },
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 48,
                  height: 44,
                  child: Center(
                    child: SizedBox(
                      width: 34,
                      height: 34,
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.borderSoft,
                            size: 34,
                          ),
                          ClipRect(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: fill,
                              child: const SizedBox(
                                width: 34,
                                child: Icon(
                                  Icons.star_rounded,
                                  color: AppColors.cultureText,
                                  size: 34,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
