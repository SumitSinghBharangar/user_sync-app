// lib/presentation/screens/user_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/user_list/user_list_bloc.dart';
import '../blocs/user_list/user_list_event.dart';
import '../blocs/user_list/user_list_state.dart';

import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserListBloc>().add(const FetchUsers());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final state = context.read<UserListBloc>().state;
        if (state is UserListLoaded && !state.hasReachedMax) {
          context.read<UserListBloc>().add(FetchUsers(
                skip: state.users.length,
                limit: 10,
              ));
        }
      }
    });
    _searchController.addListener(() {
      context.read<UserListBloc>().add(SearchUsers(_searchController.text));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<UserListBloc>().add(const FetchUsers(skip: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserSync'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search users by name...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: BlocBuilder<UserListBloc, UserListState>(
                builder: (context, state) {
                  if (state is UserListLoading && state.isFirstFetch) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is UserListError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  if (state is UserListLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.hasReachedMax
                          ? state.users.length
                          : state.users.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.users.length) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final user = state.users[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(user.image),
                          ),
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: Text(user.email),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailScreen(user: user),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
