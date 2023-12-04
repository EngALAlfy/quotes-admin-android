import 'package:json_annotation/json_annotation.dart';
import 'package:quotes_admin_app/models/Admin.dart';
import 'package:quotes_admin_app/models/Quote.dart';

part 'Category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  String id;
  String name;
  String createdAt;
  String updatedAt;
  Admin added_admin;
  Admin updated_admin;
  int quotes_count;

  List<Quote> quotes;

  Category({this.id, this.name, this.createdAt, this.updatedAt, this.added_admin,
      this.updated_admin , this.quotes_count , this.quotes});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}