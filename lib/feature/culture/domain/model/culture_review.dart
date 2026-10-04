import 'package:freezed_annotation/freezed_annotation.dart';

part 'culture_review.freezed.dart';
part 'culture_review.g.dart';

@freezed
abstract class CultureReview with _$CultureReview {
  const factory CultureReview({
    required String memberId,
    required String memberName,
    required double rating,
    required String review,
    required DateTime reviewedAt,
  }) = _CultureReview;

  factory CultureReview.fromJson(Map<String, dynamic> json) =>
      _$CultureReviewFromJson(json);
}
