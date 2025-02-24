import 'package:dartz/dartz.dart';
import 'package:flutter_firebase_ddd/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/failures.dart';
import '../core/value_object.dart';

part 'todo_item.freezed.dart';

@freezed
abstract class TodoItem implements _$TodoItem {
  const TodoItem._();

  const factory TodoItem({
    required UniqueId id,
    required TodoName name,
    required bool done,
  }) = _TodoItem;

  factory TodoItem.empty() => TodoItem(
        id: UniqueId(),
        name: TodoName(''),
        done: false,
      );

  Option<ValueFailure<dynamic>> get failureOption {
    return name.value.fold((f) => some(f), (_) => none());
  }
}
