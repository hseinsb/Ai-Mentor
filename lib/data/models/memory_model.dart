import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_model.freezed.dart';
part 'memory_model.g.dart';

@freezed
class MemoryModel with _$MemoryModel {
  const factory MemoryModel({
    required String id,
    required String uid,
    required DateTime date,
    String? title,
    String? text,
    MediaModel? media,
    String? location,
    @Default([]) List<String> tags,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MemoryModel;

  factory MemoryModel.fromJson(Map<String, dynamic> json) => _$MemoryModelFromJson(json);
}

@freezed
class MediaModel with _$MediaModel {
  const factory MediaModel({
    String? storagePath,
    String? thumbUrl,
    String? type, // 'image', 'video'
  }) = _MediaModel;

  factory MediaModel.fromJson(Map<String, dynamic> json) => _$MediaModelFromJson(json);
}
