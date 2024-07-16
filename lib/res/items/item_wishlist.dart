import 'package:flutter/material.dart';
import 'package:watch_queue/read_date.dart';

class ItemWishList extends StatefulWidget {
  final String name;
  final String date;
  final String release; //movie released date
  final String img;
  final bool status; //is movie watched or not

  const ItemWishList({
    super.key,
    required this.name,
    required this.date,
    required this.release,
    required this.img,
    required this.status,
  });

  @override
  State<ItemWishList> createState() => _ItemWishListState();
}

class _ItemWishListState extends State<ItemWishList> {
  ReadDate readDate = ReadDate();
  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2.0,
      color: Theme.of(context).colorScheme.onSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              widget.img,
              width: 70.0,
              height: 130.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.release,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  readDate.getDuration(widget.date,),
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                widget.status ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.check_circle_rounded,color: Colors.green,),
                ):
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                  ),
                  child: const Text("Mark as watched"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
