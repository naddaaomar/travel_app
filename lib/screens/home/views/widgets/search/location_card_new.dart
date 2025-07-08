import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/search/company_card.dart';
import 'package:p/screens/home/views/widgets/search/event_card.dart';
import 'package:p/screens/home/views/widgets/search/filter_screen.dart';
import 'package:p/screens/home/views/widgets/search/filtering_all_etc.dart';
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
  final ValueNotifier<List<Search>> currentSuggestions = ValueNotifier([]);
  final ValueNotifier<bool> showMessage = ValueNotifier<bool>(false);
  final SuggestionsController<Search> suggestions =
  SuggestionsController<Search>();

  final FocusNode focusNode = FocusNode();
  final ValueNotifier<bool> isFieldFocused = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      isFieldFocused.value = focusNode.hasFocus;

      if (!focusNode.hasFocus && controller.text.isNotEmpty) {
        controller.clear();
        isTextFieldEmpty.value = true;
      }
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

    return WillPopScope(
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
        child: TypeAheadField<Search>(
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
            style:
            TextStyle(fontFamily: "pop", color: Colors.black, fontSize: 12),
            decoration: InputDecoration(
              fillColor:
              isLight ? const Color(0xFFD7D1D1) : const Color(0xFF8C8282),
              filled: true,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              suffixIcon: ValueListenableBuilder<bool>(
                valueListenable: isFieldFocused,
                builder: (context, isFocused, child) {
                  return isFocused
                      ? InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilteringAllEtc(
                              initialText: controller.text,
                            ),
                          ));
                    },
                    child: Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: isLight
                              ? ColorApp.primaryColor
                              : ColorApp.primaryColorDark,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.tune_sharp,
                                color: Colors.white, size: 24)
                          ],
                        ),
                      ),
                    ),
                  )
                      : Material(
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
                color: isLight ? const Color(0xFF787474) : Colors.white,
                fontSize: 13.sp,
                fontFamily: "pop",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          itemSeparatorBuilder: (context, index) => Divider(
            color: Colors.black54,
            height: 2,
            endIndent: 20,
            indent: 20,
          ),
          decorationBuilder: (context, child) {
            return ValueListenableBuilder<List<Search>>(
              valueListenable: currentSuggestions,
              builder: (context, suggestions, _) {
                if (controller.text.isNotEmpty && suggestions.isEmpty) {
                  if (!showMessage.value) {
                    showMessage.value = true;
                    Future.delayed(Duration(milliseconds: 2500), () {
                      showMessage.value = false;
                    });
                  }

                  return ValueListenableBuilder<bool>(
                    valueListenable: showMessage,
                    builder: (context, isVisible, _) {
                      if (isVisible) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 7),
                            child: Text(
                              "No search result is found",
                              style: const TextStyle(
                                  fontSize: 12, fontFamily: "pop"),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                }

                return (focusNode.hasFocus && controller.text.isNotEmpty)
                    ? Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54.withOpacity(.2),
                        spreadRadius: 500,
                        blurRadius: 10,
                        offset: Offset(0, 500),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: child,
                )
                    : SizedBox.shrink();
              },
            );
          },
          itemBuilder: (context, Search searchItem) {
            switch (searchItem.category) {
              case "Travel":
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
            return ValueListenableBuilder<List<Search>>(
              valueListenable: currentSuggestions,
              builder: (context, suggestions, _) {
                if (controller.text.isNotEmpty && suggestions.isEmpty) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    child: Text(
                      "No search result is found",
                      style: const TextStyle(fontSize: 12, fontFamily: "pop"),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
          onSelected: onSuggestionSelected,
          suggestionsCallback: suggestionsCallback,
        ),
      ),
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
      currentSuggestions.value = [];
      return [];
    }

    final results = allSearch.where((product) {
      final nameLower = product.name.toLowerCase().replaceAll(' ', '');
      final patternLower = pattern.toLowerCase().replaceAll(' ', '');
      return nameLower.contains(patternLower);
    }).toList();

    currentSuggestions.value = results;
    return results;
  }
}