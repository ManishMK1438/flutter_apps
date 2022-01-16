

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/domains/models/task.dart';
import 'package:todo_app/domains/services/task_operations.dart';
import 'package:todo_app/pages/widgets/custom_round_button.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  final _uuid = const Uuid();

  _addTask() async{
    FocusScope.of(context).unfocus();
    var _isValid = _formKey.currentState!.validate();
    if(!_isValid){
      return;
    }

    _formKey.currentState!.save();
    String id =_uuid.v1();
    Task _task = Task(id: id,title: _title, description: _description, time: DateTime.now().toString());
    TaskOperations.addTask(_task, id);


    /*String docId = await id;
    Task task2 = Task.takeInput(id: docId,title: _title, description: _description, time: DateTime.now().toString());
    print(task2.id);*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add your Task', style: GoogleFonts.pacifico(),),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter your title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    validator: (value){
                      if(value!.trim().isEmpty){
                        return 'This field cannot be empty!';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _title = value!;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                  child: TextFormField(
                    maxLines: 7,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(

                      labelText: 'Description',
                      hintText: 'Enter your description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    validator: (value){
                      if(value!.trim().isEmpty){
                        return 'This field cannot be empty!';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _description = value!;
                    },
                  ),
                ),
              ],
            ),
          ),
          CustomRoundButton(buttonText: 'ADD TASK', onPressed: _addTask)
        ],
      ),
    );
  }
}
