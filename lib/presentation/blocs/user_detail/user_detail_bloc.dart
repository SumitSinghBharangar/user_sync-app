// lib/presentation/blocs/user_detail/user_detail_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_sync/data/models/post_model.dart';
import '../../../data/services/api_service.dart';
import 'user_detail_event.dart';
import 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final ApiService apiService;
  List<Post> localPosts = []; // Store local posts

  UserDetailBloc(this.apiService) : super(UserDetailInitial()) {
    on<FetchUserDetails>(_onFetchUserDetails);
    on<AddPost>(_onAddPost);
  }

  Future<void> _onFetchUserDetails(
      FetchUserDetails event, Emitter<UserDetailState> emit) async {
    emit(UserDetailLoading());
    try {
      final posts = await apiService.fetchPosts(event.userId);
      final todos = await apiService.fetchTodos(event.userId);
      emit(
          UserDetailLoaded(posts: posts, todos: todos, localPosts: localPosts));
    } catch (e) {
      emit(UserDetailError(e.toString()));
    }
  }

  void _onAddPost(AddPost event, Emitter<UserDetailState> emit) {
    localPosts.add(event.post);
    if (state is UserDetailLoaded) {
      emit(UserDetailLoaded(
        posts: (state as UserDetailLoaded).posts,
        todos: (state as UserDetailLoaded).todos,
        localPosts: localPosts,
      ));
    }
  }
}
