import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/search/company_card.dart';
import 'package:p/screens/home/views/widgets/search/event_card.dart';
import 'package:p/screens/home/views/widgets/search/search_model.dart';
import 'package:p/screens/home/views/widgets/search/trip_card.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

import '../../../../tabs/offers/presentation/pages/offers_screen.dart';

class FilteringAllEtc extends StatefulWidget {
  final String initialText;
  final TextEditingController controller;

  FilteringAllEtc({super.key, required this.initialText})
      : controller = TextEditingController(text: initialText);

  @override
  State<FilteringAllEtc> createState() => _FilteringAllEtcState();
}

class _FilteringAllEtcState extends State<FilteringAllEtc> {
  late final TextEditingController controller;
  final searchController = ValueNotifier<Map<Search, int>>({});
  final ValueNotifier<bool> isTextFieldEmpty = ValueNotifier<bool>(true);
  final ValueNotifier<List<Search>> currentSuggestions = ValueNotifier([]);
  final ValueNotifier<bool> showMessage = ValueNotifier<bool>(false);
  final ValueNotifier<String> selectedCategory = ValueNotifier<String>('All');
  final ValueNotifier<List<Search>> filteredResults =
      ValueNotifier<List<Search>>([]);
  final FocusNode focusNode = FocusNode();
  final ValueNotifier<bool> isFieldFocused = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialText);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialText.isNotEmpty) {
        isTextFieldEmpty.value = false;
        filterResults(widget.initialText, selectedCategory.value);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            "Refine Your Search",
            style: TextStyle(fontFamily: "pop", fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [],
              ),
              Card(
                color:
                    isLight ? const Color(0xFFD7D1D1) : const Color(0xFF8C8282),
                elevation: 3,
                shadowColor:
                    isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r)),
                child: TextField(
                  cursorColor: ColorApp.primaryColor,
                  controller: widget.controller,
                  focusNode: focusNode,
                  onChanged: (value) {
                    isTextFieldEmpty.value = value.isEmpty;
                    filterResults(value, selectedCategory.value);
                  },
                  autofocus: false,
                  style: TextStyle(
                      fontFamily: "pop", color: Colors.black, fontSize: 12),
                  decoration: InputDecoration(
                    fillColor: isLight
                        ? const Color(0xFFD7D1D1)
                        : const Color(0xFF8C8282),
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    suffixIcon: ValueListenableBuilder<bool>(
                      valueListenable: isFieldFocused,
                      builder: (context, isFocused, child) {
                        return Material(
                          type: MaterialType.transparency,
                          child: Ink(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isLight
                                  ? ColorApp.primaryColor
                                  : ColorApp.primaryColorDark,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10.r),
                              onTap: () {},
                              child:
                                  const Icon(Icons.search, color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 0),
                    border: const OutlineInputBorder(),
                    hintText: "Start typing to search...",
                    label: Text(
                      "Where to ?",
                      style: TextStyle(
                        fontFamily: "pop",
                        color: isLight ? const Color(0xFF787474) : Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:
                              isLight ? const Color(0xFF787474) : Colors.white,
                          fontSize: 13.sp,
                          fontFamily: "pop",
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DefaultTabController(
                length: 4,
                child: TabBar(
                  onTap: (index) {
                    List<String> categories = [
                      'All',
                      'Travel',
                      'Event',
                      'Company'
                    ];
                    selectedCategory.value = categories[index];
                    filterResults(
                        widget.controller.text, selectedCategory.value);
                  },
                  padding: EdgeInsets.zero,
                  dividerColor: Colors.grey,
                  indicatorWeight: 4,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: ColorApp.primaryColor,
                  dragStartBehavior: DragStartBehavior.start,
                  labelColor: ColorApp.primaryColor,
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  labelStyle: TextStyle(color: Colors.black),
                  unselectedLabelColor: Colors.black,
                  labelPadding: EdgeInsets.symmetric(horizontal: 18),
                  splashBorderRadius: BorderRadius.circular(100),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          states.contains(MaterialState.hovered) ||
                          states.contains(MaterialState.focused)) {
                        return ColorApp.primaryColor.withOpacity(0.1);
                      }
                      return null;
                    },
                  ),
                  tabs: [
                    Text(
                      "All",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Travel",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Event",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Company",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ValueListenableBuilder<List<Search>>(
                  valueListenable: filteredResults,
                  builder: (context, results, _) {
                    if (widget.controller.text.isEmpty) {
                      return Center(
                          child: Text(
                        "Field is empty",
                        style: TextStyle(
                            fontFamily: "pop",
                            fontSize: 12,
                            color: Colors.black54),
                      ));
                    }

                    if (results.isEmpty) {
                      return Center(
                          child: Text(
                        "No results found",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontFamily: "pop"),
                      ));
                    }

                    return LiveList(
                      separatorBuilder: (context, index) => FadeInUp(
                        child: Divider(
                          color: Colors.black54,
                          height: 2,
                          endIndent: 20,
                          indent: 20,
                        ),
                      ),
                        showItemInterval: Duration(milliseconds: 150),
                        showItemDuration: Duration(milliseconds: 350),
                        reAnimateOnVisibility: false,
                        scrollDirection: Axis.vertical,
                        itemCount: results.length,
                        itemBuilder: animationItemBuilder(
                          (index) {
                            final item = results[index];
                            switch (item.category) {
                              case 'Travel':
                                return TripCard(searchItem: item);
                              case 'Company':
                                return CompanyCard(searchItem: item);
                              case 'Event':
                                return EventCard(searchItem: item);
                              default:
                                return ListTile(
                                    title: Text("Unknown Category"));
                            }
                          },
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void filterResults(String query, String category) {
    final normalizedQuery = query.toLowerCase().replaceAll(' ', '');

    final results = allSearch.where((search) {
      final matchCategory = category == 'All' || search.category == category;
      final matchQuery = search.name
          .toLowerCase()
          .replaceAll(' ', '')
          .contains(normalizedQuery);
      return matchCategory && matchQuery;
    }).toList();

    filteredResults.value = results;
  }
}
