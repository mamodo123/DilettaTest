import 'package:dilleta_test/controller/favorite_list_cubit.dart';
import 'package:dilleta_test/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/buffer_list_cubit.dart';
import 'helpers/consts/config.dart';

void main() {
  runApp(MaterialApp(
    title: appName,
    theme: themeData,
    home: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BufferListCubit()),
        BlocProvider(create: (_) => FavoriteListCubit()),
      ],
      child: const HomeScreen(),
    ),
  ));
}
