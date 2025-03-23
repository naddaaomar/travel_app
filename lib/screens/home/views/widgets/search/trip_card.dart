import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/search/search_model.dart';

class TripCard extends StatelessWidget {
   TripCard({super.key,required this.searchItem});
  Search searchItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(right: 20, left: 20, top: 8),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(searchItem.name),
              Text(
                searchItem.tripCategory!,
                style: TextStyle(fontSize: 11),
              ),
              Text(
                searchItem.price!,
                style: TextStyle(
                    fontSize: 12,
                    color: ColorApp.primaryColor),
              )
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                searchItem.category,
                style: TextStyle(fontSize: 12),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade800,
                    size: 17,
                  ),
                  Text(
                    searchItem.rate.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
