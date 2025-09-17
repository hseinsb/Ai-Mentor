import 'package:freezed_annotation/freezed_annotation.dart';

part 'guide_model.freezed.dart';
part 'guide_model.g.dart';

@freezed
class GuideModel with _$GuideModel {
  const factory GuideModel({
    required String id,
    required String phase, // 'investigator', 'communicator', 'decision_maker'
    required int order,
    required String title,
    required String mdContent,
    @Default(true) bool free,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GuideModel;

  factory GuideModel.fromJson(Map<String, dynamic> json) => _$GuideModelFromJson(json);
}

@freezed
class GuideProgressModel with _$GuideProgressModel {
  const factory GuideProgressModel({
    required String id,
    required String uid,
    required String guideId,
    @Default(false) bool completed,
    DateTime? completedTs,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GuideProgressModel;

  factory GuideProgressModel.fromJson(Map<String, dynamic> json) => _$GuideProgressModelFromJson(json);
}
