// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatImpl _$$ChatImplFromJson(Map<String, dynamic> json) => _$ChatImpl(
      id: json['id'] as int,
      message: json['message'] as String,
      created: json['created'] as String?,
      fromUser: json['fromUser'] as bool?,
    );

Map<String, dynamic> _$$ChatImplToJson(_$ChatImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'created': instance.created,
      'fromUser': instance.fromUser,
    };
