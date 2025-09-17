import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
class NoteModel with _$NoteModel {
  const factory NoteModel({
    required String id,
    required String uid,
    required String profileId,
    required String text,
    @Default('😐') String mood,
    MediaModel? media,
    SentimentModel? sentiment,
    @Default([]) List<String> tags,
    required DateTime ts,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) => _$NoteModelFromJson(json);
}

@freezed
class MediaModel with _$MediaModel {
  const factory MediaModel({
    String? storagePath,
    String? thumbUrl,
  }) = _MediaModel;

  factory MediaModel.fromJson(Map<String, dynamic> json) => _$MediaModelFromJson(json);
}

@freezed
class SentimentModel with _$SentimentModel {
  const factory SentimentModel({
    @Default(0.0) double pos,
    @Default(0.0) double neg,
    @Default(0.0) double neu,
  }) = _SentimentModel;

  factory SentimentModel.fromJson(Map<String, dynamic> json) => _$SentimentModelFromJson(json);
}
