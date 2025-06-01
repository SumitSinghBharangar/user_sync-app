import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String todo;
  final bool completed;

  const Todo({
    required this.id,
    required this.todo,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
    };
  }

  @override
  List<Object> get props => [id, todo, completed];
}
