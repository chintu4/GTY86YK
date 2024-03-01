import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toto/screen/page2.dart';
import "package:toto/global.dart";
import "dart:developer";
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import "dart:io";

// Function to pick an image from the device
Future<XFile?> pickImage() async {
  final picker = ImagePicker();
  XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<String> uploadImageToFirestore(XFile imageFile) async {
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child('images')
      .child('image.jpg');
  await ref.putFile(File(imageFile.path));
  return await ref.getDownloadURL();
}

class Add_Widget extends StatefulWidget {
  const Add_Widget({super.key});

  @override
  State<Add_Widget> createState() => _Add_WidgetState();
}

class _Add_WidgetState extends State<Add_Widget> {
  TextEditingController textfield = new TextEditingController();
  void func() {
//hello
  }
  bool justsave = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Assignment App"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.green[50],
                  padding: EdgeInsets.all(8.0),
                  child: (gl.setText != 1 &&
                          gl.setImage != 2 &&
                          gl.setButton != 3)
                      ? (Center(child: Text("No Widget is Added")))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility(
                                visible: justsave,
                                child: Center(
                                  child: Text("Add at least widget to save "),
                                )),
                            Visibility(
                              visible: (gl.setText == 1),
                              child: TextField(
                                enabled: (gl.setText == 1),
                                controller: textfield,
                              ),
                            ),
                            Visibility(
                              visible: (gl.setImage == 2),
                              child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.grey,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: Center(
                                    child: MaterialButton(
                                      onPressed: () async {
                                        XFile? pickedImage = await pickImage();
                                        if (pickedImage != null) {
                                          String imageUrl =
                                              await uploadImageToFirestore(
                                                  pickedImage);
                                          log('Image uploaded to Firestore. URL: $imageUrl');
                                        } else {
                                          log('No image picked');
                                        }
                                      },
                                      child: Text('Upload Image'),
                                    ),
                                  )),
                            ),

                            //save button
                            Visibility(
                              visible: gl.setButton == 3,
                              child: TextButton(
                                style: ButtonStyle(
                                  alignment: Alignment.center,
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.green[200]),
                                  side: MaterialStateProperty.all(
                                      BorderSide(color: Colors.black)),
                                ),
                                child: Text("save"),
                                onPressed: () {
                                  if ((gl.setText != 1 || gl.setImage != 2) &&
                                      gl.setText != 3) {
                                    setState(() {
                                      justsave = true;
                                    });
                                  } else {
                                    gl.saved = true;

                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc('1')
                                        .set({
                                      "text": textfield.text.toString()
                                    });
                                    textfield.clear();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text('Successfully Added'),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  child: Text(" Add Widgets "),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Page2()));
                  },
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.green[200]),
                    side: MaterialStateProperty.all(
                        BorderSide(color: Colors.black)),
                  ),
                ),
              ]),
        ));
  }
}
