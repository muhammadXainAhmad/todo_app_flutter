import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Constants/constants.dart';
import 'package:todo_app/Constants/todo.dart';

class MyToDoItem extends StatefulWidget {
  const MyToDoItem({super.key});

  @override
  State<MyToDoItem> createState() => _MyToDoItemState();
}

class _MyToDoItemState extends State<MyToDoItem> {
  final todosList = ToDo.todoList();
  final todoController = TextEditingController();
  String taskTitle = "All Tasks";

  List<ToDo> foundToDo = [];

  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
      runFilter(todoController.text);
    });
  }

  void addToDoItem(String toDo) {
    if (toDo.trim().isEmpty) return;
    setState(() {
      final newItem = (ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
      todosList.insert(0, newItem);
      runFilter(""); // Refresh the displayed list if a search is active
    });
    todoController.clear();
  }

  void runFilter(String searchWord) {
    List<ToDo> results = [];
    if (searchWord.isEmpty) {
      results = todosList;
    } else {
      results =
          todosList
              .where(
                (item) => item.todoText!.toLowerCase().contains(
                  searchWord.toLowerCase(),
                ),
              )
              .toList();
    }
    setState(() {
      foundToDo = results;
    });
  }

  @override
  void initState() {
    foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(
          context,
        ).requestFocus(FocusNode()); // This will unfocus the current focus
      },
      child: Scaffold(
        backgroundColor: bgClr,
        appBar: AppBar(
          // AppBar
          backgroundColor: bgClr,
          actions: [
            Image.asset(
              // User Profile Picture
              "assets/faces1.png",
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 15),
          ],
          iconTheme: const IconThemeData(
            // Drawer Icon Style
            color: txtClr,
            size: 30,
          ),
        ),
        drawer: Drawer(
          // Drawer
          backgroundColor: bgClr,
          width: 300,
          child: Column(
            children: [
              // Drawer Child Container
              Container(
                color: drawerClr,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      // Drawer Profile Picture
                      "assets/faces1.png",
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Muhammad Xain Ahmad',
                      style: TextStyle(color: txtClr, fontSize: 18),
                    ),
                    const Text(
                      'f2021266585@umt.edu.pk',
                      style: TextStyle(color: txtClr, fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                // Drawer Text Button 1
                padding: const EdgeInsets.only(left: 8),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      taskTitle = "All Tasks";
                      foundToDo = todosList;
                    });
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.library_books_rounded, color: txtClr),
                      SizedBox(width: 10),
                      Text(
                        "All Tasks",
                        style: TextStyle(color: txtClr, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.black, indent: 40, endIndent: 40),
              Padding(
                // Drawer Text Button 2
                padding: const EdgeInsets.only(left: 8),
                child: TextButton(
                  onPressed: () {
                    taskTitle = "Completed Tasks";
                    setState(() {
                      foundToDo =
                          todosList.where((todo) => todo.isDone).toList();
                    });
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_box, color: txtClr),
                      SizedBox(width: 10),
                      Text(
                        "Completed Tasks",
                        style: TextStyle(color: txtClr, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.black, indent: 40, endIndent: 40),
              Padding(
                // Drawer Text Button 3
                padding: const EdgeInsets.only(left: 8),
                child: TextButton(
                  onPressed: () {
                    taskTitle = "Incomplete Tasks";
                    setState(() {
                      foundToDo =
                          todosList.where((todo) => !todo.isDone).toList();
                    });
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_box_outline_blank, color: txtClr),
                      SizedBox(width: 10),
                      Text(
                        "Incomplete Tasks",
                        style: TextStyle(color: txtClr, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          // Body Column
          children: [
            Container(
              color: bgClr,
              child: Column(
                children: [
                  Padding(
                    // Search Bar
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: TextField(
                      onChanged: runFilter,
                      decoration: InputDecoration(
                        enabledBorder: myBorder,
                        focusedBorder: myBorder2,
                        filled: true,
                        fillColor: wgClr,
                        hintText: "Search",
                        hintStyle: const TextStyle(color: txtClr),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: txtClr,
                          size: 20,
                        ),
                      ),
                      style: const TextStyle(color: txtClr, fontSize: 16),
                    ),
                  ),
                  Padding(
                    // Task Title
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        taskTitle,
                        style: const TextStyle(
                          color: txtClr,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              // ListView
              child: ListView.builder(
                itemCount: foundToDo.length,
                itemBuilder: (context, index) {
                  final ToDo todo = foundToDo[index];
                  return Column(
                    children: [
                      Padding(
                        // ListTiles
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 10,
                          bottom: 10,
                        ),
                        child: ListTile(
                          onTap: () {
                            if (kDebugMode) {
                              print("Clicked on To Do Item!");
                              handleToDoChange(todo);
                            }
                          },
                          shape: myBtn,
                          tileColor: wgClr,
                          leading: Icon(
                            todo.isDone
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: drawerClr,
                          ),
                          title: Text(
                            todo.todoText!,
                            style: TextStyle(
                              color: txtClr,
                              fontSize: 16,
                              decoration:
                                  todo.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                              decorationThickness: 3,
                              decorationColor: bgClr,
                            ),
                          ),
                          trailing: Container(
                            // Delete Button
                            width: 35,
                            height: 35,
                            decoration: myBoxDel,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                if (kDebugMode) {
                                  print("Clicked on Delete Icon!");
                                }
                                deleteToDoItem(todo.id);
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              decoration: myBox,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  // Add Item TextField
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: todoController,
                          decoration: InputDecoration(
                            focusedBorder: myBorder,
                            enabledBorder: myBorder,
                            filled: true,
                            fillColor: wgClr,
                            hintText: "Add a new item to do",
                            hintStyle: const TextStyle(color: txtClr),
                            prefixIcon: const Icon(
                              Icons.edit_note_rounded,
                              color: txtClr,
                              size: 30,
                            ),
                          ),
                          style: const TextStyle(color: txtClr, fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        // Add Item Button
                        style: ElevatedButton.styleFrom(
                          backgroundColor: wgClr,
                          minimumSize: const Size(20, 56),
                          shape: myBtn,
                        ),
                        onPressed: () {
                          if (kDebugMode) {
                            print("Clicked on Add Icon!");
                            addToDoItem(todoController.text);
                          }
                        },
                        child: const Icon(Icons.add, color: txtClr),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
