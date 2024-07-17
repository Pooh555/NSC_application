import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nsc/disease.dart';
import 'package:nsc/home.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

double width = 0;

class ScanRoute extends StatefulWidget {
  const ScanRoute({super.key});

  @override
  ScanRouteState createState() => ScanRouteState();
}

class ScanRouteState extends State<ScanRoute> {
  AppTheme currentTheme = AppTheme(theme);
  File? selectedImage;
  String message = "";
  bool uploading = false;

  uploadImage(String collect) async {
    if (selectedImage == null) {
      setState(() {
        message = "Please select or take a photo to upload";
      });
      return;
    }

    setState(() {
      uploading = true;
    });

    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://equal-swine-wildly.ngrok-free.app/upload"),
    );

    request.fields['Collect'] = collect;

    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      selectedImage!.path,
    ));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final resJson = jsonDecode(response.body);
        setState(() {
          message = resJson['message'];
        });
      } else {
        setState(() {
          message =
              "Failed to upload image. Server returned status code ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        message = "An error occurred: $e";
      });
    } finally {
      setState(() {
        uploading = false;
      });
    }
  }

  Future getImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
        setState(() {});
      } else {
        //print("No image picked.");
      }
    } catch (e) {
      //print("Error picking image: $e");
    }
  }

  Future getImagefromcam() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
        setState(() {});
      } else {
        //print("No image picked.");
      }
    } catch (e) {
      //print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: currentTheme.textColor_1,
        ),
        title: const Text(
          "Scan Your Eye",
        ),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 3),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                selectedImage == null
                    ? Text(
                        "Please select or take a photo to upload",
                        style: TextStyle(
                          color: currentTheme.textColor_1,
                        ),
                      )
                    : Image.file(selectedImage!),
                const SizedBox(height: 20),
                uploading
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                        onPressed: () {
                          String collect;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Privacy Policy'),
                              content: const Text(
                                  'Do you agree that developer will collect your eye image for future AI model improvement?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    collect = '1';
                                    uploadImage(collect);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Agree'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    collect = '0';
                                    uploadImage(collect);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Disagree'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.cloud_upload,
                          size: 35,
                          color: AppTheme.textColor_3,
                        ),
                        label: RichText(
                          text: buildTextWithShadow(
                              'Upload Image',
                              useFontFamily,
                              fontSize_4,
                              AppTheme.textColor_3,
                              0.4),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: currentTheme
                              .color_3, // Use the button color from widget
                        ),
                      ),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: currentTheme.textColor_1,
                    fontSize: 20,
                  ),
                ),
                if (message == 'immature cataract(ต้อกระจกระยะเริ่มต้น)' ||
                    message == 'mature cataract(ต้อกระจกระยะรุนแรง)' ||
                    message == 'glaucoma(ต้อหิน)' ||
                    message == 'conjunctivitis(ตาแดง)')
                  ElevatedButton.icon(
                    onPressed: () {
                      if (message ==
                              'immature cataract(ต้อกระจกระยะเริ่มต้น)' ||
                          message == 'mature cataract(ต้อกระจกระยะรุนแรง)') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DiseasePage(
                                title: 'Cataract',
                                infoPath: 'assets/text/cataract.txt',
                                imagePath_1: 'assets/images/cataract_1.jpg',
                                imagePath_2: 'assets/images/cataract_2.png',
                                imagePath_3: 'assets/images/cataract_3.jpg'),
                          ),
                        );
                      }
                      if (message == 'glaucoma(ต้อหิน)') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DiseasePage(
                                title: 'Glaucoma',
                                infoPath: 'assets/text/glaucoma.txt',
                                imagePath_1: 'assets/images/glaucoma_1.jpg',
                                imagePath_2: 'assets/images/glaucoma_2.jpg',
                                imagePath_3: 'assets/images/glaucoma_3.jpg'),
                          ),
                        );
                      }
                      if (message == 'conjunctivitis(ตาแดง)') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DiseasePage(
                                title: 'Conjunctivitis',
                                infoPath: 'assets/text/conjunctivitis.txt',
                                imagePath_1:
                                    'assets/images/conjunctivitis_1.jpg',
                                imagePath_2:
                                    'assets/images/conjunctivitis_2.jpg',
                                imagePath_3:
                                    'assets/images/conjunctivitis_3.jpg'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("About your disease"),
                  ),
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: SizedBox(
              width: 75,
              height: 75,
              child: FloatingActionButton(
                onPressed: getImage,
                tooltip: "Select Image",
                backgroundColor: currentTheme.color_3,
                heroTag: "btn1",
                child: Icon(Icons.photo,
                    size: 35,
                    color: AppTheme
                        .textColor_3), // Ensure different hero tags for different FABs
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width - 185),
            child: SizedBox(
              width: 75,
              height: 75,
              child: FloatingActionButton(
                onPressed: getImagefromcam,
                tooltip: "Take a Photo",
                backgroundColor: currentTheme.color_3,
                heroTag: "btn2",
                child: Icon(Icons.camera_alt,
                    size: 35,
                    color: AppTheme
                        .textColor_3), // Ensure different hero tags for different FABs
              ),
            ),
          ),
        ],
      ),
    );
  }
}
