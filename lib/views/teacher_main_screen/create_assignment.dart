import 'package:classroom/helper/constant.dart';
import 'package:classroom/services/database.dart';
import 'package:classroom/views/assignments/assignments.dart';
import 'package:classroom/views/assignments/create_questions.dart';

import 'package:classroom/widgets/appBar.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class CreateAssignments extends StatefulWidget {
  @override
  _CreateAssignmentsState createState() => _CreateAssignmentsState();
}

class _CreateAssignmentsState extends State<CreateAssignments> {
  String teacheremail, branch, semister, div, about, title, subject, assignId;
  DateTime pickeddate;
  final mainReference = FirebaseDatabase.instance.reference().child('Database');
  DatabaseService databaseService = new DatabaseService();

  Future storeAssignmentDetail() async {
    assignId = randomAlphaNumeric(16);
    Map<String, String> assignmentMap = {
      "assignmentTitle": title,
      "assignmentDescr": about,
      "assignmentSubject": "DBMS",
      "assignmentId": assignId,
      "dueDate": pickeddate.toString(),
      "forBranch": "Computer",
      "forSem": semister,
      "forDiv": div
    };
    databaseService.addAssignmentData(assignmentMap, assignId);
    databaseService.addAssignmentDataInBranch(
        assignmentMap, assignId, "Computer Engineering", semister, div);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickeddate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextFormField(
                          validator: (val) {
                            return val.isEmpty
                                ? "Enter Title of Assignment"
                                : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Title",
                          ),
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextFormField(
                          validator: (val) {
                            return val.isEmpty ? "Enter Description" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Description",
                          ),
                          onChanged: (val) {
                            about = val;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          title: Text(
                              "Due Date : ${pickeddate.day}/${pickeddate.month}/${pickeddate.year}"),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          onTap: _pickDate,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: 150,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: DropdownButton<String>(
                              items: [
                                DropdownMenuItem(
                                    value: "Sem 1", child: Text("Sem 1")),
                                DropdownMenuItem(
                                    value: "Sem 2", child: Text("Sem 2")),
                                DropdownMenuItem(
                                    value: "Sem 3", child: Text("Sem 3")),
                                DropdownMenuItem(
                                    value: "Sem 4", child: Text("Sem 4")),
                                DropdownMenuItem(
                                    value: "Sem 5", child: Text("Sem 5")),
                                DropdownMenuItem(
                                    value: "Sem 6", child: Text("Sem 6")),
                                DropdownMenuItem(
                                    value: "Sem 7", child: Text("Sem 7")),
                                DropdownMenuItem(
                                    value: "Sem 8", child: Text("Sem 8"))
                              ],
                              onChanged: (val) {
                                setState(() {});
                                semister = val;
                                print(semister);
                              },
                              hint: Text("Semester"),
                              value: semister,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Container(
                            width: 150,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: DropdownButton<String>(
                              items: [
                                DropdownMenuItem(
                                    value: "A", child: Text("Div A")),
                                DropdownMenuItem(
                                    value: "B", child: Text("Div B")),
                              ],
                              onChanged: (val) {
                                setState(() {});
                                div = val;
                                print(div);
                              },
                              hint: Text("Division"),
                              value: div,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.1),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        alignment: Alignment.center,
                        child: Text(
                          "Set Questions",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onTap: () {
                        storeAssignmentDetail();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CreateAssignmentQuestions()));
                      },
                    )
                  ],
                ),
              ),
            )));
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: pickeddate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 50));

    if (date != null) {
      setState(() {
        pickeddate = date;
        print(pickeddate);
      });
    }
  }
}
