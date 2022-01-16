import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/domains/models/task.dart';
import 'package:todo_app/domains/services/task_operations.dart';
import 'package:todo_app/pages/widgets/first_page_widgets/custom_bottom_sheet.dart';
import 'package:todo_app/pages/widgets/first_page_widgets/custom_positioned_button.dart';
 class TaskWidget extends StatelessWidget {
    const TaskWidget({Key? key}) : super(key: key);

  /*final List<Task> taskList = [
   Task(title: 'title', description: 'description', time: 'time'),
   Task(title: 'title', description: 'description', time: 'time'),
   Task(title: 'title', description: 'description', time: 'time'),
   Task(title: 'title', description: 'description', time: 'time'),
   Task(title: 'title', description: 'description', time: 'time'),
   Task(title: 'title', description: 'description', time: 'time'),
   Task(title: 'title', description: 'description', time: 'time'),
   ];*/

  _showTasks(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
   List<Task> taskList = snapshot.data!.docs.map((e) => Task(id: e["id"],title: e["title"], description: e["description"], time: e["time"])).toList();

   return ListView.builder(
    itemCount: taskList.length,
    scrollDirection: Axis.horizontal,
    itemBuilder: (ctx,index){
     return Stack(
      children: [
       Container(
        margin: const EdgeInsets.all(10),
        height: 250,
        width: 250,
        decoration: const BoxDecoration(
         color: Colors.amberAccent,
         borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40), bottomRight: Radius.circular(40),),
         boxShadow: [
          BoxShadow(
           color: Colors.amber,
           spreadRadius: 4,
           blurRadius: 6
          ),
          BoxShadow(
           color: Colors.white,
           spreadRadius: 1,
           blurRadius: 3
          ),
         ],
        ),
        child: Column(
         children: [
          Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Text(taskList[index].title, style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),),
           ],
          ),
          const Divider(),
          Text(taskList[index].description,style: GoogleFonts.roboto(fontSize: 20),)
         ],
        ),
       ),
       CustomPositionedButton(icon: Icons.edit_sharp, onPressed: (){
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10.0),
            ),
         builder: (_){
         return CustomBottomSheet(id: taskList[index].id,);
         }

        );
        /*TaskOperations.updateTask(taskList[index]);*/
       }, top: 0,right: 0,),
       CustomPositionedButton(icon: Icons.delete_sharp, onPressed: (){
        TaskOperations.deleteTask(taskList[index].id);
       }, bottom: 0,left: 0,),
      ],
     );
    },
   );
  }

   @override
   Widget build(BuildContext context) {
     return Container(
      height: 250,
      width: double.infinity,
      child: StreamBuilder(
       stream: TaskOperations.readAllTasks(),
       builder: (ctx,AsyncSnapshot<QuerySnapshot> snapShot){
        //int? size = snapShot.data?.size;
        if(snapShot.hasError){
         return const Center(child: Text('Something went wrong.'),);
        }else if(snapShot.data?.size == null || snapShot.data!.size ==0){
         return  Center(child: Text('No tasks found',style: GoogleFonts.merienda(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.white,),),);
        }else {
         return _showTasks(context,snapShot);
        }

       },
      ),
     );
   }
 }
