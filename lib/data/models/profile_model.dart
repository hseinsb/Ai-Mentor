import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    required String uid,
    required String name,
    required String knownDuration,
    required String initiationFreq,
    required String convoTreatment,
    required String valuesKnown,
    required String userFeeling,
    required String primaryHelpNeed,
    @Default('active') String status,
    required CompatibilityModel compatibility,
    required PillarsModel pillars,
    @Default([]) List<String> flags,
    @Default([]) List<String> strengths,
    @Default([]) List<TrendDataModel> trend30d,
    NextStepModel? nextStep,
    LastSummaryModel? lastSummary,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
}

@freezed
class CompatibilityModel with _$CompatibilityModel {
  const factory CompatibilityModel({
    @Default(0) int score0to100,
    DateTime? lastScoredTs,
  }) = _CompatibilityModel;

  factory CompatibilityModel.fromJson(Map<String, dynamic> json) => _$CompatibilityModelFromJson(json);
}

@freezed
class PillarsModel with _$PillarsModel {
  const factory PillarsModel({
    @Default(0) int values,
    @Default(0) int emotionalSafety,
    @Default(0) int effortConsistency,
    @Default(0) int consistencyWordsActions,
  }) = _PillarsModel;

  factory PillarsModel.fromJson(Map<String, dynamic> json) => _$PillarsModelFromJson(json);
}

@freezed
class TrendDataModel with _$TrendDataModel {
  const factory TrendDataModel({
    required DateTime day,
    @Default(0) int positives,
    @Default(0) int negatives,
  }) = _TrendDataModel;

  factory TrendDataModel.fromJson(Map<String, dynamic> json) => _$TrendDataModelFromJson(json);
}

@freezed
class NextStepModel with _$NextStepModel {
  const factory NextStepModel({
    required String text,
    DateTime? dueDate,
  }) = _NextStepModel;

  factory NextStepModel.fromJson(Map<String, dynamic> json) => _$NextStepModelFromJson(json);
}

@freezed
class LastSummaryModel with _$LastSummaryModel {
  const factory LastSummaryModel({
    required String short,
    required DateTime ts,
  }) = _LastSummaryModel;

  factory LastSummaryModel.fromJson(Map<String, dynamic> json) => _$LastSummaryModelFromJson(json);
}
