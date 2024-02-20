import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_or_create_page.dart';
import '../controller/todo_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('todo app'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
          () => const EditOrCreatePage(),
        ),
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => todoController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: todoController.todos.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(todoController.todos[index].title),
                  subtitle: Text(
                    todoController.todos[index].completed
                        ? "Completed"
                        : "Not completed",
                  ),
                  onTap: () => Get.to(
                    () => EditOrCreatePage(
                      todo: todoController.todos[index],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
