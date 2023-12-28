import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/categorymodel.dart';

class categoryPOST extends StatefulWidget {
  const categoryPOST({super.key});

  @override
  State<categoryPOST> createState() => _categoryPOSTState();
}

class _categoryPOSTState extends State<categoryPOST> {
  Future<category_m>? _future;

Future<category_m>Postcategory(String category,String desc) async
{
  var resp= await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/Category/InsertCategory"),
  headers: <String,String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },
      body: jsonEncode(<String, dynamic>{
        "categoryId":0,
        "category":category,
        "description":desc,
        "createdBy":1,
      }),
  );
  return category_m.fromJson(jsonDecode(resp.body));

}
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtDescription = TextEditingController();


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
          controller: txtCategory,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        TextField(
          controller: txtDescription,
          decoration: const InputDecoration(hintText: 'Enter description'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _future= Postcategory(txtCategory.text,txtDescription.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<category_m>buildFutureBuilder() {
   return FutureBuilder<category_m>(
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
  }

}

