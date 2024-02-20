import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../api/todo_client.dart';
import '../model/todo.dart';

class TodoController extends GetxController {
  final RxList<Todo> todos = <Todo>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    isLoading.value = true;
    Dio dio = Dio();
    final client = TodoClient(dio);
    try {
      final fetchedTodos = await client.getTodos();
      todos.addAll(fetchedTodos);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void updateTodo(Todo updatedTodo) {
    int index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
    todos[index] = updatedTodo;
  }

  void addTodo(Todo newTodo) {
    todos.add(newTodo);
  }
}
