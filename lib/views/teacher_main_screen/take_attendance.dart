import 'package:classroom/helper/constant.dart';
import 'package:classroom/services/database.dart';
import 'package:classroom/views/quiz/playquiz.dart';
import 'package:classroom/widgets/appBar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Quiz").snapshots(),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot course = snapshot.data.documents[index];
                    return QuizTile(
                        course['quizDescription'],
                        course['quizImageURL'],
                        course['quizTitle'],
                        course['quizId']);
                  });
        },
      ),
    );
  }

  // @override
  // void initState() {
  //   databaseService.getQuizData().then((val) {
  //     setState(() {
  //       quizStream = val;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Container(
          color: kSecondaryColor.withOpacity(0.01), child: quizList()),
      //floatingActionButton: FloatingActionButton(
      // backgroundColor: kPrimaryColor,
      // child: Icon(Icons.add),
      // onPressed: () {
      //  Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => CreateQuiz()));
      // },
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgURL, title, desc, id;
  QuizTile(this.desc, this.imgURL, this.title, this.id);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayQuiz(id)));
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.only(bottom: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imgURL,
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(20, 20, 20, 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
