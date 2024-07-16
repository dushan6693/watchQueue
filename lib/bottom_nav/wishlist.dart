import 'package:flutter/material.dart';
import 'package:watch_queue/res/database/dbhandler.dart';
import 'package:watch_queue/res/database/dbmodel.dart';
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
  List nameList = [];
  List dateList = [];
  List releaseList = []; //movie released date
  List imgList = [];
  List statusList = []; //is movie watched or not
  ReadDate readDate = ReadDate();
  DBHandler dbHandler = DBHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        centerTitle: true,
        elevation: 5.0,
        shadowColor: Colors.black12,
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
        future: getTodos(dbHandler),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(
              'Nothing here to show',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w100),
            ));
          } else {
            List<DbModel>? todos = snapshot.data;
            for (var todo in todos!) {
              imdbIdList.add(todo.id);
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
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
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
                              setState(() {
                                dbHandler.delete(imdbIdList[index]);
                                imdbIdList.clear();
                                nameList.clear();
                                dateList.clear();
                                imgList.clear();
                                releaseList.clear();
                                statusList.clear();
                                getTodos(dbHandler);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('${nameList[index]} deleted')),
                              );
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
                              name: nameList[index],
                              date: dateList[index],
                              img: imgList[index],
                              release: releaseList[index],
                              status: statusList[index],
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

  Future<List<DbModel>> getTodos(DBHandler dbHandler) async {
    return dbHandler.getTodos();
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
  setState(() {

  });

  }
}
