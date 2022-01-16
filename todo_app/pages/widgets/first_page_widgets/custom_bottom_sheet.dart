import 'package:flutter/material.dart';
import 'package:todo_app/domains/models/task.dart';
import 'package:todo_app/domains/services/task_operations.dart';
import 'package:todo_app/pages/widgets/custom_round_button.dart';

class CustomBottomSheet extends StatefulWidget {
 final String id;
  const CustomBottomSheet({Key? key, required this.id}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>{
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  Map<String, dynamic>? _taskMap;
  bool _isLoading = false;

  _func()async{
    _isLoading = true;
    _taskMap = await TaskOperations.getTaskData(widget.id);
    setState(() {
      _isLoading = false;
    });
  }

  _updateTask(){
    FocusScope.of(context).unfocus();
    var _isValid = _key.currentState!.validate();
    if(!_isValid){
      return;
    }
    _key.currentState!.save();
    Task _task = Task(id: _taskMap?['id'],title: _title, description: _description, time: DateTime.now().toString());
    TaskOperations.updateTask(_task, _taskMap?['id']);

    Navigator.of(context).pop();

  }
  @override
  void initState() {
    // TODO: implement initState
    _func();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height/1.5,
        padding: const EdgeInsets.all(10),
        child: _isLoading ? Center(child: CircularProgressIndicator(),) :Form(
          key: _key,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                child: TextFormField(
                  initialValue: _taskMap?['title'],
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
                  initialValue: _taskMap?['description'],
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
              CustomRoundButton(buttonText: 'UPDATE TASK', onPressed:_updateTask),
            ],
          ),
        ),
      ),
    );
  }
}
