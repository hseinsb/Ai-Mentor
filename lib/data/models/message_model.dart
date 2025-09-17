import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String uid,
    required String profileId,
    required String role, // 'user', 'assistant', 'system'
    required String content,
    @Default(0) int tokenEstimate,
    required DateTime ts,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}
