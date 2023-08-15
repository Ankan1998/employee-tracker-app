import 'package:flutter/material.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/bloc/add_edit_bloc.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/bloc/end_button_bloc.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/bloc/start_button_bloc.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/cubits/bottom_modal_option_cubit.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/cubits/date_cubit.dart';
import 'package:flutter_assignment_app/pages/home_page/HomePage.dart';
import 'package:flutter_assignment_app/pages/home_page/bloc/home_bloc.dart';
import 'package:flutter_assignment_app/utils/app_colors.dart';
import 'package:flutter_assignment_app/utils/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'database/sqflite_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StartButtonBloc>(
          create: (BuildContext context) => StartButtonBloc(),
        ),
        BlocProvider<EndButtonBloc>(
          create: (BuildContext context) => EndButtonBloc(),
        ),
        BlocProvider<BottomModalOptionCubit>(
            create: (BuildContext context) => BottomModalOptionCubit()),
        BlocProvider<StartDateCubit>(
            create: (BuildContext context) => StartDateCubit()),
        BlocProvider<EndDateCubit>(
            create: (BuildContext context) => EndDateCubit()),
        BlocProvider<AddEditBloc>(
          create: (BuildContext context) => AddEditBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: HelperUtil.createMaterialColor(AppColors.xBlue),
        ),
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}
