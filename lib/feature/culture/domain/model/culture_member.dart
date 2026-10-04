import 'package:freezed_annotation/freezed_annotation.dart';

part 'culture_member.freezed.dart';
part 'culture_member.g.dart';

@freezed
abstract class CultureMember with _$CultureMember {
  const factory CultureMember({
    required String id,
    required String name,
    required String initials,
  }) = _CultureMember;

  factory CultureMember.fromJson(Map<String, dynamic> json) =>
      _$CultureMemberFromJson(json);
}
