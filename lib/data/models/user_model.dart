import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    @Default('') String displayName,
    @Default('') String avatarUrl,
    int? age,
    String? gender,
    String? country,
    @Default('balanced') String tonePref,
    @Default('free') String plan,
    required UsageModel usage,
    required CapsModel caps,
    required CommitmentsModel commitments,
    required NotificationPrefsModel notificationPrefs,
    required PrivacyModel privacy,
    @Default(false) bool quickWinDone,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@freezed
class UsageModel with _$UsageModel {
  const factory UsageModel({
    @Default(0) int dailyRepliesUsed,
    @Default(0) int monthlyRepliesUsed,
    DateTime? lastResetTs,
  }) = _UsageModel;

  factory UsageModel.fromJson(Map<String, dynamic> json) => _$UsageModelFromJson(json);
}

@freezed
class CapsModel with _$CapsModel {
  const factory CapsModel({
    @Default(3) int dailyLimit,
    @Default(10) int monthlyLimit,
  }) = _CapsModel;

  factory CapsModel.fromJson(Map<String, dynamic> json) => _$CapsModelFromJson(json);
}

@freezed
class CommitmentsModel with _$CommitmentsModel {
  const factory CommitmentsModel({
    @Default(false) bool dailyCheckinsEnabled,
  }) = _CommitmentsModel;

  factory CommitmentsModel.fromJson(Map<String, dynamic> json) => _$CommitmentsModelFromJson(json);
}

@freezed
class NotificationPrefsModel with _$NotificationPrefsModel {
  const factory NotificationPrefsModel({
    @Default(true) bool dailyFocusEnabled,
    @Default(true) bool eveningReflectionEnabled,
    @Default(true) bool reEngagementEnabled,
    @Default('09:00') String dailyFocusTime,
    @Default('21:00') String eveningReflectionTime,
  }) = _NotificationPrefsModel;

  factory NotificationPrefsModel.fromJson(Map<String, dynamic> json) => _$NotificationPrefsModelFromJson(json);
}

@freezed
class PrivacyModel with _$PrivacyModel {
  const factory PrivacyModel({
    @Default(false) bool sensitiveLocalOnly,
  }) = _PrivacyModel;

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => _$PrivacyModelFromJson(json);
}
