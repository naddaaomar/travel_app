import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/search/company_card.dart';
import 'package:p/screens/home/views/widgets/search/event_card.dart';
import 'package:p/screens/home/views/widgets/search/filter_screen.dart';
import 'package:p/screens/home/views/widgets/search/search_model.dart';
import 'package:p/screens/home/views/widgets/search/trip_card.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

class LocationCardNew extends StatefulWidget {
  LocationCardNew({super.key});

  @override
  _LocationCardNewState createState() => _LocationCardNewState();
}

class _LocationCardNewState extends State<LocationCardNew> {
  final TextEditingController controller = TextEditingController();
  final searchController products = ValueNotifier<Map<Search, int>>({});
  final ValueNotifier<bool> isTextFieldEmpty = ValueNotifier<bool>(true);

  final SuggestionsController<Search> suggestions =
      SuggestionsController<Search>();

  final FocusNode focusNode = FocusNode();
  final ValueNotifier<bool> isFieldFocused =
      ValueNotifier<bool>(false); // Track focus state

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      isFieldFocused.value = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    isFieldFocused.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return GestureDetector(
      onTap: () {
        if (focusNode.hasFocus) {
          focusNode.unfocus();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: WillPopScope(
        onWillPop: () async {
          if (focusNode.hasFocus || controller.text.isNotEmpty) {
            controller.clear();
            isTextFieldEmpty.value = true;
            focusNode.unfocus();
            return false;
          }
          return true;
        },
        child: Card(
          color: isLight ? const Color(0xFFD7D1D1) : const Color(0xFF8C8282),
          elevation: 3,
          shadowColor:
              isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
          child: Column(
            children: [
              TypeAheadField<Search>(
                hideKeyboardOnDrag: true,
                direction: VerticalDirection.down,
                controller: controller,
                focusNode: focusNode,
                builder: (context, controller, focusNode) => TextField(
                  cursorColor: ColorApp.primaryColor,
                  controller: controller,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      isTextFieldEmpty.value = true;
                    } else {
                      isTextFieldEmpty.value = false;
                    }
                  },
                  focusNode: focusNode,
                  autofocus: false,
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(fontStyle: FontStyle.italic),
                  decoration: InputDecoration(
                    fillColor: isLight
                        ? const Color(0xFFD7D1D1)
                        : const Color(0xFF8C8282),
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    suffixIcon: Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: isLight
                              ? ColorApp.primaryColor
                              : ColorApp.primaryColorDark,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {},
                          child: const Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 0),
                    border: const OutlineInputBorder(),
                    hintText: "Where to ?",
                    hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:
                              isLight ? const Color(0xFF787474) : Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                decorationBuilder: (context, child) => Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Material(
                    color: Colors.white,
                    type: MaterialType.canvas,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: child,
                  ),
                ),
                itemBuilder: (context, Search searchItem) {
                  switch (searchItem.category) {
                    case "Trip":
                      return TripCard(searchItem: searchItem);

                    case "Company":
                      return CompanyCard(searchItem: searchItem);

                    case "Event":
                      return EventCard(searchItem: searchItem);

                    default:
                      return ListTile(
                        leading: Icon(Icons.help_outline),
                        title: Text("Unknown Category"),
                      );
                  }
                },
                hideOnSelect: true,
                hideOnEmpty: false,
                hideOnUnfocus: false,
                hideWithKeyboard: false,
                retainOnLoading: true,
                hideOnLoading: false,
                emptyBuilder: (context) {
                  if (!focusNode.hasFocus)
                    return SizedBox.shrink(); // Hide when the widget is closed

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    child: Text(
                      controller.text.isEmpty
                          ? "Start typing to search"
                          : "No search result is found",
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                },
                itemSeparatorBuilder: (context, index) => const Divider(
                  color: ColorApp.primaryColor,
                ),
                onSelected: onSuggestionSelected,
                suggestionsCallback: suggestionsCallback,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ValueListenableBuilder<bool>(
                  valueListenable: isFieldFocused,
                  builder: (context, isFocused, child) {
                    return isFocused
                        ? _buildFilters()
                        : const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dummy filters UI
  Widget _buildFilters() {
    return Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilterScreen(),
                    ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorApp.primaryColor),
                child: Text(
                  "Filter",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }

  Widget _filterChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: ColorApp.primaryColor,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  void onSuggestionSelected(Search product) {
    products.value = Map.of(
      products.value
        ..update(
          product,
          (value) => value + 1,
          ifAbsent: () => 1,
        ),
    );
    controller.clear();
  }

  Future<List<Search>> suggestionsCallback(String pattern) async {
    if (pattern.isEmpty) {
      return [];
    }
    return Future<List<Search>>.delayed(
      Duration(milliseconds: 300),
      () => allSearch.where((product) {
        final nameLower = product.name.toLowerCase().split(' ').join('');
        final patternLower = pattern.toLowerCase().split(' ').join('');
        return nameLower.contains(patternLower);
      }).toList(),
    );
  }
}
