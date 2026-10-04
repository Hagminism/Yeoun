import 'package:freezed_annotation/freezed_annotation.dart';

import 'culture_kind.dart';
import 'culture_review.dart';

part 'culture_work.freezed.dart';
part 'culture_work.g.dart';

@freezed
abstract class CultureWork with _$CultureWork {
  const factory CultureWork({
    required String id,
    required CultureKind kind,
    required String title,
    @Default('') String artworkBase64,
    @Default('') String artworkAsset,
    required List<CultureReview> reviews,
  }) = _CultureWork;

  const CultureWork._();

  double? get averageRating {
    if (reviews.isEmpty) return null;
    final double total = reviews.fold<double>(
      0,
      (double sum, CultureReview review) => sum + review.rating,
    );
    return (total / reviews.length * 10).roundToDouble() / 10;
  }

  CultureReview? reviewFor(String memberId) {
    for (final CultureReview review in reviews) {
      if (review.memberId == memberId) return review;
    }
    return null;
  }

  factory CultureWork.fromJson(Map<String, dynamic> json) =>
      _$CultureWorkFromJson(json);
}
