import 'package:classroom/helper/constant.dart';
import 'package:classroom/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String email;
  Profile(this.email);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot studentSnapshot;

  // StudentInfo getStudentInfoFromDatasnapshot(DocumentSnapshot studentSnapshot) {
  //   StudentInfo questionModel = new StudentInfo();
  //   questionModel.fname = studentSnapshot["FirstName"];
  //   questionModel.lname = studentSnapshot["LastName"];

  //  return questionModel;
  //}

  // @override
  //void initState() {
  //  print("${widget.email}");
  // databaseService.getStudentData(widget.email).then((val) {
  //   studentSnapshot = val;
  //   setState(() {});
  //  });
  // super.initState();
  // }
  Stream<DocumentSnapshot> provideDocumentFieldStream(String email) {
    return FirebaseFirestore.instance
        .collection('Student Info')
        .doc(email)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: StreamBuilder<DocumentSnapshot>(
            stream: provideDocumentFieldStream(widget.email),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> documentFields = snapshot.data.data();
                return ProfileScreen(
                    documentFields['FirstName'],
                    documentFields['LastName'],
                    documentFields['Branch'],
                    documentFields['RollNo'],
                    documentFields['Semister']);
                //TODO Okay, now you can use documentFields (json) as needed
                //studentModel : getStudentInfoFromDatasnapshot(studentSnapshot)
              } else {
                return null;
              }
            }));
  }
}

//StreamBuilder<DocumentSnapshot>(
//    stream: provideDocumentFieldStream(),
//    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//        if (snapshot.hasData) {
//snapshot -> AsyncSnapshot of DocumentSnapshot
//snapshot.data -> DocumentSnapshot
//snapshot.data.data -> Map of fields that you need :)

//            Map<String, dynamic> documentFields = snapshot.data.data;
//TOO Okay, now you can use documentFields (json) as needed

//   return Text(documentFields['field_that_i_need']);
// }
//}
//)

//Container profileScreen(String fname) {
// return Container(
//  alignment: Alignment.center,
// height: 200,
// width: 200,
// child: Text(fname),
//   decoration: BoxDecoration(color: Colors.red),
// );
//}

class ProfileScreen extends StatelessWidget {
  final String fname, lname, branch, semister;
  final String rollno;

  ProfileScreen(
      this.fname, this.lname, this.branch, this.rollno, this.semister);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                  border: Border.all(
                      color: kSecondaryColor.withOpacity(0.2),
                      width: 0.3,
                      style: BorderStyle.solid)),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            fname,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Roll No: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: rollno,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))
                  ])),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            branch,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              alignment: Alignment.center,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: kSecondaryColor.withOpacity(0.02),
                      offset: Offset(0, 4),
                      blurRadius: 5,
                      spreadRadius: 5,
                    )
                  ]),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Attendence   ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '75 %',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ])),
            ),
          )
        ],
      ),
    ));
  }
}
