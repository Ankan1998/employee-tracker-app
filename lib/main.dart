import 'package:flutter/material.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/bloc/add_edit_bloc.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/bloc/end_button_bloc.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/bloc/start_button_bloc.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/cubits/bottom_modal_option_cubit.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/cubits/date_cubit.dart';
import 'package:flutter_assignment_app/pages/home_page/HomePage.dart';
import 'package:flutter_assignment_app/pages/home_page/bloc/delete_bloc.dart';
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
        BlocProvider<DeleteBloc>(
          create: (BuildContext context) => DeleteBloc(),
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

// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Tap Over Dismissible')),
//         body: MyWidget(),
//       ),
//     );
//   }
// }
//
// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 4,
//       itemBuilder: (BuildContext context, int index) {
//         return RawGestureDetector(
//           gestures: <Type, GestureRecognizerFactory>{
//             TapGestureRecognizer:
//                 GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
//               () => TapGestureRecognizer(),
//               (TapGestureRecognizer instance) {
//                 instance.onTap = () {
//                   print('Tapped on item');
//                   // Handle your onTap functionality here, e.g., navigation
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SecondScreen()),
//                   );
//                 };
//               },
//             ),
//           },
//           child: DismissibleWithTap(
//             key: UniqueKey(),
//             onDismissed: (direction) {
//               print('Dismissed');
//             },
//             background: Container(
//               alignment: Alignment.centerRight,
//               color: Colors.red,
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//               child: const Icon(
//                 Icons.delete_forever_outlined,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text('Employee Name'),
//                   subtitle: Text('Employee Designation'),
//                 ),
//                 Divider(height: 1),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// // class CustomTapGestureRecognizer extends TapGestureRecognizer {
// //   void handleTapDown(TapDownDetails details) {
// //     if (onTap != null) {
// //       onTap!();
// //     }
// //   }
// // }
//
// class DismissibleWithTap extends StatelessWidget {
//   final Widget child;
//   final Key key;
//   final Function(DismissDirection direction) onDismissed;
//   final Widget background;
//
//   DismissibleWithTap({
//     required this.child,
//     required this.key,
//     required this.onDismissed,
//     required this.background,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: key,
//       onDismissed: onDismissed,
//       background: background,
//       child: child,
//     );
//   }
// }
//
// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Second Screen')),
//       body: Center(child: Text('Second Screen Content')),
//     );
//   }
// }
