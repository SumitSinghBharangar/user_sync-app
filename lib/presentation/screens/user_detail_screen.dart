// lib/presentation/screens/user_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:user_sync/data/models/user_model.dart';

import '../blocs/user_detail/user_detail_bloc.dart';
import '../blocs/user_detail/user_detail_event.dart';
import '../blocs/user_detail/user_detail_state.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserDetailBloc(context.read())..add(FetchUserDetails(user.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${user.firstName} ${user.lastName}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // User Info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: CachedNetworkImageProvider(user.image),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(user.email),
                      ],
                    ),
                  ],
                ),
              ),
              // Posts and Todos
              BlocBuilder<UserDetailBloc, UserDetailState>(
                builder: (context, state) {
                  if (state is UserDetailLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is UserDetailError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  if (state is UserDetailLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Posts Section
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Posts',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        state.posts.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('No posts available'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.posts.length,
                                itemBuilder: (context, index) {
                                  final post = state.posts[index];
                                  return ListTile(
                                    title: Text(post.title),
                                    subtitle: Text(post.body),
                                  );
                                },
                              ),
                        // Todos Section
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Todos',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        state.todos.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('No todos available'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.todos.length,
                                itemBuilder: (context, index) {
                                  final todo = state.todos[index];
                                  return ListTile(
                                    title: Text(todo.todo),
                                    trailing: Icon(
                                      todo.completed
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      color: todo.completed
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  );
                                },
                              ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
