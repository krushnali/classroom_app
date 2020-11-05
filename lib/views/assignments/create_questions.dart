import 'package:classroom/widgets/appBar.dart';
import 'package:flutter/material.dart';

class CreateAssignmentQuestions extends StatefulWidget {
  @override
  _CreateAssignmentQuestionsState createState() =>
      _CreateAssignmentQuestionsState();
}

class _CreateAssignmentQuestionsState extends State<CreateAssignmentQuestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: Container(
          color: Colors.red,
        ));
  }
}
