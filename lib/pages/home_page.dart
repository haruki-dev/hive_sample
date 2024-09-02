import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/database.dart';
import 'package:flutter_application_2/util/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/util/todo_tile.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  final _myBox = Hive.box('mybox');

  ToDoDataBase db = ToDoDataBase(); 

  @override
  void initState(){

    if(_myBox.get("mybox") == null ){
      db.createInitialData();
    } else {
      db.loadData();
    }
    

  }

  // text_controller

  final _controller = TextEditingController();


  // list of todo tasks

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([ _controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }


  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave:saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }




  @override
  Widget build(BuildContext context){
    return Scaffold(
      // backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 3,
        shadowColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:createNewTask,
        child: Icon(Icons.add),
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // 角丸
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction:(context) => deleteTask(index),
            );
        },
      ),
      // body: ListView(
        // children: [
        //   ToDoTile(
        //     taskName: "MakeTutorial",
        //     taskCompleted: true,
        //     onChanged: (p0) {},
        //   ),
        //   ToDoTile(
        //     taskName: "Do Exercise",
        //     taskCompleted: false,
        //     onChanged: (p0) {},
        //   ),
        //   ToDoTile(
        //     taskName: "Studying English",
        //     taskCompleted: true,
        //     onChanged: (p0) {},
        //   ),
        // ],
      // )
    );
  }
}