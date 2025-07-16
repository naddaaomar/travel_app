import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class IncludedBottomSheet extends StatelessWidget {
  final List<dynamic>? includedItems;

  const IncludedBottomSheet({super.key, required this.includedItems});

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
            Text("Included", style: TextStyle(fontFamily: "vol", fontSize: 16)),
            SizedBox(height: 10),
            ...?includedItems?.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: ColorApp.primaryColor, size: 18),
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
