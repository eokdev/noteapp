import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:noteapp/models/categoryModel.dart';

class NoteDataModel {
  final int? id;
  final Color? colors;
  final String? title;
  final String? content;
  final List<dynamic>? body;
  final CategoryModel? category;
  final DateTime? creationDate;
  final DateTime? modifiedDate;
  NoteDataModel({
    this.id,
    this.colors,
    this.title,
    this.content,
    this.body,
    this.category,
    required this.creationDate,
    required this.modifiedDate,
  });

  NoteDataModel copyWith({
    int? id,
    Color? colors,
    String? title,
    String? content,
    List<dynamic>? body,
    CategoryModel? category,
    DateTime? creationDate,
    DateTime? modifiedDate,
  }) {
    return NoteDataModel(
      id: id ?? this.id,
      colors: colors ?? this.colors,
      title: title ?? this.title,
      content: content ?? this.content,
      body: body ?? this.body,
      category: category ?? this.category,
      creationDate: creationDate ?? this.creationDate,
      modifiedDate: modifiedDate ?? this.modifiedDate,
    );
  }
  String get encodedCategory => json.encode(category?.toMap());

//refer here if having issues with getting notes data
  CategoryModel? get decodedCategory => CategoryModel.fromMap(json.decode(encodedCategory));
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'colors': colors?.value,
      'title': title,
      'content': content,
      'body': json.encode(body),
      'category': encodedCategory,
      'creationDate': creationDate?.millisecondsSinceEpoch,
      'modifiedDate': modifiedDate?.millisecondsSinceEpoch,
    };
  }

  factory NoteDataModel.fromMap(Map<String, dynamic> map) {
    return NoteDataModel(
      id: map['id']?.toInt(),
      colors: map['colors'] != null ? Color(map['colors']) : null,
      title: map['title'],
      content: map['content'],
      body: json.decode(map['body']),
      category: jsonDecode(map['category']),
      creationDate: map['creationDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['creationDate']) : null,
      modifiedDate: map['modifiedDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifiedDate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteDataModel.fromJson(String source) => NoteDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NoteDataModel(id: $id, colors: $colors, title: $title, content: $content, body: $body, category: $category, creationDate: $creationDate, modifiedDate: $modifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NoteDataModel &&
      other.id == id &&
      other.colors == colors &&
      other.title == title &&
      other.content == content &&
      listEquals(other.body, body) &&
      other.category == category &&
      other.creationDate == creationDate &&
      other.modifiedDate == modifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      colors.hashCode ^
      title.hashCode ^
      content.hashCode ^
      body.hashCode ^
      category.hashCode ^
      creationDate.hashCode ^
      modifiedDate.hashCode;
  }
}
