class AddEditArgumentModel {
  String employeeName;
  String employeeDesignation;
  DateTime employeeStartDate;
  DateTime? employeeEndDate;

  AddEditArgumentModel(
      {required this.employeeName,
      required this.employeeDesignation,
      required this.employeeStartDate,
      this.employeeEndDate});
}
