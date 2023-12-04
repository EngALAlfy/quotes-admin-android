// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) {
  return Quote(
    id: json['id'] as String,
    text: json['text'] as String,
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
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

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'category': instance.category?.toJson(),
      'tags': instance.tags,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'added_admin': instance.added_admin?.toJson(),
      'updated_admin': instance.updated_admin?.toJson(),
    };
