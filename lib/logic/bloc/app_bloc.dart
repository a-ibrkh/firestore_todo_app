import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/models/todo_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial(isColorSelected: false)) {
    on<AppEvent>((event, emit) {});
    on<ColorSelected>(((event, emit) {
      _colorSelected(event, emit);
    }));
    on<AddTodo>(
      (event, emit) async {
        await _addToDo(event.toDo, event, emit);
      },
    );
    on<IsDoneTapped>(
      (event, emit) async {
        await _isDoneTapped(event.toDo, event, emit);
      },
    );
  }

  void _colorSelected(ColorSelected event, Emitter<AppState> emit) {
    emit(AppInitial(isColorSelected: true, selectedColor: event.selectedColor));
  }

  Future<void> _addToDo(
      ToDo toDo, AddTodo event, Emitter<AppState> emit) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("todolist").doc(toDo.todo);

    await documentReference
        .set(toDo.toMap())
        .whenComplete(() => emit(AppInitial(isColorSelected: false)));
  }

  Future<void> _isDoneTapped(
      ToDo toDo, IsDoneTapped event, Emitter<AppState> emit) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("todolist").doc(toDo.todo);
    Map<String, bool> data = {"isDone": !toDo.isDone};
    await documentReference.update(data);
  }
}
