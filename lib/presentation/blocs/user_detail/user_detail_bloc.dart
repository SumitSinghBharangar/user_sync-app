import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/api_service.dart';
import 'user_detail_event.dart';
import 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final ApiService apiService;

  UserDetailBloc(this.apiService) : super(UserDetailInitial()) {
    on<FetchUserDetails>(_onFetchUserDetails);
  }

  Future<void> _onFetchUserDetails(
      FetchUserDetails event, Emitter<UserDetailState> emit) async {
    emit(UserDetailLoading());
    try {
      final posts = await apiService.fetchPosts(event.userId);
      final todos = await apiService.fetchTodos(event.userId);
      emit(UserDetailLoaded(posts: posts, todos: todos));
    } catch (e) {
      emit(UserDetailError(e.toString()));
    }
  }
}
