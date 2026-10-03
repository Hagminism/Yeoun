import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_entry.freezed.dart';
part 'memory_entry.g.dart';

@freezed
abstract class MemoryEntry with _$MemoryEntry {
  const factory MemoryEntry({
    required String id,
    required String title,
    required String subtitle,
    required String imageAsset,
  }) = _MemoryEntry;

  factory MemoryEntry.fromJson(Map<String, dynamic> json) =>
      _$MemoryEntryFromJson(json);
}
