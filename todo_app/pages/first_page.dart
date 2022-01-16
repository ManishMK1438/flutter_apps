import 'package:flutter/material.dart';
import 'package:todo_app/domains/models/user.dart';
import 'package:todo_app/pages/add_task_screen.dart';
import 'package:todo_app/pages/widgets/first_page_widgets/date.dart';
import 'package:todo_app/pages/widgets/first_page_widgets/footer.dart';
import 'package:todo_app/pages/widgets/first_page_widgets/task_widget.dart';
import 'package:todo_app/pages/widgets/first_page_widgets/top_bar.dart';
import 'package:todo_app/pages/widgets/first_page_widgets/wave.dart';

class FirstPage extends StatelessWidget {
  final User? user;
  final dynamic json; // testing purpose only
  const FirstPage({Key? key, this.user, this.json}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wave(
                user: user,
              ),
              const ShowDate(),
              const SizedBox(height: 10,),
              const TaskWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddTask()));
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
