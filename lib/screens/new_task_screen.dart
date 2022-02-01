import 'package:flutter/material.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "What is to be done?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 10),
                      hintText: "Enter Task Here",
                    ),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.mic,
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Due Date",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                    ),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.calendar_today_outlined,
                  onPressed: () async {
                    var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.iconData,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 7),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size.zero),
      onPressed: onPressed,
      child: Icon(iconData),
    );
  }
}
