import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watch_queue/models/Movie.dart';
import 'package:watch_queue/read_date.dart';
import 'package:watch_queue/res/database/dbhandler.dart';
import 'package:watch_queue/res/database/dbmodel.dart';

class ViewPost extends StatefulWidget {
  final String movieId;
  const ViewPost({
    super.key,
    required this.movieId,
  });

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost>{
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
            print(snapshot.error);
            return const Center(
                child: Text(
              'Movie details not found',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w100),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 170.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
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
                                      const Padding(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(
                                          'Type :',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          color: movie.type=='movie'?Colors.green.shade100: Colors.red.shade100,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                                          child: Text(
                                            movie.type,
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      const Padding(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(
                                          'Year :',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          movie.year,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      const Padding(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(
                                          'Released :',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          movie.released,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      const Padding(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(
                                          'Rated :',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          movie.rated,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      const Padding(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(
                                          'Runtime :',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          movie.runtime,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      const Padding(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(
                                          'Languages :',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          movie.language,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          'Votes :',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          movie.imdbVotes,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      const Padding(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(
                                          'IMDB :',
                                          style: TextStyle(
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
                                              style: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                  FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          'Rotten :',
                                          style: TextStyle(
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
                                              style: const TextStyle(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: ColoredBox(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    movie.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.copy,
                                        color: Colors.grey,
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
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Genre :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.genre,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Director :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.director,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Writer :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.writer,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                movie.totalSeasons=='-'?TableRow(children: [Container(),Container()]):
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Seasons :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.totalSeasons,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Country :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.country,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'BoxOffice :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.boxOffice,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Production :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.production,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Awards :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      movie.awards,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Plot :',
                                      maxLines: 20,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
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
                                      style: const TextStyle(
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
                            child: ElevatedButton(
                              onPressed: isAdded
                                  ? null
                                  : () async {
                                      DBHandler dbHandler = DBHandler();
                                      setState(() {
                                        dbHandler.insert(DbModel(
                                            id: movie.imdbId,
                                            name: movie.title,
                                            img: movie.poster,
                                            releaseDate: movie.released,
                                            listedDate: readDate.getDateNow(),
                                            watchStatus: 0));
                                        isAdded = true;
                                        showToast('Added to wishlist');
                                      });
                                    },
                              style: FilledButton.styleFrom(
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
                                    borderRadius: BorderRadius.circular(8.0)),
                                padding: const EdgeInsets.only(
                                    left: 50.0,
                                    right: 50.0,
                                    top: 15.0,
                                    bottom: 15.0),
                              ),
                              child: isAdded
                                  ? const Text('Added')
                                  : const Text("add to wishlist"),
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
void showToast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

}
