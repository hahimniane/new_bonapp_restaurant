import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io';

import '../../services/firbase.dart';

class SaveCoverPhotoPage extends StatefulWidget {
  var imageUrl;
  SaveCoverPhotoPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<SaveCoverPhotoPage> createState() => _SaveCoverPhotoPageState();
}

class _SaveCoverPhotoPageState extends State<SaveCoverPhotoPage> {
  FirebaseAthentications firebaseClass = FirebaseAthentications();
  late UploadTask? task;

  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return loader
        ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const ListTile(
                title: Center(
                    child: Text(
                  'Review cover photo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                leading: Text(
                  'cancel',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            body: Center(
              child: Stack(clipBehavior: Clip.none, children: [
                Center(
                  child: Image.file(widget.imageUrl),
                ),
                Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator()),
                ),
              ]),
            ))
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: const Center(
                      child: Text(
                    'Review cover photo',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  leading: const Text(
                    'cancel',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          loader = true;
                        });
                        String result = await uploadFile(widget.imageUrl);
                        if (result != null) {
                          firebaseClass.uploadRestaurantCoverPhoto(result);
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        print('A problem occured');
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.file(widget.imageUrl),
                ),
              ],
            ),
          );
  }

  uploadFile(
    File theImageFile,
  ) async {
    final fileName = theImageFile;
    var fileBaseName = basename(fileName.path);
    final destination = '${FirebaseAuth.instance.currentUser?.uid}';
    task = FirebaseApi.uploadFile(fileName, destination);
    if (task != null) {
      final snapshot = await task?.whenComplete(() => {});
      final url = await snapshot?.ref.getDownloadURL();
      setState(() {
        loader = false;
      });
      return url;
    } else {
      return null;
    }
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(File filename, String destination) {
    try {
      final ref =
          FirebaseStorage.instance.ref('/Main Menu photo').child(destination);
      return ref.putFile(filename);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
