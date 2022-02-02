import "package:flutter/material.dart";
import "routing.dart" as routing;
import "package:todo_app/sqlite.dart";
import "package:todo_app/task.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Task>> taskList = SqliteDB.getAllTasks();
  //FutureBuilder

  /*Widget futureBuilderProvider() {
    return (FutureBuilder<List<Task>>(
      future: taskList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Text("I Have Data");
        } else if (snapshot.hasError) {
          Text("Some error");
        } else {
          //if future has not returned
          Text("Waiting");
        }
        return Container();
      },
    ));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //onPressed: (){},
        child: const Icon(Icons.add, size: 35),
        onPressed: () {
          Navigator.pushNamed(context, routing.newTaskScreenID);
        },
      ),
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: FutureBuilder<List<Task>>(
        future: taskList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            List<Widget> children = [];
            for (var task in data) {
              children.add(ActivityCard(
                  header: task.taskName,
                  date: task.deadlineDate == null
                      ? ""
                      : task.deadlineDate.toString(),
                  list: task.taskListID.toString()));
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
  }
}

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    required this.header,
    required this.date,
    required this.list,
    Key? key,
  }) : super(key: key);

  final String header, date, list;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                onChanged: (value) {},
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
    );
  }
}
