import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:watch_queue/StreamBloc.dart';
import 'package:watch_queue/res/database/dbhandler.dart';
import 'package:watch_queue/res/database/todos_model.dart';
import 'package:watch_queue/res/items/item_wishlist.dart';
import 'package:watch_queue/settings.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List _imdbIdList = [];
  List _typeList = [];
  List _nameList = [];
  List _dateList = [];
  List _releaseList = []; //movie released date
  List _imgList = [];
  List _statusList = []; //is movie watched or not
  DBHandler _dbHandler = DBHandler();
  StreamBloc _streamBloc = StreamBloc();

  String _title = 'Wishlist';
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$_title'),
            StreamBuilder<Object>(
                stream: _streamBloc.stateStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      ' (${snapshot.data})',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    );
                  } else {
                    return Text('');
                  }
                }),
          ],
        ),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: FutureBuilder(
        future: getTodos(_dbHandler, _searchController.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitThreeBounce(
                color: Theme.of(context).colorScheme.primary,
                size: 25.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Nothing here to show',
              style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w100),
            ));
          } else if (!snapshot.data?[0]) {
            return Center(
              child: Text(
                'mmm..your wishlist is empty',
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.3),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w100),
              ),
            );
          } else {
            List<dynamic>? todos = snapshot.data;
            for (var todo in todos?[1]!) {
              _imdbIdList.add(todo.id);
              _typeList.add(todo.type);
              _nameList.add(todo.name);
              _dateList.add(todo.listedDate);
              _releaseList.add(todo.releaseDate);
              _imgList.add(todo.img);
              _statusList.add(fromInt(todo.watchStatus));
            }
            _streamBloc.eventStreamSink.add(getCount());
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
                  child: SizedBox(
                    height: 50.0,
                    child: TextField(
                      onEditingComplete: () {
                        setState(() {
                          clearLists();
                        });
                      },
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      controller: _searchController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2.0,
                                style: BorderStyle.solid)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                                width: 2.0,
                                style: BorderStyle.solid)),
                        hintText: "Filter",
                        hintStyle: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView(
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 10 / 2.2,
                      crossAxisSpacing: 0.5,
                      mainAxisSpacing: 0.5,
                    ),
                    padding: const EdgeInsets.all(2.0),
                    children: [
                      for (var index = 0; index < _nameList.length; index++)
                        Dismissible(
                            key: Key(_nameList[index]),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              var map = <String, dynamic>{
                                'id': _imdbIdList[index],
                                'type': _typeList[index],
                                'name': _nameList[index],
                                'img': _imgList[index],
                                'release_date': _releaseList[index],
                                'listed_date': _dateList[index],
                                'watch_status': _statusList[index],
                              };
                              setState(() {
                                _dbHandler.deleteTodo(_imdbIdList[index]);
                                clearLists();
                                //getTodos(dbHandler, _searchController.text);
                              });
                              showToast(
                                  _dbHandler,
                                  '${map['type']} deleted from wishlist',
                                  map['id'],
                                  map);
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: ItemWishList(
                              id: _imdbIdList[index],
                              type: _typeList[index],
                              name: _nameList[index],
                              date: _dateList[index],
                              img: _imgList[index],
                              release: _releaseList[index],
                              status: _statusList[index],
                              markAsWatched: () {
                                setState(() {
                                  _dbHandler.updateWatchStatus(
                                      toInt(true), _imdbIdList[index]);
                                  _statusList[index] = true;
                                  clearLists();
                                  Navigator.of(context).pop();
                                });
                              },
                              markAsUnwatched: () {
                                setState(() {
                                  _dbHandler.updateWatchStatus(
                                      toInt(false), _imdbIdList[index]);
                                  _statusList[index] = false;
                                  clearLists();
                                  Navigator.of(context).pop();
                                });
                              },
                              deleteItem: () {
                                Navigator.of(context).pop();
                                var map = <String, dynamic>{
                                  'id': _imdbIdList[index],
                                  'type': _typeList[index],
                                  'name': _nameList[index],
                                  'img': _imgList[index],
                                  'release_date': _releaseList[index],
                                  'listed_date': _dateList[index],
                                  'watch_status': _statusList[index],
                                };
                                //print('__________$map');
                                setState(() {
                                  _dbHandler.deleteTodo(_imdbIdList[index]);
                                  clearLists();
                                  //getTodos(dbHandler, _searchController.text);
                                });
                                showToast(
                                    _dbHandler,
                                    '${map['type']} deleted from wishlist',
                                    map['id'],
                                    map);
                              },
                            ))
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<List<dynamic>> getTodos(DBHandler dbHandler, String filter) async {
    List<dynamic> custom = [];
    custom.add(await dbHandler.isAvailableAll());

    if (filter.isEmpty) {
      custom.add(await dbHandler.getTodos());
      return custom;
    } else {
      custom.add(await dbHandler.getTodosLike(filter));
      return custom;
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

  void clearLists() {
    _imdbIdList.clear();
    _typeList.clear();
    _nameList.clear();
    _dateList.clear();
    _imgList.clear();
    _releaseList.clear();
    _statusList.clear();
  }

  void showToast(
      DBHandler dbHandler, String msg, String id, Map<String, dynamic> temp) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          clearLists();
          setState(() {
            dbHandler.insertTodo(TodosModel(
                id: temp['id'],
                type: temp['type'],
                name: temp['name'],
                img: temp['img'],
                releaseDate: temp['release_date'],
                listedDate: temp['listed_date'],
                watchStatus: toInt(temp['watch_status'])));
          });
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  int getCount() {
    if (_imdbIdList.isEmpty) {
      return 0;
    } else {
      return _imdbIdList.length;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }
}
