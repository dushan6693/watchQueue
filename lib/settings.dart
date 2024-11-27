import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:watch_queue/firebase/auth_service.dart';
import 'package:watch_queue/firebase/fire_store_service.dart';
import 'package:watch_queue/res/database/dbhandler.dart';
import 'package:watch_queue/res/database/todos_model.dart';
import 'package:watch_queue/res/database/version_model.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _time = 0;
  FireStoreService firestoreService = FireStoreService();
  AuthService authService = AuthService();
  DBHandler dbHandler = DBHandler();
  bool exportStatus = false;
  bool isExporting = false;
  bool importStatus = false;
  bool isImporting = false;
  bool isButtonEnabled = true; //sync button enable or disable
  List imdbIdList = [];
  List typeList = [];
  List nameList = [];
  List dateList = [];
  List releaseList = []; //movie released date
  List imgList = [];
  List statusList = []; //is movie
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Stack(alignment: Alignment.topRight, children: [
              Opacity(
                opacity: 0.5,
                child: Image.asset(
                  imageState(_time),
                  width: 300.0,
                  height: 100.0,
                  fit: BoxFit.none,
                  scale: 2,
                  alignment: Alignment.topRight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/smiley-african-woman-wearing-traditional-accessories_23-2148747966.jpg?t=st=1720456091~exp=1720459691~hmac=2b5f7672d242541838504bf687b7568b097acf520add92dd9ad26c6b44467295&w=740')),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: Text(
                            '${quoteState(_time)} Liyora!',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: OutlinedButton(
                            onPressed: () async {
                              authService.signOut();
                            },
                            style: OutlinedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 12.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                              ),
                            ),
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                SizedBox(
                    height: 80.0,
                    child: ColoredBox(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sync Wishlist',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    'You can prevent data loss by syncing watchlist with cloud',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            TextButton(
                              onPressed: isButtonEnabled
                                  ? () {
                                      syncManager(authService, true);
                                    }
                                  : null,
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                              ),
                              child: const Text('Sync'),
                            ),
                          ],
                        ),
                      ),
                    )),
                Divider(
                  height: 2.0,
                  thickness: 0.0,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<List<dynamic>> getTodos(DBHandler dbHandler) async {
    List<dynamic> custom = [];
    custom.add(await dbHandler.isAvailableAll());
    custom.add(await dbHandler.getTodos());
    return custom;
  }

  Future<VersionModel> getVersion(DBHandler dbHandler) async {
    return await dbHandler.getVersion('version_id01');
  }

  Future<bool> syncManager(AuthService authService, bool isSync) async {
//isSync use for should sync or not data with cloud. true=sync,false=not sync
    User? user = await authService.getSignedUser();
    String? email = user?.email;

    VersionModel localVersion =
        await getVersion(dbHandler); //local db version code
    DocumentSnapshot<Map<String, dynamic>> docs =
        await firestoreService.getDocuments2('todos', email!);

    Map<String, dynamic>? data = docs.data();
    int cloudVersion = 1;
    if (data != null) {
      cloudVersion = data['version_id01']; //cloud db version code
    }
    if (localVersion.versionCode == cloudVersion) {
      //do not sync
      return false; //to notify button to disable.
    } else if (localVersion.versionCode > cloudVersion) {
      isSync ? export(user) : null;
      return true;
    } else {
      isSync ? import(user) : null;
      return true;
    }
  }

  Future<void> import(User? user) async {
    if (user != null) {
      String? email = user.email;

      List<dynamic>? todos = await getTodos(dbHandler);

      if (todos[0]) {
        for (var todo in todos[1]!) {
          imdbIdList.add(todo.id);
          typeList.add(todo.type);
          nameList.add(todo.name);
          dateList.add(todo.listedDate);
          releaseList.add(todo.releaseDate);
          imgList.add(todo.img);
          statusList.add(fromInt(todo.watchStatus));
        }
      } else {
        List<Map<String, dynamic>> moviesFromCloud =
            await firestoreService.getDocuments('todos', email!, 'movies');
        for (var movie in moviesFromCloud) {
          dbHandler.insertTodo(TodosModel(
              id: movie['id'],
              type: movie['type'],
              name: movie['name'],
              img: movie['img'],
              releaseDate: movie['releaseDate'],
              listedDate: movie['listedDate'],
              watchStatus: toInt(movie['watchStatus'])));
         // print("___done");
        }
      }
    } else {
      showToast('you should login 1st to sync data with cloud');
    }
  }

  Future<void> export(User? user) async {
    if (user != null) {
      String? email = user.email;
      List<dynamic>? todos = await getTodos(dbHandler);

      if (todos[0]) {
        for (var todo in todos[1]!) {
          imdbIdList.add(todo.id);
          typeList.add(todo.type);
          nameList.add(todo.name);
          dateList.add(todo.listedDate);
          releaseList.add(todo.releaseDate);
          imgList.add(todo.img);
          statusList.add(fromInt(todo.watchStatus));
        }
        await firestoreService.deleteCollection('todos', email!, 'movies');

        await firestoreService.dataSync(email, imdbIdList, typeList, nameList,
            dateList, releaseList, imgList, statusList);
      } else {
        //do something when data not found in database
        //toast message to show no data to export.
        showToast('local data not found to export');
      }
    } else {
      showToast('you should login 1st to sync data with cloud');
    }
  }

  int toInt(bool status) {
    if (status) {
      return 1;
    } else {
      return 0;
    }
  }

  bool fromInt(int status) {
    if (status > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _updateHour();
    updateButtonState();
  }

  void _updateHour() {
    setState(() {
      _time = int.parse(DateFormat('kk').format(DateTime.now()).toString());
    });
  }

  String imageState(int state) {
    if (state >= 4 && state <= 11) {
      return 'lib/assets/images/weather_light.png';
    } else if (state >= 12 && state <= 18) {
      return 'lib/assets/images/weather_day.png';
    } else {
      return 'lib/assets/images/weather_dark.png';
    }
  }

  String quoteState(int state) {
    if (state >= 4 && state <= 11) {
      return 'Good morning';
    } else if (state >= 12 && state <= 18) {
      return 'Good afternoon';
    } else {
      return 'Good night';
    }
  }
  void showToast(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  Future<void> updateButtonState() async {
    bool result = await syncManager(authService, false);
    setState(() {
      isButtonEnabled = result;
    });
  }

}
