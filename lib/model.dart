class Author {
  String id;
  String employee_name;
  String employee_salary;
  String employee_age;
  String profile_image;
  Author({this.id, this.employee_name, this.employee_age, this.profile_image,this.employee_salary});
  factory Author.fromJson(Map<String, dynamic> author) => Author(
      id: author['id'],
      employee_name: author['employee_name']??"",
      employee_salary: author['employee_salary']??"",
      employee_age: author['employee_age']??"",
      profile_image: author['profile_image']??"");
  Map<String, dynamic> toJson() =>
      {'id': id, 'employee_name': employee_name, 'employee_salary': employee_salary, 'employee_age': employee_age, 'profile_image':profile_image};
}