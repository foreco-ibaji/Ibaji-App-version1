import 'package:freezed_annotation/freezed_annotation.dart';


part 'chat.freezed.dart';

part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String id,
    required String message,
    int? created,
    bool? fromUser,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
