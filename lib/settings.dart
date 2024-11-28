import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_queue/firebase/auth_service.dart';
import 'package:watch_queue/firebase/fire_store_service.dart';
import 'package:watch_queue/login.dart';
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
  FireStoreService fireStoreService = FireStoreService();
  AuthService authService = AuthService();
  DBHandler dbHandler = DBHandler();
  bool exportStatus = false;
  bool isExporting = false;
  bool importStatus = false;
  bool isImporting = false;

  List imdbIdList = [];
  List typeList = [];
  List nameList = [];
  List dateList = [];
  List releaseList = []; //movie released date
  List imgList = [];
  List statusList = []; //is movie
  bool _isButtonEnabled = false; //sync button enable or disable
  String _syncBtnText = 'Sync';
  bool _isUserLogged = false; // save user login status
  String _displayName = 'User';
  String _displayPicture = '';

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
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                            _displayPicture,
                          )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: Text(
                            '${quoteState(_time)} $_displayName!',
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
                            onPressed: _isUserLogged
                                ? () async {
                                    setState(() {
                                      authService.signOut();
                                      _isUserLogged = false;
                                      _isButtonEnabled = false;
                                      _syncBtnText = 'Sync';
                                    });
                                  }
                                : () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()),
                                    );
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
                              _isUserLogged ? 'Log Out' : 'Log In',
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
                                    'You can prevent data loss when reinstall the app by syncing watchlist with cloud.',
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
                              onPressed: _isButtonEnabled
                                  ? () {
                                      setState(() async {
                                        syncManager(
                                            authService, 'version_id01', true);
                                      });
                                    }
                                  : null,
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                              ),
                              child: Text(_syncBtnText),
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

  Future<VersionModel> getVersion(DBHandler dbHandler, String versionId) async {
    return await dbHandler.getVersion(versionId);
  }

  Future<bool> syncManager(
      AuthService authService, String versionId, bool isSync) async {
//isSync use for should sync or not data with cloud. true=sync,false=not sync
    User? user = await authService.getSignedUser();
    if (user != null) {
      String? email = user.email;
      DocumentSnapshot<Map<String, dynamic>> userDetails =
          await fireStoreService.getDocuments2('users', email!);
      Map<String, dynamic>? det = userDetails.data();
      _displayName = det?['dn'];
      _displayPicture = det?['dp'];
      setState(() {
        _isUserLogged = true;
        _syncBtnText = 'Sync';
        _isButtonEnabled = true;
      });

      VersionModel localVersion =
          await getVersion(dbHandler, versionId); //local db version code
      DocumentSnapshot<Map<String, dynamic>> docs = await fireStoreService
          .getDocuments2('todos', email); //cloud db version code

      Map<String, dynamic>? data = docs.data();
      int cloudVersion = 1;
      if (data != null) {
        cloudVersion = data[versionId]; //cloud db version code
      }
      if (localVersion.versionCode == cloudVersion) {
        //do not sync
        setState(() {
          _syncBtnText = 'Synced';
          _isButtonEnabled = false;
        });

        return false; //to notify button to disable.
      } else if (localVersion.versionCode > cloudVersion) {
        // export(user, versionId, localVersion.versionCode)
        if (mounted) {
          isSync
              ? showPopupDialog(
                  context,
                  export,
                  user,
                  versionId,
                  localVersion.versionCode,
                  'You have to export Wishlist to cloud. This process cannot be reversed. Do the sync process?')
              : null;
        }
        return true;
      } else {
        if (mounted) {
          isSync
              ? showPopupDialog(context, import, user, versionId, cloudVersion,
                  'You have to import data from cloud to your Wishlist. This process cannot be reversed. Do the sync process?')
              : null;
        }
        return true;
      }
    } else {
      setState(() {
        _isUserLogged = false;
        _syncBtnText = 'Sync';
        _isButtonEnabled = false;
      });
      showToast('you should login to sync data with cloud');
      return false;
    }
  }

  Future<void> import(
      User? user, String versionId, int cloudDbVersionCode) async {
    if (user != null) {
      setState(() {
        _syncBtnText = 'Syncing..';
        _isButtonEnabled = false;
      });
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
            await fireStoreService.getDocuments('todos', email!, 'movies');

        for (var movie in moviesFromCloud) {
          if (await dbHandler.isAvailable(movie['id'])) {
            dbHandler.updateTodo(TodosModel(
                id: movie['id'],
                type: movie['type'],
                name: movie['name'],
                img: movie['img'],
                releaseDate: movie['releaseDate'],
                listedDate: movie['listedDate'],
                watchStatus: toInt(movie['watchStatus'])));
          } else {
            dbHandler.insertTodo(TodosModel(
                id: movie['id'],
                type: movie['type'],
                name: movie['name'],
                img: movie['img'],
                releaseDate: movie['releaseDate'],
                listedDate: movie['listedDate'],
                watchStatus: toInt(movie['watchStatus'])));
          }
        }
        dbHandler
            .updateVersion(//update local db version code
                VersionModel(id: versionId, versionCode: cloudDbVersionCode))
            .whenComplete(() {
          setState(() {
            _syncBtnText = 'Synced';
            _isButtonEnabled = false;
          });
        });
      }
    } else {
      _isUserLogged = false;
      showToast('you should login 1st to sync data with cloud');
    }
  }

  Future<void> export(
      User? user, String versionId, int localDbVersionCode) async {
    if (user != null) {
      setState(() {
        _syncBtnText = 'Syncing..';
        _isButtonEnabled = false;
      });
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
        await fireStoreService.deleteCollection('todos', email!, 'movies');

        await fireStoreService.setMovies(email, imdbIdList, typeList, nameList,
            dateList, releaseList, imgList, statusList);
        await fireStoreService
            .setVersion(email, versionId, localDbVersionCode)
            .whenComplete(() {
          setState(() {
            _syncBtnText = 'Synced';
            _isButtonEnabled = false;
          });
        }); //update cloud db version code
      } else {
        //do something when data not found in database
        //toast message to show no data to export.
        setState(() {
          _syncBtnText = 'Sync';
          _isButtonEnabled = true;
        });
        showToast('local data not found');
      }
    } else {
      setState(() {
        _syncBtnText = 'Sync';
        _isButtonEnabled = false;
        _isUserLogged = false;
      });
      showToast('you should login to sync data with cloud');
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
    updateButtonState('version_id01');
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

  Future<void> updateButtonState(String versionId) async {
    await syncManager(authService, versionId, false);
  }

  void showPopupDialog(
      BuildContext context,
      void Function(User?, String, int) callBack,
      User? user,
      String versionId,
      int versionCode,
      String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          title: Text(
            'Warning',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 18.0),
          ),
          content: Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    callBack(user, versionId, versionCode);
                  },
                  child: const Text(
                    'Okay, Sync Now',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  )),
              FilledButton(
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0))),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
          ],
        );
      },
    );
  }
}
