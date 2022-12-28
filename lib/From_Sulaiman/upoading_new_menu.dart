import 'dart:io';

import 'package:bonapp_restaurant/Utils/fluttertoast.dart';
import 'package:bonapp_restaurant/services/calling_bike.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;

import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../api_class.dart';
import '../generated/l10n.dart';
import '../services/firbase.dart';

class AddNewMenuPage extends StatefulWidget {
  const AddNewMenuPage({Key? key}) : super(key: key);

  @override
  State<AddNewMenuPage> createState() => _AddNewMenuPageState();
}

class _AddNewMenuPageState extends State<AddNewMenuPage> {
  FirebaseAthentications database = FirebaseAthentications();
  TextEditingController firstController = TextEditingController();
  final List<TextEditingController> _controllers = [];
  final List<Row> _fields = [];
  late UploadTask? task;
  // TextEditingController controller = TextEditingController();

  // late Row field;

  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameController;
  // static List friendsList = [null];
  // var currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController photo = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController ingredientOne = TextEditingController();
  // final TextEditingController ingredientTwo = TextEditingController();
  // final TextEditingController ingredientThree = TextEditingController();
  ScrollController _scrolController = ScrollController();

  File? imageFile1;

  var url =
      'https://api.logmeal.es/v2/image/recognition/type/v1.0?skip_types=%5B1%2C3%5D&language=eng';

  String? foodType;
  getLabel(File image) async {
    List myImageSuggestions = [];
    // print('called');
    final inputImage = InputImage.fromFile(image);
    final ImageLabelerOptions options =
        ImageLabelerOptions(confidenceThreshold: 0.5);
    final imageLabeler = ImageLabeler(options: options);
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    double confindence = 0;
    String finalLabel = '';

    for (ImageLabel label in labels) {
      myImageSuggestions.add(ImageLabel);
      print(label.label);
      if (label.confidence > confindence) {
        confindence = label.confidence;
        finalLabel = label.label;
      }

      // print(
      //     'the name is ${label.label} and the confidence ${label.confidence}');
      // final String text = label.label;
      // final int index = label.index;
      // final double confidence = label.confidence;
      //
      // print(text);
    }
    print('the highest label is ${finalLabel}');
    return finalLabel;
  }

  // printImageLabels() async {
  //   List labels = await getLabel();
  //   for (ImageLabel label in labels) {
  //     print('coming from print image labels');
  //     print(label.label);
  //   }
  // }

  late String imageLink;

  Color buttonColor = Colors.green;

  var addMenuButtonController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    final saveButton = RoundedLoadingButton(
      successColor: Colors.green,
      errorColor: Colors.red,
      color: Colors.deepOrange,
      // padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.90,
      onPressed: () async {
        int a = 0;
        if (a == 0) {
          try {
            if (name.text.isNotEmpty ||
                desc.text.isNotEmpty ||
                price.text.isNotEmpty ||
                imageFile1!.path.isNotEmpty ||
                _controllers.isNotEmpty) {
              var downloadableUrl = await uploadFile();
              if (downloadableUrl != null) {
                bool isDone = await database.getLastMenNumber(
                    name.text,
                    desc.text,
                    price.text,
                    downloadableUrl.toString(),
                    firstController.text,
                    _controllers,
                    foodType ?? 'not available');
                if (isDone) {
                  addMenuButtonController.success();
                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.pop(context);
                } else {
                  addMenuButtonController.error();
                  addMenuButtonController.reset();

                  Fluttertoast.showToast(
                      msg: 'An error has occurred. please try again');
                }
              }
            } else {
              if (kDebugMode) {
                print('something is empty');
              }
            }
          } catch (e) {
            openFlutterToast(
                backGroundColor: Colors.green,
                gravity: ToastGravity.CENTER,
                context: context,
                errorMessage: S.of(context).pleaseFillIntheDestinationString);
            addMenuButtonController.error();
            await Future.delayed(Duration(
              milliseconds: 500,
            ));
            addMenuButtonController.reset();
            print('the error was from here');
            print(e.toString());
          }
        }
      },
      controller: addMenuButtonController,
      child: Text(
        S.of(context).saveButtonString,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );

    final nameField = TextFormField(
      autofocus: false,
      controller: name,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ('food name is required');
        }
        if (!regexp.hasMatch(value)) {
          return ("Food name can't be less than 3 char");
        }
      },
      onSaved: (value) {
        name.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.food_bank),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: S.of(context).foodName,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //=====================food name input filed ==============================//
    final ingredients = <TextFormField>[
      // thought of this but a little confuse
    ];

