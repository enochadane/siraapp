import 'dart:convert';

import "package:meta/meta.dart";
import 'package:equatable/equatable.dart';

class JobCategory extends Equatable {
  final String id;
  final String name;
  final String description;
  JobCategory({
    this.id,
    @required this.name,
    @required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
    };
  }

  factory JobCategory.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return JobCategory(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory JobCategory.fromJson(String source) =>
      JobCategory.fromMap(json.decode(source));

  @override
  List<Object> get props => [id, name,description];
}
