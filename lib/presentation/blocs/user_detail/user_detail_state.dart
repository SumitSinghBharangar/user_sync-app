import 'package:equatable/equatable.dart';
import 'package:user_sync/data/models/post_model.dart';
import 'package:user_sync/data/models/todo_model.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final List<Post> posts;
  final List<Todo> todos;
  final List<Post> localPosts;

  const UserDetailLoaded({
    required this.posts,
    required this.todos,
    this.localPosts = const [],
  });

  @override
  List<Object> get props => [posts, todos, localPosts];
}

class UserDetailError extends UserDetailState {
  final String message;

  const UserDetailError(this.message);

  @override
  List<Object> get props => [message];
}