    //=====================food name input filed ==============================//
    final descField = TextFormField(
      autofocus: false,
      controller: desc,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ('food description is required');
        }
        if (!regexp.hasMatch(value)) {
          return ("Description can't be less than 3 char");
        }
      },
      onSaved: (value) {
        desc.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.fork_left),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: S.of(context).foodDescription,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //=====================food name input filed ==============================//
    final priceField = TextFormField(
      autofocus: false,
      controller: price,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ('food price is required');
        }
      },
      onSaved: (value) {
        price.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.attach_money),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: S.of(context).price,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final ingredientOneField = TextFormField(
      autofocus: false,
      controller: ingredientOne,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ('Ingredient is required');
        }
      },
      onSaved: (value) {
        ingredientOne.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // prefixIcon: Icon(Icons.),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Ingredient 1",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Menu Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height + (_fields.length * 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: nameField,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: priceField,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: descField,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex:
                            (MediaQuery.of(context).size.width * 0.90).round(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: firstController,
                            decoration: InputDecoration(
                              hintText:
                                  ' ${S.of(context).enterIngredient} ${'1'}',
                              prefixIcon: const Icon(
                                FontAwesomeIcons.mortarPestle,
                                color: Colors.grey,
                                size: 18,
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey, //this has no effect
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      addTextFieldButton(),
                    ],
                  ),
                  // Expanded(child: _listView()),
                  _listView(),
// Column(
// children: ingredients.map((ingredient) {
//   return  Expanded(
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ingredient,
//     ),
//   );
// }).toList(),
// ),
//***************************************************
// Row(
//   children: [
//     Expanded(
//         flex: 4, child: ingredientOneField),
//     Expanded(
//         flex: 1,
//         child: IconButton(
//           icon: const Icon(Icons.plus_one),
//           onPressed: () {},
//         ))
//   ],
// ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (name) {
                                return Container(
                                  color: Colors.grey,
                                  height: 200,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              _getImage(0);
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.camera_alt)),
                                        IconButton(
                                            onPressed: () {
                                              _getImage(1);
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                                FontAwesomeIcons.photoVideo)),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Text(S.of(context).choosePhotoString)),
                  ),
                  Visibility(
                    visible: true,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.grey),
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Card(
                          elevation: 7,
                          child: imageFile1 != null
                              ? Image.file(imageFile1!)
                              : Image.asset('images/menu.jpeg')),
                    ),
                  ),

                  // TextButton(
                  //   onPressed: () async {
                  //     API myApi = API();
                  //     myApi.getApi(imageFile1!);
                  //
                  //     // getLabel();
                  //   },
                  //   child: Text('Click'),
                  // ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: saveButton,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future dene(
    // String model_version,
    // String skip_type,
    // String language,
    File image,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 96b1c9959b46903a2b33b80587fee9ab4b1d7535'
    };
    var request = await http.Request('POST', Uri.parse(url));
    request.bodyFields = {
      'image': image.toString(),
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String data = await response.stream.bytesToString();
    print(data);
  }

  @override
  void dispose() {
    super.dispose();
    if (_controllers.isNotEmpty) {
      for (var controller in _controllers) {
        controller.dispose();
      }
    }

    // List<Widget> _getFriends() {
    //   List<Widget> friendsTextFields = [];
    //   for (int i = 0; i < friendsList.length; i++) {
    //     friendsTextFields.add(Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 16.0),
    //       child: Row(
    //         children: [
    //           // Expanded(child: FriendTextFields(i)),
    //           SizedBox(
    //             width: 16,
    //           ),
    //           // we need add button at last friends row
    //           _addRemoveButton(i == friendsList.length - 1, i),
    //         ],
    //       ),
    //     ));
    //   }
    //   return friendsTextFields;
    // }

    // Widget _addRemoveButton(bool add, int index) {
    //   return InkWell(
    //     onTap: () {
    //       if (add) {
    //         friendsList.insert(0, '');
    //       } else
    //         friendsList.removeAt(index);
    //       setState(() {});
    //     },
    //     child: Container(
    //       width: 30,
    //       height: 30,
    //       decoration: BoxDecoration(
    //         color: (add) ? Colors.green : Colors.red,
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //       child: Icon(
    //         (add) ? Icons.add : Icons.remove,
    //         color: Colors.white,
    //       ),
    //     ),
    //   );
    // }
  }

  _getImage(type) async {
    try {
      XFile? pickedFile;
      if (type == 0) {
        pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
        );
      } else {
        pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 1800,
          maxHeight: 1800,
        );
      }

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        foodType = await getLabel(imageFile);

        setState(() {
          imageFile1 = File(pickedFile!.path);
          if (mounted) {}
          if (kDebugMode) {
            print('$foodType form the food type ');
          }
        });
      } else {
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  uploadFile() async {
    final fileName = imageFile1;

    var baseName = Path.basename(fileName!.path);
    task = FirebaseApi.uploadFile(fileName, baseName);
    if (task != null) {
      final snapshot = await task?.whenComplete(() => {});
      final url = await snapshot?.ref.getDownloadURL();
      setState(() {
        imageLink = url!;
        // print(' the download url is ' + avatarImage);
      });
      return url;
    } else {
      return null;
    }
  }

// this list view is there to show the list of ingredients inside of the fields of textfields;
  Widget _listView() {
    if (_fields.isEmpty) {
      return Container(
        color: Colors.yellow,
      );
    } else {
      return SizedBox(
        height: _fields.length * 80,
        child: Column(
          children: _fields,
        ),

        // child: ListView.builder(
        //   controller: _scrolController,
        //   itemCount: _fields.length,
        //   itemBuilder: (context, index) {
        //     if (index == _fields.length) {
        //       return Container(
        //         height: 5,
        //       );
        //     }
        //     return Container(
        //       margin: EdgeInsets.all(5),
        //       child: _fields[index],
        //     );
        //   },
        // ),
      );
    }
  }

  addTextFieldButton() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width * 0.10,
      child: FloatingActionButton(
          backgroundColor: buttonColor,
          onPressed: () {
            var controller = TextEditingController();
            final field = Row(
              children: [
                Expanded(
                  flex: (MediaQuery.of(context).size.width * 0.90).round(),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText:
                          '${S.of(context).enterIngredient} ${_fields.length + 2}',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.mortarPestle,
                        color: Colors.grey,
                        size: 18,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey, //this has no effect
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: (MediaQuery.of(context).size.width * 0.10).round(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          child: const Icon(
                            Icons.remove,
                          ),
                          onPressed: () {
                            setState(() {
                              buttonColor = Colors.green;
                              _fields.removeLast();
                              // _fields.removeAt()
                              _controllers.removeLast();

                              // _scrolController.animateTo(
                              //     _scrolController.position.maxScrollExtent,
                              //     duration: Duration(milliseconds: 1000),
                              //     curve: Curves.bounceIn);
                            });
                          }),
                    ))
              ],
            );

            setState(() {
              if (_controllers.length <= 5) {
                buttonColor = Colors.green;
                _controllers.add(controller);

                _fields.add(field);
                // _scrolController.animateTo(
                //     _scrolController.position.maxScrollExtent,
                //     duration: Duration(microseconds: 300),
                //     curve: Curves.easeIn);
              } else {
                buttonColor = Colors.grey;
                Fluttertoast.showToast(
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  msg: 'You can\'t add more than 7 ingredients',
                );
              }
            });
          },
          child: Icon(
            Icons.add,
          )),
    );
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(File filename, destination) {
    try {
      final ref = FirebaseStorage.instance
          .ref('/menus')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(destination);
      return ref.putFile(filename);
    } catch (e) {
      print(e);
    }
  }
}
