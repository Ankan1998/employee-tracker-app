import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_bloc_files/delete_event.dart';
part 'delete_bloc_files/delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc() : super(DeleteInitial()) {
    on<DeleteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
