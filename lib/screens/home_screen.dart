import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/widgets/color_container.dart';
import 'package:todo_app/widgets/todo_container.dart';

import '../logic/bloc/app_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Qaydnoma",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Column(children: [
        Expanded(
          flex: 1,
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("todolist").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData || snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Object?>? documentSnapshot =
                          snapshot.data?.docs[index];
                      Map<String, dynamic> map = {
                        "todo": documentSnapshot != null
                            ? documentSnapshot["todo"]
                            : "",
                        "customColor": documentSnapshot != null
                            ? documentSnapshot["customColor"]
                            : 1234567890,
                        "isDone": documentSnapshot != null
                            ? documentSnapshot["isDone"]
                            : ""
                      };
                      final todo = ToDo.fromMap(map);
                      return ToDoContainer(todo: todo);
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text("Something went wrong, please try again"));
                } else {
                  return Center(
                      child: const CircularProgressIndicator.adaptive());
                }
              }),
        ),
        BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return Container(
              color: Colors.white,
              height: 160.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ColorContainer(
                          customColor: Colors.green,
                          customOnTap: () {
                            context.read<AppBloc>().add(
                                  ColorSelected(
                                    isColorSelected: true,
                                    selectedColor: Colors.green,
                                  ),
                                );
                          },
                        ),
                        ColorContainer(
                          customColor: Colors.pink,
                          customOnTap: () {
                            context.read<AppBloc>().add(
                                  ColorSelected(
                                    isColorSelected: true,
                                    selectedColor: Colors.pink,
                                  ),
                                );
                          },
                        ),
                        ColorContainer(
                          customColor: Colors.yellow,
                          customOnTap: () {
                            context.read<AppBloc>().add(
                                  ColorSelected(
                                    isColorSelected: true,
                                    selectedColor: Colors.yellow,
                                  ),
                                );
                          },
                        ),
                        ColorContainer(
                          customColor: Colors.blue,
                          customOnTap: () {
                            context.read<AppBloc>().add(
                                  ColorSelected(
                                    isColorSelected: true,
                                    selectedColor: Colors.blue,
                                  ),
                                );
                          },
                        ),
                        ColorContainer(
                          customColor: Colors.orange,
                          customOnTap: () {
                            context.read<AppBloc>().add(
                                  ColorSelected(
                                    isColorSelected: true,
                                    selectedColor: Colors.orange,
                                  ),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 18.0, left: 18.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<AppBloc, AppState>(
                            builder: (context, state) {
                              if (state is AppInitial) {
                                print(state.isColorSelected.toString());
                                print(state.selectedColor.toString());
                                return TextField(
                                  controller: textEditingController,
                                  enabled: state.isColorSelected ? true : false,
                                  decoration: InputDecoration(
                                    hintText: state.isColorSelected
                                        ? " Yozing "
                                        : " Rangni tanlang! ",
                                    hintStyle: const TextStyle(
                                      backgroundColor: Colors.red,
                                      color: Colors.white,
                                      fontSize: 26.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          style: BorderStyle.solid,
                                          color: Colors.blue,
                                          width: 2.0),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            if (state is AppInitial) {
                              print("selected color " +
                                  state.selectedColor.toString());
                              if (textEditingController.text.isNotEmpty) {
                                context.read<AppBloc>().add(
                                      AddTodo(
                                        toDo: ToDo(
                                          customColor: state.selectedColor,
                                          isDone: false,
                                          todo: textEditingController.text,
                                        ),
                                      ),
                                    );
                              }
                              textEditingController.clear();
                            }
                          }),
                          child: Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}
