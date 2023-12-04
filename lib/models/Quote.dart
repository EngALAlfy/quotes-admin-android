import 'package:json_annotation/json_annotation.dart';
import 'package:quotes_admin_app/models/Admin.dart';
import 'package:quotes_admin_app/models/Category.dart';

part 'Quote.g.dart';

@JsonSerializable(explicitToJson: true)
class Quote {
  String id;

  String text;
  Category category;

  List<String> tags;

  String createdAt;
  String updatedAt;
  Admin added_admin;
  Admin updated_admin;

  Quote({this.id, this.text , this.category ,this.tags , this.createdAt, this.updatedAt, this.added_admin,
      this.updated_admin});

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}