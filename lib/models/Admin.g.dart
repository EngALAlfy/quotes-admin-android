// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) {
  return Admin(
    id: json['id'] as String,
    username: json['username'] as String,
    roles: (json['roles'] as List)?.map((e) => e as String)?.toList(),
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    added_admin: json['added_admin'] == null
        ? null
        : Admin.fromJson(json['added_admin'] as Map<String, dynamic>),
    updated_admin: json['updated_admin'] == null
        ? null
        : Admin.fromJson(json['updated_admin'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'roles': instance.roles,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'added_admin': instance.added_admin?.toJson(),
      'updated_admin': instance.updated_admin?.toJson(),
    };
