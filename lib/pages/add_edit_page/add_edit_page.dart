import 'package:flutter/material.dart';
import 'package:flutter_assignment_app/model/argument_model/add_edit_argument_model.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/bloc/add_edit_bloc.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/cubits/bottom_modal_option_cubit.dart';
import 'package:flutter_assignment_app/model/viewModel/EmployeeAddEditModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../database/sqflite_database.dart';
import '../home_page/HomePage.dart';
import 'cubits/date_cubit.dart';
import 'widgets/custom_bottom_modal_sheet.dart';
import 'widgets/custom_date_picker_main_modal_widget.dart';
import 'widgets/custom_editable_text_widget.dart';
import '../../custom_widget/save_cancel_bottom_widget.dart';
import '../../utils/app_colors.dart';

class AddEditPage extends StatefulWidget {
  final AddEditArgumentModel? addEditArgumentModel;

  const AddEditPage({Key? key, this.addEditArgumentModel}) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTap() {
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditBloc, AddEditState>(
      listener: (context, state) {
        if (state is AddEditSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false);
        } else if (state is AddEditFailure) {
          const snackBar = SnackBar(
            content: Text('Employee data cannot be added right now!'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: widget.addEditArgumentModel != null
                ? AppBar(
                    title: const Text('Edit Employee Details'),
                    elevation: 0,
                  )
                : AppBar(
                    title: const Text('Add Employee Details'),
                    elevation: 0,
                  ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _handleTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12.0,
                    ),
                    CustomTextEditableWidget(
                      focusNode: _focusNode,
                      controller: _textEditingController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomDropdownWidget(
                      onPressedx: _handleTap,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        BlocBuilder<StartDateCubit, DateTime>(
                            builder: (context, selectedDate) {
                          final startDateCubit = context.read<StartDateCubit>();
                          return Expanded(
                              child: CustomDatePickerMainModalWidget(
                            calendarBloc: startDateCubit,
                            selectedDate: selectedDate,
                            isEndDateWidget: false,
                          ));
                        }),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            Icons.arrow_right_alt_outlined,
                            color: AppColors.xBlue,
                          ),
                        ),
                        BlocBuilder<EndDateCubit, DateTime>(
                            builder: (context, selectedDate) {
                          final endDateCubit = context.read<EndDateCubit>();
                          return Expanded(
                              child: CustomDatePickerMainModalWidget(
                            calendarBloc: endDateCubit,
                            selectedDate: selectedDate,
                            isEndDateWidget: true,
                          ));
                        })
                      ],
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    SaveCancelBottombarWidget(
                      onPressedCancel: () {
                        print("cancel");
                      },
                      onPressedSave: () {
                        final EmployeeAddEditModel emp = EmployeeAddEditModel(
                            empName: _textEditingController.text,
                            empDesignation:
                                context.read<BottomModalOptionCubit>().state,
                            startDate: context.read<StartDateCubit>().state,
                            endDate: context.read<EndDateCubit>().state);
                        context
                            .read<AddEditBloc>()
                            .add(AddEmployeeDetailEvent(emp));
                      },
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
