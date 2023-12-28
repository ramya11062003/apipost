import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/employeemodel.dart';
class employeeclass extends StatefulWidget {
  const employeeclass({super.key});

  @override
  State<employeeclass> createState() => _employeeclassState();
}

class _employeeclassState extends State<employeeclass> {

  Future<Employee>? _futureAlbum;
  Future<Employee> createAlbum(String employeeName,String mobile,String username,String password,String confirmPassword) async {
    final response = await http.post(Uri.parse('http://catodotest.elevadosoftwares.com/Employee/InsertEmployee'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,dynamic>{
        "employeeld":0,
        "employeeName":employeeName,
        "mobile":mobile,
        "userName":username,
        "password":password,
        "confirmPassword":confirmPassword,
        "createdBy":1

      }),);
        return Employee.fromJson(jsonDecode(response.body));
  }

  TextEditingController _t1 = TextEditingController();
  TextEditingController _t2 = TextEditingController();
  TextEditingController _t3 = TextEditingController();
  TextEditingController _t4 = TextEditingController();
  TextEditingController _t5= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }



  Column buildColumn() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextField(
        controller: _t1,
        decoration:  InputDecoration(hintText: 'Employee name'),
      ),
      TextField(
        controller: _t2,
        decoration: const InputDecoration(hintText: 'Mobile'),
      ),
      TextField(
        controller: _t3,
        decoration: const InputDecoration(hintText: 'User name'),
      ),
      TextField(
        controller: _t4,
        decoration: const InputDecoration(hintText: 'Password'),
      ),
      TextField(
        controller: _t5,
        decoration: const InputDecoration(hintText: 'Confirm password'),
      ),


      ElevatedButton(
        onPressed: () {
          setState(() {
            _futureAlbum= createAlbum(_t1.text,
                _t2.text,_t3.text,_t4.text,_t5.text);
          });
        },
        child: const Text('Create Data'),
      ),
    ],
  );
}

FutureBuilder< Employee> buildFutureBuilder() {
  return FutureBuilder< Employee>(
    future: _futureAlbum,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Text(snapshot.data!.success.toString());
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }

      return const CircularProgressIndicator();
    },
  );
}
}

