import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:user_sync/common/app_colors.dart';
import 'package:user_sync/main.dart';
import '../blocs/user_list/user_list_bloc.dart';
import '../blocs/user_list/user_list_event.dart';
import '../blocs/user_list/user_list_state.dart';
import '../blocs/user_detail/user_detail_bloc.dart';
import '../../data/services/api_service.dart';

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

  void _toggleTheme() {
    final currentTheme = Theme.of(context).brightness;
    final newTheme =
        currentTheme == Brightness.light ? Brightness.dark : Brightness.light;
    context.read<ThemeBloc>().add(ToggleTheme(newTheme));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserSync'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search users by name...',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color.fromRGBO(255, 255, 255, 1)
                        : Colors.white,
                  ),
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.signInBox),
                hintStyle: TextStyle(color: AppColors.hintText),
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
                            final userDetailBloc =
                                UserDetailBloc(context.read<ApiService>());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: userDetailBloc,
                                  child: UserDetailScreen(
                                    user: user,
                                    userDetailBloc: userDetailBloc,
                                  ),
                                ),
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
