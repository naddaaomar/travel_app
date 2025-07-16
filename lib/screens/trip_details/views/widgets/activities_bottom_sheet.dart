import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';

class ActivitiesBottomSheet extends StatefulWidget {
  final List<Itineraries>? itenraries;

  const ActivitiesBottomSheet({super.key, required this.itenraries});

  @override
  State<ActivitiesBottomSheet> createState() => _ActivitiesBottomSheetState();
}

class _ActivitiesBottomSheetState extends State<ActivitiesBottomSheet> {
  int selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedDay = widget.itenraries?[selectedDayIndex];

    return Container(
      height: MediaQuery.of(context).size.height*.56,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
      decoration: BoxDecoration(
        color: ColorApp.secondaryColor,

        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Center(
            child: Text(
              "Activities",
              style: TextStyle(fontFamily: "vol", fontSize: 18),
            ),
          ),
          SizedBox(height: 15),

          // Horizontal Day Selector Bar
          SizedBox(
            height: 40,
            child: widget.itenraries!.length <= 4
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.itenraries!.length, (index) {
                final day = widget.itenraries![index];
                final isSelected = index == selectedDayIndex;

                return GestureDetector(
                  onTap: () => setState(() => selectedDayIndex = index),
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorApp.primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Day ${day.dayNumber}",
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontFamily: "pop",
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }),
            )
                : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.itenraries!.length,
              itemBuilder: (context, index) {
                final day = widget.itenraries![index];
                final isSelected = index == selectedDayIndex;

                return GestureDetector(
                  onTap: () => setState(() => selectedDayIndex = index),
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorApp.primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Day ${day.dayNumber}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontFamily: "pop",
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
          ,

          SizedBox(height: 20),

          // Selected Day Content
          Expanded(
            child: SingleChildScrollView(
              child: _buildDayContent(selectedDay),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayContent(Itineraries? day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          day!.title ?? '',
          style: TextStyle(
              fontFamily: "pop", fontWeight: FontWeight.bold, fontSize: 16),
        ),

        SizedBox(height: 8),

        // Time & Location
        Text("${day!.startTime} → ${day!.endTime}",
            style: TextStyle(color: Colors.black54)),
        if (day!.location != null)
          Text("📍 ${day!.location}", style: TextStyle(color: Colors.black54)),

        SizedBox(height: 8),

        // Meals
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (day!.includesBreakfast!) _MealChip(label: "Breakfast 🍳"),
            if (day!.includesLunch!) _MealChip(label: "Lunch 🍔"),
            if (day!.includesDinner!) _MealChip(label: "Dinner 🍽️"),
          ],
        ),

        SizedBox(height: 10),

        // Activities
        ...?day!.activities?.map((activity) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: [
              Icon(Icons.circle, size: 8, color: Colors.black45),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  activity,
                  style: TextStyle(fontSize: 13, fontFamily: "pop"),
                ),
              )
            ],
          ),
        )),

        // Notes
        if ((day!.notes?.isNotEmpty ?? false)) ...[
          SizedBox(height: 10),
          Text("📝 Notes",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "pop")),
          SizedBox(height: 4),
          Text(
            day!.notes!,
            style: TextStyle(fontSize: 13, fontFamily: "pop"),
          )
        ]
      ],
    );
  }
}

class _MealChip extends StatelessWidget {
  final String label;

  const _MealChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ColorApp.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorApp.primaryColor, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontFamily: "pop"),
      ),
    );
  }
}
