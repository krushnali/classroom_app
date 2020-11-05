import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  // Future<void> addUsersData(Map studentData, String studentId) async {
  //   await FirebaseFirestore.instance
  //       .collection("Student Info")
  //       .doc(studentId)
  //       .set(studentData)
  //       .catchError((e) {a
  //     print(e.toString());
  //   });
  // }

  Future<void> addFieldsData(
      {String branch,
      String semester,
      String studentEmail,
      String div,
      Map studentData}) async {
    await FirebaseFirestore.instance
        .collection("Branch")
        .doc(branch)
        .collection(semester)
        .doc(div)
        .collection("Student Info")
        .doc(studentEmail)
        .set(studentData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> setUserData({Map studentData, String studentEmail}) async {
    await FirebaseFirestore.instance
        .collection("Student Info")
        .doc(studentEmail)
        .set(studentData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addResult(Map result, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("Results")
        .add(result)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QuestionsData")
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QuestionsData")
        .get();
  }

  Future<void> addAssignmentData(
      Map assignmentData, String assignmentId) async {
    await FirebaseFirestore.instance
        .collection("Assignments")
        .doc(assignmentId)
        .set(assignmentData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addAssignmentDataInBranch(
      Map assignmentData,
      String assignmentId,
      String branch,
      String semister,
      String division) async {
    await FirebaseFirestore.instance
        .collection("Branch")
        .doc(branch)
        .collection(semister)
        .doc(division)
        .collection("Assignments")
        .doc(assignmentId)
        .set(assignmentData)
        .catchError((e) {
      print(e.toString());
    });
  }
}

getStudentData(String email) async {
  return await FirebaseFirestore.instance
      .collection("Student Info")
      .doc(email)
      .get();
}
