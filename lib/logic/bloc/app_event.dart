part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class ColorSelected extends AppEvent {
  bool isColorSelected;
  Color? selectedColor;
  ColorSelected({
    required this.isColorSelected,
    this.selectedColor,
  });
}

class AddTodo extends AppEvent {
  ToDo toDo;

  AddTodo({required this.toDo});
}

class IsDoneTapped extends AppEvent {
   ToDo toDo;
  IsDoneTapped({
    required this.toDo,
  });
}
