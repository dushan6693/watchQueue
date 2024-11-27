import 'package:flutter/material.dart';
import 'package:watch_queue/res/items/item_search.dart';
import '../models/Movies.dart';
import '../res/database/shared_prefs.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List _nameList = [];
  final List _idList = [];
  final List _yearList = [];
  final List _ratingList = [];
  final List _imgList = [];
  final List _typeList = [];
  final String _apiKey = '84a39093';
  final _searchController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  maxLines: 1,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  decoration: const InputDecoration(
                    hintText: 'Search here',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search,color: Theme.of(context).colorScheme.onSurface,),
                onPressed: () {
                  setState(() {
                    requestData(_searchController.text,true);
                  });
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: requestData(_searchController.text,false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Search something to show...',style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),fontSize: 18.0,fontWeight: FontWeight.w100),));
            } else {
              List<Movies>? movies = snapshot.data;
              for (var movie in movies!) {
                _nameList.add(movie.title);
                _idList.add(movie.imdbID);
                _yearList.add(movie.year);
                _imgList.add(movie.poster);
                _ratingList.add(movie.imdbRating);
                _typeList.add(movie.type);
              }
              return Column(
                children: [
                  Expanded(
                    child: GridView(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 10 / 19.5,
                        crossAxisSpacing: 0.5,
                        mainAxisSpacing: 0.5,
                      ),
                      padding: const EdgeInsets.all(2.0),
                      children: [
                        for (var index = 0; index < _nameList.length; index++)
                          ItemSearch(
                            img: _imgList[index],
                            name: _nameList[index],
                            id: _idList[index],
                            rating: _ratingList[index],
                            year: _yearList[index],
                            type: _typeList[index],
                          )
                      ],
                    ),
                  ),
                ],
              );
            }


          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Future<List<Movies>> requestData(String request, bool pressed) async {
    await SharedPrefs().init();
    _nameList.clear();
    _idList.clear();
    _yearList.clear();
    _imgList.clear();
    _ratingList.clear();
    _typeList.clear();

    if (request != '') {
      SharedPrefs().saveString('search_data', request);
      Future<List<Movies>> movies = Movies.fetchAllMovies(_apiKey, request);
      return movies;
    }else{
      if(!pressed){
        String? searchText = SharedPrefs().getString('search_data');
        if(searchText!=''){
          _searchController.text=searchText!;
          Future<List<Movies>> movies = Movies.fetchAllMovies(_apiKey, searchText);
          return movies;
        }
      }else{
        SharedPrefs().saveString('search_data', '');
      }

    }
    return Future.error("future list<movie> not found");
  }
}
