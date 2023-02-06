import 'dart:async';


import 'package:bonapp_restaurant/From_Sulaiman/components/orders.dart' as orders;
import 'package:bonapp_restaurant/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore_platform_interface/src/platform_interface/platform_interface_index_definitions.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Provders/login_control.dart';
import '../../Provders/provider.dart';
import '../../Utils/languageFile.dart';
import '../../exceptionaHomeScreen.dart';
import '../../generated/l10n.dart';
import '../../services/firbase.dart';
import '../components/home.dart';
import '../components/menu.dart';
import '../components/orders.dart';
import '../components/settings.dart';
import '../components/support folder/support_page.dart';
import 'login_screen.dart';
import 'package:bonapp_restaurant/kvaribles.dart';


const List<String> list = <String>['English', 'French'];


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  updateToken() async {
    String? token;
    token = await _messaging.getToken();
    _firestore
        .collection('Restaurants')
        .doc(auth.currentUser?.uid)
        .set({'Token': token}, SetOptions(merge: true));
  }



  newVersions() async {
    final newVersion = NewVersion();

    final status = await newVersion.getVersionStatus();

    print('can update: ${status?.canUpdate}');
    print('local version ${status?.localVersion}');
    print('store version ${status?.storeVersion}');

    print(status?.storeVersion);
    print(status?.appStoreLink);
    if (status!.localVersion != status.storeVersion) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Update Available',
        dialogText:
            'You can now update this app from ${status.localVersion} to ${status.storeVersion}',
        updateButtonText: 'Update',
        dismissButtonText: 'Dismiss',
        // dismissAction: () => null,
      );
    }


  }

  ControlSignIn controlSignIn = ControlSignIn();
  late Timer timer;
  // this function is a timer that when a user has not gotten the latest version of the app. it remindes them every 10 minutes that they are using the app
  timerFunctionForUpdateReminder() {
    newVersions();
    Timer.periodic(Duration(minutes: 10), (timer) {
      timer = timer;
      if (controlSignIn.canSendAnotherUpdateMessage) {
        newVersions();
        controlSignIn.controlSendAnotherUpdateMesaage(false);

        print('coming from the timer');
      }
    });
  }







  @override
  void initState() {
getSavedLanguageSettings(context);
    super.initState();

    updateToken();
    Future.delayed(Duration.zero, () {

    });


  }

  // static late String selectedValue;
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _kBottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: const Icon(Icons.home), label: S.of(context).homeIconLabel),
      BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart),
          label: S.of(context).orderIconLabel),
      BottomNavigationBarItem(
          icon: const Icon(Icons.menu_book),
          label: S.of(context).menuIconLabel),
      BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.headset),
          label: S.of(context).supportIconLabel),
      BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: S.of(context).settingIconLabel),
    ];
    final _kTapPages = <Widget>[
      const Home(),
      const orders.Order(),
      Menu(
          // myKey: scaffoldKey,
          ),
      const SupportPage(),
      Setting(),
    ];

    assert(_kTapPages.length == _kBottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      backgroundColor: Color(0xffFF3F02),
      selectedItemColor: Colors.white,
      items: _kBottomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: MyDrawer(
          activeLanguage: '',
        ),

        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  await Future.delayed(const Duration(seconds: 1), () {
                    try {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialogLogout(context),
                      );
                    } on FirebaseException catch (e) {
                      Fluttertoast.showToast(msg: e.code);
                    }
                    setState(() {});
                  });
                },
                icon: const Icon(Icons.logout))
          ],
          backgroundColor: const Color(0xffFF3F02),
          title: kVaribles.appName,

          centerTitle: true,
          // leading: const Icon(Icons.notifications),
        ),
        // drawer: const DrawerNavBar(),
        body: _kTapPages[_currentTabIndex],
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }
}

