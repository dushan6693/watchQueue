import 'package:flutter/material.dart';
import 'package:watch_queue/models/Movie.dart';
import 'package:watch_queue/read_date.dart';
import 'package:watch_queue/res/database/dbhandler.dart';
import 'package:watch_queue/res/database/todos_model.dart';
import 'package:watch_queue/res/database/version_model.dart';

class ViewPost extends StatefulWidget {
  final String movieId;
  const ViewPost({
    super.key,
    required this.movieId,
  });

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  bool isAdded = false;
  ReadDate readDate = ReadDate();
  DBHandler dbHandler = DBHandler();
  final String _apiKey = '84a39093';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchDetailsWithStatus(_apiKey, widget.movieId, dbHandler),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Details not found',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3) ,fontSize: 18.0, fontWeight: FontWeight.w100,),
            ));
          } else {
            Movie? movie = snapshot.data![0];
            isAdded = snapshot.data![1];

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          color: Theme.of(context).colorScheme.surfaceContainerHigh,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 170.0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(4.0),bottomLeft: Radius.circular(4.0)),
                                  child: AspectRatio(
                                    aspectRatio: 100.0 / 170.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  NetworkImage(movie!.poster))),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Table(
                                    columnWidths: const {
                                      0: FixedColumnWidth(100.0),
                                      1: FlexColumnWidth(1.0),
                                    },
                                    children: [
                                      TableRow(children: [
                                         Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            'Type :',
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Card(
                                            margin: EdgeInsets.zero,
                                            color: movie.type == 'movie'
                                                ? Colors.green.shade700
                                                : Colors.red.shade400,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.only(topRight: Radius.circular(4.0))),
                                            child: Center(
                                              child: Text(
                                                movie.type,
                                                style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onPrimary,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                         Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            'Year :',
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            movie.year,
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                         Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            'Released :',
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            movie.released,
                                            style:  TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                         Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            'Rated :',
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            movie.rated,
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                         Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            'Runtime :',
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            movie.runtime,
                                            style:  TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                         Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            'Languages :',
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            movie.language,
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.normal),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                         Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            'Votes :',
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            movie.imdbVotes,
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                         Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            'IMDB :',
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Image.asset(
                                                  'lib/assets/images/imdb.png',
                                                  width: 20.0,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                              Text(
                                                movie.imdbRating,
                                                style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                         Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            'Rotten :',
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Image.asset(
                                                  'lib/assets/images/rotten_tomatoes.png',
                                                  width: 20.0,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                              Text(
                                                movie.ratings.length > 1
                                                    ? movie.ratings[1].value
                                                    : 'N/A',
                                                style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHigh
                                ,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      movie.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.copy,
                                        color: Theme.of(context).colorScheme.primary,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Table(
                              columnWidths: const {
                                0: FixedColumnWidth(110.0),
                                1: FlexColumnWidth(1.0),
                              },
                              children: [
                                TableRow(children: [
                                   Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Genre :',
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.genre,
                                      style:  TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                   Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Director :',
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.director,
                                      style:  TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                   Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Writer :',
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.writer,
                                      style:  TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                movie.totalSeasons == '-'
                                    ? TableRow(
                                        children: [Container(), Container()])
                                    : TableRow(children: [
                                         Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'Seasons :',
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            movie.totalSeasons,
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                      ]),
                                TableRow(children: [
                                   Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Country :',
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.country,
                                      style:  TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                   Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'BoxOffice :',
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.boxOffice,
                                      style:  TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                   Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Production :',
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.production,
                                      style:  TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                   Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Awards :',
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.awards,
                                      style:  TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                   Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Plot :',
                                      maxLines: 20,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 25,
                                      movie.plot,
                                      style:  TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60.0,
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Theme.of(context).colorScheme.surface,
                              child: ElevatedButton(
                                onPressed: isAdded
                                    ? null
                                    : () async {
                                        DBHandler dbHandler = DBHandler();
                                        setState(() {
                                          dbHandler.insertTodo(TodosModel(
                                              id: movie.imdbId,
                                              type: movie.type,
                                              name: movie.title,
                                              img: movie.poster,
                                              releaseDate: movie.released,
                                              listedDate: readDate.getDateNow(),
                                              watchStatus: 0));

                                         // dbHandler.incrementVersion('version_id01');//increment version_code on Version table by 1. to update the database status.

                                          isAdded = true;
                                          showToast(
                                              '${movie.type} Added to wishlist',
                                              movie.imdbId);
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isAdded
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.9)
                                      : Theme.of(context).colorScheme.primary,
                                  foregroundColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  shadowColor: Colors.black,
                                  textStyle: const TextStyle(fontSize: 18.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                  padding: const EdgeInsets.only(
                                      left: 50.0,
                                      right: 50.0,
                                      top: 15.0,
                                      bottom: 15.0),
                                ),
                                child: isAdded
                                    ? const Text('Added')
                                    : const Text("Add To Wishlist"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
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

  Future<List<dynamic>> fetchDetailsWithStatus(
      String apiKey, String movieId, DBHandler dbHandler) {
    return Future.wait([
      Movie.fetchDetails(apiKey, movieId),
      checkIsAdded(dbHandler, movieId),
    ]);
  }

  Future<bool> checkIsAdded(DBHandler dbHandler, String imdbId) async {
    bool status = await dbHandler.isAvailable(imdbId);
    return status;
  }

  void showToast(String msg, String id) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        textColor: Theme.of(context).colorScheme.surface,
        onPressed: () {
          setState(() {
            dbHandler.deleteTodo(id);
            isAdded = false;
          });
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
