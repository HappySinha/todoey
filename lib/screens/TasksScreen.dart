import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/screens/TaskData.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.list,
                      size: 32,
                      color: Colors.lightBlueAccent,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Todoey',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text('${Provider.of<TaskData>(context).taskCount} Tasks',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                ),
                child: ListViewWidget(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTasks(),
            // isScrollControlled: true,
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddTasks extends StatelessWidget {
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var addTaskText;
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    onChanged: (value) {
                      addTaskText = value;
                    },
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<TaskData>(
                      context,
                      listen: false,
                    ).addTask(addTaskText);
                    textEditingController.clear();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final task = taskData.tasks[index];
            return ListTileWidget(
                isChecked: task.isDone,
                taskTitle: task.name,
                checkBoxCallBack: (bool? checkBoxState) {
                  taskData.updateTask(task);
                },
                longPressedCallBack: () {
                  taskData.deleteTask(task);
                });
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function(bool?) checkBoxCallBack;
  final Function() longPressedCallBack;

  ListTileWidget({
    required this.isChecked,
    required this.taskTitle,
    required this.checkBoxCallBack,
    required this.longPressedCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onLongPress: longPressedCallBack,
        title: Text(
          taskTitle,
          style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null),
        ),
        trailing: Checkbox(
          activeColor: Colors.blue,
          value: isChecked,
          onChanged: checkBoxCallBack,
        ));
  }
}
