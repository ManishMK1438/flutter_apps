import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/domains/models/task.dart';

class TaskOperations{
  TaskOperations._(){}
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;
   CollectionReference collectionReference = fireStore.collection('tasks');

  static Stream<QuerySnapshot> readAllTasks(){
    CollectionReference collectionReference = fireStore.collection('tasks');
    //Future<QuerySnapshot> future = collectionReference.get();
    return collectionReference.snapshots();
  }

  static Future<String> addTask(Task task, String id) async {
    DocumentReference documentReference = fireStore.collection('tasks').doc(id);
    try{
      await documentReference.set(task.toJSON());
      return 'Task added successfully';
    }catch(error){
      print(error);
      return 'ERROR while adding Task ';
    }
  }

  static Future<Map<String, dynamic>?> getTaskData(String id) async{
    CollectionReference collectionReference = fireStore.collection('tasks');
    DocumentReference documentReference = collectionReference.doc(id);
    try{
      var data = await documentReference.get();
      print('${data.runtimeType}');
      print(data.get('id'));
      String id = data.get('id');
      String title = data.get('title');
      String description = data.get('description');
      //String time = data.get('time');
      Map<String, dynamic> taskMap = {
        'id': id,
        'title': title,
        'description': description
      };
      return taskMap;

    }catch(e){
      print(e.toString());
      return null;
    }

  }

  static Future<String> updateTask(Task task,String id) async {
    CollectionReference collectionReference = fireStore.collection('tasks');
    DocumentReference documentReference = collectionReference.doc(id);
    try{
      await documentReference.update(task.toJSON());
      return 'Task updated';
    }catch(error){
      print(error);
      return 'ERROR while adding Task ';
    }

  }
  static Future<String> deleteTask(String id) async {
    CollectionReference collectionReference = fireStore.collection('tasks');
    DocumentReference documentReference = collectionReference.doc(id);
    try{
      await documentReference.delete();
      return 'Task deleted';
    }catch(error){
      print(error);
      return 'ERROR while deleting Task ';
    }
  }
}