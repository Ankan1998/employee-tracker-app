import 'package:flutter/material.dart';
import 'package:flutter_assignment_app/model/argument_model/add_edit_argument_model.dart';
import 'package:flutter_assignment_app/pages/add_edit_page/add_edit_page.dart';
import 'package:flutter_assignment_app/pages/home_page/bloc/home_bloc.dart';
import 'package:flutter_assignment_app/pages/home_page/widgets/employee_list_tile.dart';
import 'package:flutter_assignment_app/utils/app_colors.dart';
import 'package:flutter_assignment_app/utils/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../model/viewModel/EmployeeModel.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeGetEmployeeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        elevation: 0,
      ),
      backgroundColor: AppColors.xGreyBackground,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading, please wait...',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.xGrey,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HomeFailure) {
            return const Center(
              child: Text(
                'Something Went Wrong!',
                style: TextStyle(fontSize: 16, color: AppColors.xGreyTextShade),
              ),
            );
          } else if (state is HomeSuccess) {
            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: GroupListView(
                    sectionsCount: 2,
                    countOfItemInSection: (int section) {
                      return state.empModelList
                          .where((e) => e.isPreviousEmp == section)
                          .length;
                    },
                    itemBuilder: (BuildContext context, IndexPath index) {
                      EmployeeModel employee = state.empModelList
                          .where((e) => e.isPreviousEmp == index.section)
                          .toList()[index.index];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => {print("deletd")},
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomListTile(
                              Title: employee.empName,
                              Position: employee.empDesignation,
                              startDate: HelperUtil.formatDate_dMMMy(
                                  employee.startDate),
                              endDate:
                                  HelperUtil.formatDate_dMMMy(employee.endDate),
                              isPrev: employee.isPreviousEmp,
                            ),
                            const Divider(height: 1)
                          ],
                        ),
                      );
                    },
                    groupHeaderBuilder: (BuildContext context, int section) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 18),
                        child: Text(
                          section == 0
                              ? 'Current employees'
                              : 'Previous employees',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.xBlue),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color:
                      AppColors.xGreyBackground, // Adjust the color as needed
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: const Text(
                    "Swipe left to delete",
                    style: TextStyle(color: AppColors.xGreyTextShade),
                  ), // Replace with your sticky widget
                ),
              ],
            );
          }
          return const Center(
            child: Column(
              children: [Text("Nothing to Show")],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditPage(
                  addEditArgumentModel: AddEditArgumentModel(
                      employeeName: 'Jets',
                      employeeDesignation: 's',
                      employeeStartDate: DateTime.now())),
            ),
          );
        },
        backgroundColor: AppColors.xBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
