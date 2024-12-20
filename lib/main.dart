import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pmu_labs/presentation/home_page/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmu_labs/data/repositories/sign_repository.dart';
import 'package:pmu_labs/presentation/home_page/bloc/bloc.dart';
import 'package:pmu_labs/presentation/like_bloc/like_bloc.dart';
import 'package:pmu_labs/presentation/locale_bloc/locale_bloc.dart';
import 'package:pmu_labs/presentation/locale_bloc/locale_state.dart';

import 'components/locale/l10n/app_locale.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBloc>(
      lazy: false,
      create: (context) => LocaleBloc(Locale(Platform.localeName)),
      child: BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              locale: state.currentLocale,
              localizationsDelegates: AppLocale.localizationsDelegates,
              supportedLocales: AppLocale.supportedLocales,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
                scaffoldBackgroundColor: const Color.fromARGB(
                    255, 255, 255, 255),
                useMaterial3: true,
                textTheme: const TextTheme(
                  headlineLarge: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  bodyLarge: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              home: RepositoryProvider<SignsRepository>(
                lazy: true,
                create: (_) => SignsRepository(),
                child: BlocProvider<LikeBloc>(
                  lazy: false,
                  create: (context) => LikeBloc(),
                  child: BlocProvider<HomeBloc>(
                    lazy: false,
                    create: (context) =>
                        HomeBloc(context.read<SignsRepository>()),
                    child: const MyHomePage(title: 'Ведьмачьи знаки'),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
