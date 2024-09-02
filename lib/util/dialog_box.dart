import 'package:flutter/material.dart';
// import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:Colors.blueGrey, 
      content: Container(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new Task", 
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(text:"Save", onPressed: onSave),

              const SizedBox(width: 75,),
              
              MyButton(text:"Cancel", onPressed: onCancel),
            ],)
        ],
      ),
      )
    );
  }
}