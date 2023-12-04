// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as String,
    name: json['name'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    added_admin: json['added_admin'] == null
        ? null
        : Admin.fromJson(json['added_admin'] as Map<String, dynamic>),
    updated_admin: json['updated_admin'] == null
        ? null
        : Admin.fromJson(json['updated_admin'] as Map<String, dynamic>),
    quotes_count: json['quotes_count'] as int,
    quotes: (json['quotes'] as List)
        ?.map(
            (e) => e == null ? null : Quote.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'added_admin': instance.added_admin?.toJson(),
      'updated_admin': instance.updated_admin?.toJson(),
      'quotes_count': instance.quotes_count,
      'quotes': instance.quotes?.map((e) => e?.toJson())?.toList(),
    };
