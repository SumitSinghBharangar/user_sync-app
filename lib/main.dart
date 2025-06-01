import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_sync/data/services/api_service.dart';
import 'package:user_sync/presentation/blocs/user_list/user_list_bloc.dart';
import 'package:user_sync/presentation/screens/user_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiService(),
      child: MaterialApp(
        title: 'UserSync',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: BlocProvider(
          create: (context) => UserListBloc(context.read<ApiService>()),
          child: const UserListScreen(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
