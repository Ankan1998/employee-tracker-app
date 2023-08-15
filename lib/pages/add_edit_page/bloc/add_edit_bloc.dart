import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_assignment_app/model/viewModel/EmployeeAddEditModel.dart';
import 'package:flutter_assignment_app/utils/helpers.dart';
import 'package:meta/meta.dart';

import '../../../database/sqflite_database.dart';

part 'add_edit_event.dart';
part 'add_edit_state.dart';

class AddEditBloc extends Bloc<AddEditEvent, AddEditState> {
  AddEditBloc() : super(AddEditInitial()) {
    on<AddEmployeeDetailEvent>(_addEmployeeDetailEvent);
    on<EditEmployeeDetailEvent>(_editEmployeeDetailEvent);
  }

  Future<int?> _insertEmployee(EmployeeAddEditModel emp) async {
    int isPrevEmployee = DateTime.now().isAfter(emp.endDate) ? 1 : 0;
    String startDateTime = HelperUtil.formatDateToCustomString(emp.startDate);
    String endDateTime = HelperUtil.formatDateToCustomString(emp.endDate);

    try {
      DatabaseHelper helper = DatabaseHelper.instance;
      Map<String, dynamic> row = {
        DatabaseHelper.columnName: emp.empName,
        DatabaseHelper.columnDesignation: emp.empDesignation,
        DatabaseHelper.columnStartDate: startDateTime,
        DatabaseHelper.columnEndDate: endDateTime, // Optional
        DatabaseHelper.columnIsPrevious:
            isPrevEmployee, // 0 for false, 1 for true
      };
      int id = await helper.insert(row);
      return id;
    } catch (e) {
      print("Something Went Wrong");
      return null;
    }
  }

  Future<void> _addEmployeeDetailEvent(
      AddEmployeeDetailEvent event, Emitter<AddEditState> emit) async {
    int? empId = await _insertEmployee(event.employeeModel);
    if (empId != null) {
      emit(AddEditSuccess());
    } else {
      emit(AddEditFailure());
    }
  }

  void _editEmployeeDetailEvent(
      EditEmployeeDetailEvent event, Emitter<AddEditState> emit) {}
}
