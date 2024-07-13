import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ScanRoute extends StatefulWidget {
  const ScanRoute({super.key, required this.title});

  final String title;

  @override
  ScanRouteState createState() => ScanRouteState();
}

class ScanRouteState extends State<ScanRoute> {
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 30,
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/wallpaper/abstract.2.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 3),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                selectedImage == null
                    ? const Text(
                        "Please select or take a photo to upload",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
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
                        icon: const Icon(Icons.cloud_upload),
                        label: const Text("Upload Image"),
                      ),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                /*
                if (message == 'cataract' ||
                    message == 'cataract' ||
                    message == 'conjunctivitis')
                  ElevatedButton.icon(
                    onPressed: () {
                      if (message == 'cataract') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CataractRoute(title: 'Cataract'),
                          ),
                        );
                      }
                      if (message == 'glaucoma') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const GlaucomaRoute(title: 'Glaucoma'),
                          ),
                        );
                      }
                      if (message == 'conjunctivitis') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConjunctivitisRoute(
                                title: 'Conjunctivitis'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("About your disease"),
                  ),
                  */
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: getImage,
            tooltip: "Select Image",
            child: const Icon(Icons.photo),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: getImagefromcam,
            tooltip: "Take a Photo",
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
