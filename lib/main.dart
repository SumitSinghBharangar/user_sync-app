import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_sync/common/app_colors.dart';
import 'data/services/api_service.dart';
import 'presentation/blocs/user_list/user_list_bloc.dart';
import 'presentation/screens/user_list_screen.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(_lightTheme) {
    on<ToggleTheme>((event, emit) {
      emit(event.brightness == Brightness.light ? _lightTheme : _darkTheme);
    });
  }

  static final _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // scaffoldBackgroundColor: AppColors.layerOneBg,

    textTheme: TextTheme(
      bodyMedium: TextStyle(color: AppColors.black),
      bodySmall: TextStyle(color: Colors.grey),
    ),
    iconTheme: IconThemeData(color: AppColors.signInBox),
  );

  static final _darkTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: AppColors.white),
      bodySmall: TextStyle(color: AppColors.hintText),
    ),
    iconTheme: IconThemeData(color: AppColors.layerOneBg),
  );
}

class ThemeEvent {
  final Brightness brightness;
  ThemeEvent(this.brightness);
}

class ToggleTheme extends ThemeEvent {
  ToggleTheme(super.brightness);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiService(),
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeData>(
          builder: (context, theme) {
            return MaterialApp(
              title: 'UserSync',
              theme: theme,
              home: BlocProvider(
                create: (context) => UserListBloc(context.read<ApiService>()),
                child: const UserListScreen(),
              ),
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
