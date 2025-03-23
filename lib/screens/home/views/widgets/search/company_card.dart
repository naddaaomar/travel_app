import 'package:flutter/material.dart';
import 'package:p/screens/home/views/widgets/search/search_model.dart';

class CompanyCard extends StatelessWidget {
   CompanyCard({super.key,required this.searchItem});
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
          Text(searchItem.name),
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
