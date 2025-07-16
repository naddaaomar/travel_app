import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class NotIncludedBottomSheet extends StatelessWidget {
  final List<dynamic>? notIncludedItems;

  const NotIncludedBottomSheet({super.key, required this.notIncludedItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorApp.secondaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Not Included", style: TextStyle(fontFamily: "vol", fontSize: 16)),
            SizedBox(height: 10),
            ...?notIncludedItems?.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  Icon(Icons.cancel, color: Colors.redAccent, size: 18),
                  SizedBox(width: 10),
                  Expanded(child: Text(e, style: TextStyle(fontFamily: "pop", fontSize: 13))),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
