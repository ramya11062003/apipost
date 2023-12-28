import 'dart:convert';
import 'dart:html';

import 'package:apipost/model/client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CLIENT extends StatefulWidget {
  const CLIENT({super.key});

  @override
  State<CLIENT> createState() => _CLIENTState();
}

class _CLIENTState extends State<CLIENT> {

  Future<Clientmodel>? _future;

  Future<Clientmodel> createAlbum(String clientName,String phone,String address,String gst,String website,String email,String contactPerson,String phoneNumber) async {
    final response = await http.post(
      Uri.parse('http://catodotest.elevadosoftwares.com/Client/InsertClient'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "clientld":0,
        "clientName":clientName,
        "phone":phone,
        "address":address,
        "gst":gst,
        "website":website,
        "email":email,
        "contactPerson":contactPerson,
        "phoneNumber":phoneNumber,
        "createdBy":1,
      }),
    );
    return Clientmodel.fromJson(jsonDecode(response.body));
        }
  TextEditingController _t1 = TextEditingController();
  TextEditingController _t2 = TextEditingController();
  TextEditingController _t3 = TextEditingController();
  TextEditingController _t4 = TextEditingController();
  TextEditingController _t5= TextEditingController();
  TextEditingController _t6= TextEditingController();
  TextEditingController _t7 = TextEditingController();
  TextEditingController _t8 = TextEditingController();


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
          child: (_future == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _t1,
          decoration: const InputDecoration(hintText: 'clientName'),
        ),
        TextField(
          controller: _t2,
          decoration: const InputDecoration(hintText: 'phone'),
        ),
        TextField(
          controller: _t3,
          decoration: const InputDecoration(hintText: 'address'),
        ),
        TextField(
          controller: _t4,
          decoration: const InputDecoration(hintText: 'gst'),
        ),
        TextField(
          controller: _t5,
          decoration: const InputDecoration(hintText: 'website'),
        ),
        TextField(
          controller: _t6,
          decoration: const InputDecoration(hintText: 'email'),
        ),
        TextField(
          controller: _t7,
          decoration: const InputDecoration(hintText: 'contactPerson'),
        ),
        TextField(
          controller: _t8,
          decoration: const InputDecoration(hintText: 'phoneNumber'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _future = createAlbum(_t1.text,
                  _t2.text,_t3.text,_t4.text,_t5.text,_t6.text,_t7.text,_t8.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }
  FutureBuilder<Clientmodel> buildFutureBuilder() {
    return FutureBuilder<Clientmodel>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.success.toString());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }}

