import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_flutter/DataBase_Helper/database_helper.dart';
import 'package:sqflite_flutter/values/colors.dart';
import 'package:sqflite_flutter/values/decorations.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController linkController = TextEditingController();
  TextEditingController linkController2 = TextEditingController();
  String name = '';
  String color = '';
  // db helper instance
  final dbHelper = DatabaseHelper.instance;

  // db helper insert method
  void _insert(String name, String color) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.username: name,
      DatabaseHelper.color: color
    };
    final id = await dbHelper.insert(
      row,
    );
    print('inserted row id: $id');
    _query();
  }

  // db helper query and print method
  Future<List<Map<String, dynamic>>> _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
    return allRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database with Sqflite"),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    "I want to know your Favourite color",
                    style: headingStyle,
                  ),
                ),
              SizedBox(height: 20,),
              // name field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              decoration: textBoxDecoration,
              child: TextFormField(
                controller: linkController,
                enableInteractiveSelection: true,
                cursorColor: gradient1,
                style: TextStyle(
                  fontSize: 17.0,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    hintText: "What is ur name ?",
                    hintStyle: TextStyle(color: gradient3)),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Don't you have a name";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      this.name = value;
                    });
                  }
                },
              ),
                ),
              ),

              // color field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              decoration: textBoxDecoration,
              child:TextFormField(
                controller: linkController2,
                enableInteractiveSelection: true,
                cursorColor: gradient1,
                style: TextStyle(
                  fontSize: 17.0,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    hintText: "Your favourite Color ?",
                    hintStyle: TextStyle(color: gradient3)),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Don't be shy about the color !";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      this.color = value;
                    });
                  }
                },
              ),
              ),
              ),
              // insert button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    child: IconButton(
                        icon: Image.asset('assets/images/download.png'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _insert(this.name, this.color);
                          }
                        })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
