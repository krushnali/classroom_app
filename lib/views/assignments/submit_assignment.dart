//   import 'package:classroom/views/teacher_main_screen/teacher_main_screen.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// Future getPDFandUpload() async {
//     var rng = new Random();
//     String randomName = "";
//     for (var i = 0; i < 20; i++) {
//       print(rng.nextInt(100));
//       randomName = rng.nextInt(100).toString();
//     }
//     File file = await FilePicker.getFile(type: FileType.custom);
//     if (file == null) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => _isLoading
//                   ? Container(
//                       child: Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     )
//                   : TeacherMainScreen()));
//     }
//     _isLoading
//         ? Container(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           )
//         : TeacherMainScreen();
//     String fileName = '${randomName}.pdf';
//     savePdf(file.readAsBytesSync(), fileName);
//   }

//   savePdf(List<int> asset, String name) async {
//     StorageReference reference = FirebaseStorage.instance.ref().child(name);
//     StorageUploadTask uploadTask = reference.putData(asset);
//     String url = await (await uploadTask.onComplete).ref.getDownloadURL();
//     _isLoading = false;
//     documentFileUpload(url);
//     storeAssignmentDetail(url);
//   }

//   void documentFileUpload(String str) {
//     var data = {
//       "PDF": str,
//       "FileName": "My New File",
//     };
//     mainReference.child(createCryptoRandomString()).set(data).then((v) {
//       print("Store Successfully");
//     });
//   }

//   String createCryptoRandomString([int length = 32]) {
//     final Random _random = Random.secure();
//     var values = List<int>.generate(length, (i) => _random.nextInt(256));
//     return base64Url.encode(values);
//   }

//   _launchURL(String uRL) async {
//     String url = uRL;
//     if (await canLaunch(url)) {
//       _isLoading = true;
//       await launch(url, enableDomStorage: true);
//       _isLoading = false;
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
