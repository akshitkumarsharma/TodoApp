import "package:flutter/material.dart";
import "routing.dart" as routing;
import "package:todo_app/sqlite.dart";
import "package:todo_app/task.dart";
import 'package:provider/provider.dart';
import "package:todo_app/shared_data.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Task>> taskList = SqliteDB.getAllPendingTasks();
  //FutureBuilder

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedData>(
      builder: (context, sd, x) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            //onPressed: (){},
            child: const Icon(Icons.add, size: 35),
            onPressed: () {
              Navigator.pushNamed(context, routing.newTaskScreenID);
            },
          ),
          appBar: AppBar(
            title: Text(sd.x.toString()),
          ),
          body: FutureBuilder<List<Task>>(
            future: taskList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                List<Widget> children = [];
                for (var task in data) {
                  children.add(ActivityCard(
                    task: task,
                    header: task.taskName,
                    date: task.deadlineDate == null
                        ? ""
                        : task.deadlineDate.toString(),
                    list: task.taskListID.toString(),
                    onTap: () {
                      Navigator.pushNamed(context, routing.newTaskScreenID,
                          arguments: task);
                    },
                  ));
                }
                return ListView(
                  padding: const EdgeInsets.all(5),
                  children: children,
                );
              } else if (snapshot.hasError) {
                return Container(child: Text("Some error"));
              } else {
                //if future has not returned
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          /*ListView(
          padding: const EdgeInsets.all(5),
          children: const [
            /*ActivityCard(header: "Pay fees", date: "3rd Jan", list: "Pay bills"),
            ActivityCard(header: "Pay bill", date: "4th Jan", list: "Pay bills"),
            ActivityCard(
                header: "Do recharge", date: "4th Jan", list: "Pay bills"),
            ActivityCard(header: "Wake up", date: "4th Jan", list: "Daily"),
            ActivityCard(header: "Wake up", date: "4th Jan", list: "Daily"),
            ActivityCard(header: "Wake up", date: "4th Jan", list: "Daily"),
            ActivityCard(header: "Wake up", date: "4th Jan", list: "Daily"),
            ActivityCard(header: "Wake up", date: "4th Jan", list: "Daily"),
            ActivityCard(header: "Wake up", date: "4th Jan", list: "Daily"),
            ActivityCard(header: "Wake up", date: "4th Jan", list: "Daily"),*/
          ],
        ),*/
        );
      },
    );
  }
}

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    required this.header,
    required this.date,
    required this.list,
    required this.onTap,
    required this.task,
    Key? key,
  }) : super(key: key);

  final String header, date, list;
  final void Function() onTap;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  onChanged: (value) async {
                    task.isFinished = true;
                    await SqliteDB.updateTask(task);
                    Navigator.pushNamedAndRemoveUntil(
                        context, routing.homeScreenID, (route) => false);
                  },
                  value: false,
                ),
              ),
              Container(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    header,
                    style: TextStyle(
                      //color, fontsize, fontweight
                      color: Colors.orange,
                      //fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(date),
                  Text(list),
                ],
              ),
            ],
          ),
        ),
        color: Colors.yellow,
      ),
    );
  }
}
