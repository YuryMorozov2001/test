import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../model/todo.dart';

part 'todo_client.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class TodoClient {
  factory TodoClient(Dio dio, {String baseUrl}) = _TodoClient;

  @GET("/todos")
  Future<List<Todo>> getTodos();
}
