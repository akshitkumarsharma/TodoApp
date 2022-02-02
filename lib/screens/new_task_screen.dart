import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  DateTime? date = null;
  String taskName = "";
  TextEditingController dateController = TextEditingController();
  String repetitionFrequency = "No Repeat";
  List<String> options = [
    "No Repeat",
    "Once a Day",
    "Once a Day(Mon-Fri)",
    "Once a week",
    "Other",
  ];
  List<DropdownMenuItem<String>> dropdownItemCreater(List<String> itemValues) {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (int i = 0; i < itemValues.length; i++) {
      dropdownMenuItems.add(
        DropdownMenuItem<String>(
          value: itemValues[i],
          child: Text(itemValues[i]),
        ),
      );
    }
    return dropdownMenuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //task details
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
              height: 40,
            ),
            //date details
            Text(
              "Due Date",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      isDense: true,
                    ),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.calendar_today_outlined,
                  onPressed: () async {
                    var pickedDate = await showDatePicker(
                        context: context,
                        initialDate: date == null ? DateTime.now() : date!,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      date = pickedDate;
                      setState(() {});
                      var dateString =
                          DateFormat('EEEE, d MMM, yyyy').format(pickedDate);
                      dateController.text = dateString;
                    }

                    print(pickedDate);
                  },
                ),
                Visibility(
                  visible: date == null ? false : true,
                  child: CustomIconButton(
                    iconData: Icons.cancel,
                    onPressed: () {
                      date = null;
                      setState(() {});
                      dateController.text = "";
                    },
                  ),
                ),
              ],
            ),
            //time details
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      isDense: true,
                    ),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.calendar_today_outlined,
                  onPressed: () async {
                    var pickedDate = await showDatePicker(
                        context: context,
                        initialDate: date == null ? DateTime.now() : date!,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      date = pickedDate;
                      setState(() {});
                      var dateString =
                          DateFormat('EEEE, d MMM, yyyy').format(pickedDate);
                      dateController.text = dateString;
                    }

                    print(pickedDate);
                  },
                ),
                Visibility(
                  visible: date == null ? false : true,
                  child: CustomIconButton(
                    iconData: Icons.cancel,
                    onPressed: () {
                      date = null;
                      setState(() {});
                      dateController.text = "";
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Repeat",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            DropdownButton<String>(
              items: dropdownItemCreater(options),
              value: repetitionFrequency,
              onChanged: (String? chosenValue) {
                if (chosenValue != null) {
                  if (chosenValue != options.last) {
                    repetitionFrequency =
                        chosenValue == null ? repetitionFrequency : chosenValue;
                    setState(() {});
                  } else {
                    AlertDialog alert = AlertDialog(
                      content: Text("Content"),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {},
                        ),
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {},
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                }
              },
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
