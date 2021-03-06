import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:dio/src/response.dart';

import 'model.dart';

class EmployeeApi extends ChangeNotifier {
  List<Employee> employees = [];
  final Dio dio = Dio();

  Future<List<Employee>> getAllEmployee() {
    return dio
        .get('http://dummy.restapiexample.com/api/v1/employees')
        .then((d) {
      print(d.toString());

      employees = (d.data['data'] as List)
          .map((employee) => Employee.fromJson(employee))
          .toList();
      this.employees = employees;
      notifyListeners();
      return employees;
    });
  }

  Future<Employee> createEmployee(Employee employee) {
    dio.options.headers.putIfAbsent("Accept", () {
      return "application/json";
    });
    return dio
        .post("http://dummy.restapiexample.com/api/v1/create", data: employee)
        .then((d) {
      var emp = new Employee.fromJson(d.data["data"] as Map);
      employees.add(emp);
      notifyListeners();
      return employee;
    });
  }

}