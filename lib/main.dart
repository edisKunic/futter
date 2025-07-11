import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'routes.dart';
import 'shared/blocs/auth_bloc/auth_bloc.dart';
import 'shared/blocs/auth_bloc/auth_event.dart';
import 'shared/blocs/auth_bloc/auth_state.dart';
import 'shared/blocs/app_bloc/app_bloc.dart';
import 'shared/blocs/app_bloc/app_event.dart';
import 'shared/blocs/app_bloc/app_state.dart';
import 'shared/blocs/connectivity_cubit/connectivity_cubit.dart';
import 'shared/blocs/theme_bloc/theme_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'shared/presentation/pages/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              GetIt.instance<AuthBloc>()..add(AuthCheckRequested()),
        ),
        BlocProvider<AppBloc>(
          create: (context) => GetIt.instance<AppBloc>()..add(AppStarted()),
        ),
        BlocProvider<ConnectivityCubit>(
          create: (context) => GetIt.instance<ConnectivityCubit>(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => GetIt.instance<ThemeBloc>(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Futter App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            onGenerateRoute: AppRoutes.generateRoute,
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                if (authState is AuthLoading) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (authState is Authenticated) {
                  return const MainApp();
                } else {
                  return const LoginPage();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
