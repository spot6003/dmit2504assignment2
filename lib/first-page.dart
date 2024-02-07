// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:robbinlaw/main.dart';
import 'package:robbinlaw/widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  bool enabled = false;
  int timesClicked = 0;
  String msg1 = '';
  String msg2 = '';
  late String? _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 - User Input'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Enable Buttons"),
              Switch(
                  value: enabled,
                  onChanged: (bool onChangedValue) {
                    enabled = onChangedValue;
                    setState(() {
                      msg2 = "Reset";
                    });
                  })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Build the two buttons here
              // as children of the row.
              // For each button use a
              // "Visibility Widget" and its child
              // will be an "ElevatedButton"
              Visibility(
                  visible: enabled,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timesClicked++;
                          msg1 = "Clicked $timesClicked";
                        });
                      },
                      child: msg1 == '' ? Text("Click me") : Text(msg1))),
              SizedBox(width: 10),
              Visibility(
                  visible: enabled,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timesClicked = 0;
                          msg1 = '';
                        });
                      },
                      child: Text(msg2)))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //TODO: Build the text form field
                  // here as the first
                  // child of the column.
                  // Include as the second child
                  // of the column
                  // a submit button that will show a
                  // snackbar with the "firstName"
                  // if validation is satisfied.
                  TextFormField(
                    controller: textEditingController,
                    validator: (input) {
                      return input!.isEmpty
                          ? "Min 1, max 10 please"
                          : null;
                    },
                    onChanged: (value) {
                      _name = value;
                    },
                    onFieldSubmitted: (value) {
                      formKey.currentState!.validate();
                    },
                    maxLength: 10,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.hourglass_top),
                      hintText: "first name",
                      helperText: "Min 1, max 10",
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  textEditingController.clear();
                  scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
                  duration: const Duration(seconds: 5),
                  behavior: SnackBarBehavior.floating,
                  content: Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.white,),
                      Text("Hey there, your name is $_name", style: TextStyle(fontSize: 14.0),),
                    ],
                  ),
                  action: SnackBarAction(
                    textColor: Colors.white,
                      label: "Click me",
                      onPressed: () {
                        print("You pressed the snackbar button!");
                      }),
                ));
                }
              },
              child: Text("Submit")),
        ],
      ),
    );
  }
}
