import 'package:flutter/material.dart';
import '../../view_post.dart';
import '../database/dbhandler.dart';

class ItemSearch extends StatelessWidget {
  final String name;
  final String id;
  final String year;
  final String rating; //movie released date
  final String img;

  const ItemSearch({
    super.key,
    required this.name,
    required this.id,
    required this.year,
    required this.rating,
    required this.img,
  });
  @override
  Widget build(BuildContext context) {
    DBHandler dbHandler = DBHandler();
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewPost(
                    movieId: id,
                  )),
        );
      },
      child: Card(
          elevation: 2.0,
          color: Theme.of(context).colorScheme.onSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                child: AspectRatio(
                  aspectRatio: 100.0 / 150.0,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(img))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(year),
                    Text(rating),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
