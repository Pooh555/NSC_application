
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_field/image_field.dart';
import 'package:image_field/linear_progress_Indicator.dart';
import 'package:image_picker/image_picker.dart';

typedef Progress = Function(double percent);

class UploadRemoteImageForm extends StatefulWidget {
  const UploadRemoteImageForm({super.key, required this.title});
  final String title;
  @override
  State<UploadRemoteImageForm> createState() => _UploadRemoteImageFormState();
}

class _UploadRemoteImageFormState extends State<UploadRemoteImageForm> {
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  dynamic remoteFiles;

 
  Future<dynamic> uploadToServer(XFile? file,
      {Progress? uploadProgress}) async {
    //implement your code using Rest API or other technology
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                //Remote Image upload
                ImageField(
                    texts: const {
                      'fieldFormText': 'Upload to server',
                      'titleText': 'Upload to server'
                    },
                    defaultFiles: remoteFiles != null
                        ? remoteFiles!.map((image) {
                            return ImageAndCaptionModel(
                                file: image, caption: image.alt.toString());
                          }).toList()
                        : [],
                    remoteImage: true,
                    onUpload: (dynamic pickedFile,
                        ControllerLinearProgressIndicator?
                            controllerLinearProgressIndicator) async {
                      dynamic fileUploaded = await uploadToServer(
                        pickedFile,
                        uploadProgress: (percent) {
                          var uploadProgressPercentage = percent / 100;
                          controllerLinearProgressIndicator!
                              .updateProgress(uploadProgressPercentage);
                        },
                      );
                      return fileUploaded;
                    },
                    onSave: (List<ImageAndCaptionModel>? imageAndCaptionList) {
                      remoteFiles = imageAndCaptionList;
                    }),
      
              ],
            ),
     
        ));
  }