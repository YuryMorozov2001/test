import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/todo_controller.dart';
import '../model/todo.dart';

class EditOrCreatePage extends StatefulWidget {
  final Todo? todo;

  const EditOrCreatePage({super.key, this.todo});

  @override
  State<EditOrCreatePage> createState() => _EditOrCreatePageState();
}

class _EditOrCreatePageState extends State<EditOrCreatePage> {
  late TextEditingController titleController;
  late bool completed;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo?.title);
    completed = widget.todo?.completed ?? false;
  }

  void saveChanges() {
    final todoController = Get.find<TodoController>();
    if (widget.todo != null) {
      Todo updatedTodo = widget.todo!.copyWith(
        title: titleController.text,
        completed: completed,
      );
      todoController.updateTodo(updatedTodo);
    } else {
      Todo newTodo = Todo(
        id: todoController.todos.length + 1,
        title: titleController.text.isEmpty ? 'unnamed' : titleController.text,
        completed: completed,
      );
      todoController.addTodo(newTodo);
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            CheckboxListTile(
              value: completed,
              onChanged: (bool? newValue) {
                setState(() {
                  completed = newValue ?? false;
                });
              },
              title: const Text('Completed'),
            ),
            ElevatedButton(
              onPressed: saveChanges,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
