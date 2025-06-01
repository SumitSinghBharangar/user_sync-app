// lib/data/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_sync/data/models/post_model.dart';
import 'package:user_sync/data/models/todo_model.dart';
import 'package:user_sync/data/models/user_model.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  // Fetch users with pagination and optional search
  Future<List<User>> fetchUsers(
      {int skip = 0, int limit = 10, String? search}) async {
    try {
      final String url = search != null && search.isNotEmpty
          ? '$_baseUrl/users/search?q=$search&limit=$limit&skip=$skip'
          : '$_baseUrl/users?limit=$limit&skip=$skip';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> usersJson = data['users'] as List<dynamic>;
        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  // Fetch posts for a specific user
  Future<List<Post>> fetchPosts(int userId) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/posts/user/$userId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> postsJson = data['posts'] as List<dynamic>;
        return postsJson.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  // Fetch todos for a specific user
  Future<List<Todo>> fetchTodos(int userId) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/todos/user/$userId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> todosJson = data['todos'] as List<dynamic>;
        return todosJson.map((json) => Todo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch todos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching todos: $e');
    }
  }
}
