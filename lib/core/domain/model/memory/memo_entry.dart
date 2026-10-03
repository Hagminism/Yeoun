import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo_entry.freezed.dart';
part 'memo_entry.g.dart';

@freezed
abstract class MemoEntry with _$MemoEntry {
  const factory MemoEntry({
    required String title,
    required String content,
    required String dateLabel,
  }) = _MemoEntry;

  factory MemoEntry.fromJson(Map<String, dynamic> json) =>
      _$MemoEntryFromJson(json);
}
