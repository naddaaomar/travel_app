import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:p/helpers/themes/colors.dart';

class PriceContainer extends StatefulWidget {

  final void Function(RangeValues priceRange, String? priceOrder) onDone;
  final String? initialOrder;

  const PriceContainer({
    super.key,
    required this.onDone,
    this.initialOrder,
  });

  @override
  _PriceContainerState createState() => _PriceContainerState();
}

class _PriceContainerState extends State<PriceContainer> {
  late String? _selectedOrder;

  @override
  void initState() {
    super.initState();
    _selectedOrder = widget.initialOrder ?? 'Descending';
  }
  RangeValues _currentRangeValues =
  RangeValues(200, 600);
  double minPrice = 100;
  double maxPrice = 700;



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.3),
            blurRadius: 6,
            spreadRadius: 260,
            offset: const Offset(0, 277),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price range",
            style: TextStyle(
                fontFamily: "pop",
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("EGP ${_currentRangeValues.start.toStringAsFixed(0)}"),
              Text("EGP ${_currentRangeValues.end.toStringAsFixed(0)}"),
            ],
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: minPrice,
            max: maxPrice,
            activeColor: Color(0xff9A1A00),
            inactiveColor: ColorApp.primaryColor.withOpacity(0.3),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Price Order",
            style: TextStyle(
                fontFamily: "pop", fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PriceOrder(
                txt: "Descending",
                isSelected: _selectedOrder == "Descending",
                onTap: () {
                  setState(() {
                    _selectedOrder = "Descending";
                  });
                },
              ),
              PriceOrder(
                txt: "Ascending",
                isSelected: _selectedOrder == "Ascending",
                onTap: () {
                  setState(() {
                    _selectedOrder = "Ascending";
                  });
                },
              )
            ],
          ),
          Text(
            "Default : Descending",
            style: TextStyle(
                fontFamily: "pop",
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // CLEAR button with gradient border
              Container(
                height: 40,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: GradientBoxBorder(
                    width: 2,
                    gradient: const LinearGradient(
                      colors: [Color(0xffE3AE94), Color(0xffFF2B00)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOrder = "Descending";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    "Clear",
                    style: TextStyle(
                      fontFamily: "pop",
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Color(0xffE3AE94), Color(0xffFF2B00)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onDone(_currentRangeValues,_selectedOrder);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontFamily: "pop",
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PriceOrder extends StatelessWidget {
  final String txt;
  final bool isSelected;
  final VoidCallback onTap;

  PriceOrder(
      {super.key,
        required this.txt,
        required this.isSelected,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? Colors.transparent : Color(0xffD67561),
              width: isSelected ? 2 : 2),
          color: isSelected
              ? Color(0xffD67561)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          txt,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black, fontSize: 13),
        ),
      ),
    );
  }
}