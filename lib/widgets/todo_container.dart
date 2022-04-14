import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/bloc/app_bloc.dart';
import 'package:todo_app/models/todo_model.dart';

class ToDoContainer extends StatelessWidget {
  const ToDoContainer({Key? key, required this.todo}) : super(key: key);
  final ToDo todo;

  @override
  Widget build(BuildContext context) {
    const containerHeight = 50.0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white12, borderRadius: BorderRadius.circular(30.0)),
          width: MediaQuery.of(context).size.width,
          height: containerHeight,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: todo.customColor),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      todo.todo,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              todo.isDone
                  ? IsDoneContainer(
                      isDoneColor: Colors.green,
                      toDo: todo,
                    )
                  : IsDoneContainer(
                      isDoneColor: Colors.red,
                      toDo: todo,
                    ),
            ],
          )),
    );
  }
}

class IsDoneContainer extends ToDoContainer {
  final Color isDoneColor;
  final ToDo toDo;
  const IsDoneContainer({
    Key? key,
    required this.isDoneColor,
    required this.toDo,
  }) : super(todo: toDo);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        context.read<AppBloc>().add(IsDoneTapped(toDo: toDo));
      }),
      child: Container(
        child: const Icon(
          Icons.done,
          color: Colors.white70,
          size: 29.0,
        ),
        height: 50,
        width: 54.0,
        decoration: BoxDecoration(
          color: isDoneColor,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
