import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../database/sqflite_database.dart';

part 'delete_bloc_files/delete_event.dart';
part 'delete_bloc_files/delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc() : super(DeleteInitial()) {
    on<DeleteRecordEvent>(_deleteRecordEvent);
  }

  Future<void> _deleteRecordEvent(DeleteRecordEvent event, Emitter<DeleteState> emit) async {
    try {
      DatabaseHelper helper = DatabaseHelper.instance;
      await helper.delete(event.empId);
      emit(DeleteSuccess());
    } catch (e) {
      print("Something Went Wrong");
      emit(DeleteFailure());
    }
  }
}
