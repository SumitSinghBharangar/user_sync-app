import 'package:equatable/equatable.dart';
import 'package:user_sync/data/models/user_model.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {
  final bool isFirstFetch;

  const UserListLoading({this.isFirstFetch = false});

  @override
  List<Object> get props => [isFirstFetch];
}

class UserListLoaded extends UserListState {
  final List<User> users;
  final bool hasReachedMax;
  final String? searchQuery;

  const UserListLoaded({
    required this.users,
    this.hasReachedMax = false,
    this.searchQuery,
  });

  @override
  List<Object> get props => [users, hasReachedMax, searchQuery ?? ''];
}

class UserListError extends UserListState {
  final String message;

  const UserListError(this.message);

  @override
  List<Object> get props => [message];
}