class DropdownButtonDelete extends StatefulWidget {
  const DropdownButtonDelete({
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownButtonDelete> createState() => _DropdownButtonDeleteState();
}

class _DropdownButtonDeleteState extends State<DropdownButtonDelete> {
  // setPrefrence(value) async {
  //   String language = value;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('language', language);
  // }

  late String stateDropdownValue ;
  getPrefrenceLanguage() async {



    final _prefrences = await SharedPreferences.getInstance();
    setState(() {
      if (_prefrences.getString('language') == null) {
      } else {
        stateDropdownValue = _prefrences.getString('language')!;
      }
    });
  }

  @override
  void initState() {
    getPrefrenceLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // stateDropdownValue=Provider.of<MyProvider>(context,listen: false).currentLocale=='fr'?'French':"English";
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        return DropdownButton<String>(
          hint: Text(snapshot.data!.getString('language')??'Francais'),
          value: stateDropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 30,
            color: Colors.black,
          ),
          elevation: 16,
          style: TextStyle(color: Colors.grey.shade800),
          onChanged: (String? value) {
            // setActiveLanguageToDatabase(value);
            // setPrefrence(value);
            setLanguage(value!);
            setState(() {

              if (value == 'English') {
                stateDropdownValue = value;
                context.read<MyProvider>().changeLocale('en');

              }
            });

            if (value == 'French') {
              context.read<MyProvider>().changeLocale('fr');
            }
            setState(() {

              stateDropdownValue = value;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                // style: const TextStyle(
                //   color: Colors.white60,
                // ),
              ),
            );
          }).toList(),
        );
      }
    );
  }

  FirebaseFirestore firebase = FirebaseFirestore.instance;
  // setActiveLanguageToDatabase(language) async {
  //   await firebase
  //       .collection('Restaurants')
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .set({'active Locale': language}, SetOptions(merge: true));
  // }
}

class MyDrawer extends StatefulWidget {
  final String activeLanguage;
  MyDrawer({Key? key, required this.activeLanguage}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // width: 100,

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Restaurants')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text(
                      'Error with the databaase. try again later');
                } else if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return UserAccountsDrawerHeader(
                  accountName: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Restaurants')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text(
                              'Error with the database. try again later');
                        } else if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        } else {
                          return Text(snapshot.data?['Restaurant Name']);
                        }
                      }),
                  accountEmail:  Text(FirebaseAuth.instance.currentUser!.email!),

                  currentAccountPicture: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Restaurants')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text(
                              'Error with the databaase. try again later');
                        } else if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        return CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              snapshot.data?['profile image url'],
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                          ),
                        );
                      }),
                  decoration: const BoxDecoration(
                    color: Colors.white12,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/background.png'),
                    ),
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                shadowColor: Colors.black,
                elevation: 5,
                child: ListTile(
                  leading: const Icon(
                    Icons.bike_scooter,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: Text(S.of(context).callBikeButton,
                      style: const TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ExceptionalHomeScreen()));
                  },
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 2,
            height: 10,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  S.of(context).selectLanguageString,
                  // style: Theme.of(context).textTheme.labelMedium,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                )),
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 30),
                    child: DropdownButtonDelete(),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            height: 10,
            color: Colors.grey,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.grey.shade50,
            elevation: 0.2,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey.shade100),
              ),
              onLongPress: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context),
                );
              },
              onPressed: () {
                Fluttertoast.showToast(
                  msg: S.of(context).pressAndHoldString,
                  backgroundColor: Colors.red,
                );
              },
              child: Text(
                S.of(context).deleteAccountString,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }

  late String currentActiveLocal;
  getLocal() async {
    await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => {
              setState(() {
                currentActiveLocal = value['active Locale'];
              }),
              print('active local is $currentActiveLocal'),
            });
  }

  @override
  void initState() {
    super.initState();
    getLocal();
  }
}

class EditProfilePage extends StatelessWidget {
  final FirebaseAuthentications firebaseAuthentications =
      FirebaseAuthentications();

  EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context),
                  );
                  // try {
                  //
                  //   var currentUser = await FirebaseAuth.instance.currentUser;
                  //   if (currentUser != null) {
                  //     currentUser
                  //         .delete()
                  //         .then((value) =>
                  //             {firebaseAuthentications.logoutUser(context)})
                  //         .then((value) => {
                  //               Fluttertoast.showToast(
                  //                   msg:
                  //                       'your account was deleted successfully',
                  //                   gravity: ToastGravity.TOP)
                  //             });
                  //   } else {
                  //     Fluttertoast.showToast(
                  //         msg: 'Please Sign again to complete the action');
                  //   }
                  // } on FirebaseException catch (e) {
                  //   Fluttertoast.showToast(msg: e.message.toString());
                  // }
                },
                child: const Text('Delete Account'))
          ],
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  FirebaseAuthentications firebaseAuthentications = FirebaseAuthentications();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Colors.white,
    // shape: ShapeBorder
    title: Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              S.of(context).areYouSureYouWantToDeleteAccountString,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
        const Icon(
          Icons.delete,
          color: Colors.deepOrange,
        )
      ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).precautionString,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(
              //   width: 2,
              //   color: Colors.deepOrangeAccent,
              // ),
            ),
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent),
              onPressed: () async {
                FirebaseAuthentications firebaseService=FirebaseAuthentications();
                   firebaseService.deleteRestaurantFilesFromStorage(context);




                //     .then((value) {
                //   if (value!.isNotEmpty) {
                //     print("Subfolder exists");
                //   } else {
                //     print("Subfolder does not exist");
                //   }
                // }).catchError((error) {
                //   print("Subfolder does nottt exist");
                // });


                // //check if the restaurant has menus uploaded;
                // Future<Uint8List?> menu=   storage.ref().child('/menus/${auth.currentUser!.uid}').getData();
                // print(menu);
                //


                // deleteRestaurantFilesFromStorage();








              },
              child: Text(S.of(context).yestImSureString,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 10),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: Colors.deepOrangeAccent)),
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                EasyLoading.show(indicator: CircularProgressIndicator());
                Navigator.pop(context);
                EasyLoading.dismiss();
              },
              child: Text(S.of(context).noDontDelete,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        )
      ],
    ),
    // actions: <Widget>[
    //   TextButton(
    //     onPressed: () {
    //       Navigator.of(context).pop();
    //     },
    //     child: const Text(
    //       'Delete',
    //       style: TextStyle(
    //         color: Colors.black,
    //       ),
    //     ),
    //     style: TextButton.styleFrom(backgroundColor: Colors.red),
    //   ),
    //   TextButton(
    //     onPressed: () {
    //       Navigator.of(context).pop();
    //     },
    //     child: const Text('Close'),
    //   ),
    // ],
  );
}

Widget _buildPopupDialogLogout(BuildContext context) {
  var signOutController = RoundedLoadingButtonController();
  var cancelButtonController = RoundedLoadingButtonController();
  return AlertDialog(
    title: const Text(
      'Êtes-vous sûr de vouloir vous déconnecter?',
      style: TextStyle(
        fontSize: 14,
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // children: <Widget>[
      //   Text("He"),
      // ],
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RoundedLoadingButton(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.3,
            color: Colors.red,
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) async => {
                    signOutController.success(),
                    await Future.delayed(const Duration(seconds: 1)),
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                  });
            },
            // : Theme.of(context).primaryColor,
            controller: signOutController,
            child: Text(S.of(context).logOuntString),
          ),
          const SizedBox(
            width: 10,
          ),
          RoundedLoadingButton(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.3,
            color: Colors.green,
            onPressed: () {
              Navigator.of(context).pop();
            },
            // style: ElevatedButton.styleFrom(backgroundColor: Colors.green),

            // : Theme.of(context).primaryColor,
            controller: cancelButtonController,
            child: Text(S.of(context).cancelString),
          ),
        ],
      )
    ],
  );
}
