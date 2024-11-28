import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:watch_queue/res/database/dbhandler.dart';
import 'package:watch_queue/res/database/todos_model.dart';
import 'package:watch_queue/res/items/item_wishlist.dart';
import 'package:watch_queue/settings.dart';

import '../read_date.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List imdbIdList = [];
  List typeList = [];
  List nameList = [];
  List dateList = [];
  List releaseList = []; //movie released date
  List imgList = [];
  List statusList = []; //is movie watched or not
  ReadDate readDate = ReadDate();
  DBHandler dbHandler = DBHandler();
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
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
        future: getTodos(dbHandler, _searchController.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SpinKitThreeBounce(
              color: Theme.of(context).colorScheme.primary,
              size: 25.0,
            ),);
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Nothing here to show',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),fontSize: 18.0, fontWeight: FontWeight.w100),
            ));
          } else if (!snapshot.data?[0]) {
            return Center(
              child: Text(
                'mmm..your wishlist is empty',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),fontSize: 18.0, fontWeight: FontWeight.w100),
              ),
            );
          } else {
            List<dynamic>? todos = snapshot.data;
            for (var todo in todos?[1]!) {
              imdbIdList.add(todo.id);
              typeList.add(todo.type);
              nameList.add(todo.name);
              dateList.add(todo.listedDate);
              releaseList.add(todo.releaseDate);
              imgList.add(todo.img);
              statusList.add(fromInt(todo.watchStatus));
            }
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
                  child: SizedBox(
                    height: 50.0,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          clearLists();
                        });
                      },
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface,),
                      controller: _searchController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.primary,
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
                      for (var index = 0; index < nameList.length; index++)
                        Dismissible(
                            key: Key(nameList[index]),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              var map = <String, dynamic>{
                                'id': imdbIdList[index],
                                'type': typeList[index],
                                'name': nameList[index],
                                'img': imgList[index],
                                'release_date': releaseList[index],
                                'listed_date': dateList[index],
                                'watch_status': statusList[index],
                              };
                              setState(() {
                                dbHandler.deleteTodo(imdbIdList[index]);
                                clearLists();
                                //getTodos(dbHandler, _searchController.text);
                              });
                              showToast(dbHandler,
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
                              id: imdbIdList[index],
                              type: typeList[index],
                              name: nameList[index],
                              date: dateList[index],
                              img: imgList[index],
                              release: releaseList[index],
                              status: statusList[index],
                              markAsWatched: () {
                                setState(() {
                                  dbHandler.updateWatchStatus(
                                      toInt(true), imdbIdList[index]);
                                  statusList[index] = true;
                                  clearLists();
                                  Navigator.of(context).pop();
                                });
                              },
                              markAsUnwatched: () {
                                setState(() {
                                  dbHandler.updateWatchStatus(
                                      toInt(false), imdbIdList[index]);
                                  statusList[index] = false;
                                  clearLists();
                                  Navigator.of(context).pop();
                                });
                              },
                              deleteItem: () {
                                Navigator.of(context).pop();
                                var map = <String, dynamic>{
                                  'id': imdbIdList[index],
                                  'type': typeList[index],
                                  'name': nameList[index],
                                  'img': imgList[index],
                                  'release_date': releaseList[index],
                                  'listed_date': dateList[index],
                                  'watch_status': statusList[index],
                                };
                                //print('__________$map');
                                setState(() {
                                  dbHandler.deleteTodo(imdbIdList[index]);
                                  clearLists();
                                  //getTodos(dbHandler, _searchController.text);
                                });
                                showToast(dbHandler,
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
    imdbIdList.clear();
    typeList.clear();
    nameList.clear();
    dateList.clear();
    imgList.clear();
    releaseList.clear();
    statusList.clear();
  }

  void showToast(DBHandler dbHandler, String msg, String id, Map<String, dynamic> temp) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          clearLists();
          setState(()  {
             dbHandler.insertTodo(TodosModel(
                id: temp['id'],
                type: temp['type'],
                name: temp['name'],
                img: temp['img'],
                releaseDate: temp['release_date'],
                listedDate: temp['listed_date'],
                watchStatus: toInt(temp['watch_status']) ));
          });
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }
}
