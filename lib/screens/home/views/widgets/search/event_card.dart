import 'package:flutter/material.dart';
import 'package:p/screens/home/views/widgets/search/search_model.dart';

class EventCard extends StatelessWidget {
   EventCard({super.key,required this.searchItem});
  Search searchItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 20, left: 20, top: 8, bottom: 8),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                searchItem.img,
                width: 100,
                height: 80,
                fit: BoxFit.fill,
              )),
          SizedBox(
            width: 15,
          ),
          Text(searchItem.name),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                searchItem.category,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
