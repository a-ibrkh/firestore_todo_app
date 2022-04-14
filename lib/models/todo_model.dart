import 'dart:convert';

import 'package:flutter/material.dart';

class ToDo {
  String todo;
  Color? customColor;
  bool isDone;
  ToDo({
    required this.todo,
    required this.customColor,
    required this.isDone,
  });

  ToDo copyWith({
    String? todo,
    Color? customColor,
    bool? isDone,
  }) {
    return ToDo(
      todo: todo ?? this.todo,
      customColor: customColor ?? this.customColor,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'todo': todo,
      'customColor': customColor!.value,
      'isDone': isDone,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      todo: map['todo'] ?? '',
      customColor: Color(map['customColor']),
      isDone: map['isDone'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(String source) => ToDo.fromMap(json.decode(source));

  @override
  String toString() => 'ToDo(todo: $todo, customColor: $customColor, isDone: $isDone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ToDo &&
      other.todo == todo &&
      other.customColor == customColor &&
      other.isDone == isDone;
  }

  @override
  int get hashCode => todo.hashCode ^ customColor.hashCode ^ isDone.hashCode;
}
