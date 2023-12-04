import 'package:json_annotation/json_annotation.dart';

part 'Admin.g.dart';

@JsonSerializable(explicitToJson: true)
class Admin {
  String id;
  String username;
  List<String> roles;

  String createdAt;
  String updatedAt;
  Admin added_admin;
  Admin updated_admin;

  Admin({this.id, this.username , this.roles , this.createdAt, this.updatedAt, this.added_admin,
      this.updated_admin});

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
  Map<String, dynamic> toJson() => _$AdminToJson(this);
}