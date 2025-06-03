// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/services/api_service.dart';
import 'presentation/blocs/user_list/user_list_bloc.dart';
import 'presentation/screens/user_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiService(),
      child: MaterialApp(
        title: 'UserSync',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (context) => UserListBloc(context.read<ApiService>()),
          child: const UserListScreen(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
