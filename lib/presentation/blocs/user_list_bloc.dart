import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_sync/data/models/user_model.dart';
import '../../../data/services/api_service.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final ApiService apiService;
  int skip = 0;
  final int limit = 10;
  List<User> users = [];
  String? currentSearchQuery;

  UserListBloc(this.apiService) : super(UserListInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(
      FetchUsers event, Emitter<UserListState> emit) async {
    if (state is UserListInitial || event.skip == 0) {
      emit(const UserListLoading(isFirstFetch: true));
      users = [];
      skip = 0;
      currentSearchQuery = null;
    } else {
      emit(const UserListLoading());
    }

    try {
      final newUsers = await apiService.fetchUsers(
        skip: event.skip,
        limit: event.limit,
        search: currentSearchQuery,
      );
      users.addAll(newUsers);
      skip = event.skip + newUsers.length;
      emit(UserListLoaded(
        users: users,
        hasReachedMax: newUsers.length < event.limit,
        searchQuery: currentSearchQuery,
      ));
    } catch (e) {
      emit(UserListError(e.toString()));
    }
  }

  Future<void> _onSearchUsers(
      SearchUsers event, Emitter<UserListState> emit) async {
    emit(const UserListLoading(isFirstFetch: true));
    users = [];
    skip = 0;
    currentSearchQuery = event.query;

    try {
      final newUsers = await apiService.fetchUsers(
        skip: skip,
        limit: limit,
        search: event.query,
      );
      users.addAll(newUsers);
      skip += newUsers.length;
      emit(UserListLoaded(
        users: users,
        hasReachedMax: newUsers.length < limit,
        searchQuery: event.query,
      ));
    } catch (e) {
      emit(UserListError(e.toString()));
    }
  }
}
