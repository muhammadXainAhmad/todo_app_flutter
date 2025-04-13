class ToDo {
  String id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: "01", todoText: "Morning Run", isDone: true),
      ToDo(id: "02", todoText: "Breakfast", isDone: true),
      ToDo(id: "03", todoText: "Wash Car",),
      ToDo(id: "04", todoText: "Buy Groceries", isDone: true),
      ToDo(id: "05", todoText: "Check Emails",),
      ToDo(id: "06", todoText: "Team Meeting",),
      ToDo(id: "07", todoText: "Complete MAD Project",),
    ];
  }
}
