import 'dart:convert';

import 'package:apipost/model/empModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmpWork extends StatefulWidget {
  const EmpWork({super.key});

  @override
  State<EmpWork> createState() => _EmpWorkState();
}

class _EmpWorkState extends State<EmpWork> {

  Future<EmpModel> Employee(String employeeName,String mobile,String userName,String password,String confirmPassword) async {
    final response = await http.post(
      Uri.parse('http://catodotest.elevadosoftwares.com/Employee/Insertemployee'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "employeeId":0,
        "employeeName":employeeName,
        "mobile":mobile,
        "userName":userName,
        "password":password,
        "confirmPassword":confirmPassword,
        "createBy":1

      }),
    );
    return EmpModel.fromJson(jsonDecode(response.body));}

    @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
