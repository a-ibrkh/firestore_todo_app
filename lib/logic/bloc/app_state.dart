part of 'app_bloc.dart';

@immutable
abstract class AppState extends Equatable {}

class AppInitial extends AppState {
  bool isColorSelected;
  Color? selectedColor;
  AppInitial({
    required this.isColorSelected,
    this.selectedColor,
  });

  @override
  List<Object?> get props => [isColorSelected, selectedColor];
}

