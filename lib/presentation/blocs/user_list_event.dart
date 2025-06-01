import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends UserListEvent {
  final int skip;
  final int limit;

  const FetchUsers({this.skip = 0, this.limit = 10});

  @override
  List<Object> get props => [skip, limit];
}

class SearchUsers extends UserListEvent {
  final String query;

  const SearchUsers(this.query);

  @override
  List<Object> get props => [query];
}
